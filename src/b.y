%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "b.h"

#define ABS(a) (((a) < 0) ? -(a) : (a))

int yylex();
int yyerror(const char*);

static int array_len;

%}

%union {
    int i;
    char *s;
    float f;
}

%token AUTO EXTRN IF CASE WHILE SWITCH GOTO RETURN
%token<i> CST
%token<s> NAME LITERAL
%destructor { free($$); } NAME LITERAL
%nonassoc LOWER_THAN_ELSE
%nonassoc  ELSE
%right '=' EQ_ASSIGN LOWER_ASSIGN NEQ_ASSIGN GREATER_ASSIGN GREATER_EQ_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN LOWER_EQ_ASSIGN ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN BITOR_ASSIGN BITAND_ASSIGN
%right '?' ':'
%left '|'
%left '&'
%nonassoc EQ NEQ
%nonassoc '<' '>' LOWER_EQ GREATER_EQ
%left RIGHT LEFT
%left '+' '-' F_ADD F_SUB
%left '*' '/' '%' F_MUL F_DIV
%right '!' '~' INC DEC UADDR USUB UF_SUB TO_FLOAT TO_INT
%nonassoc '[' '('

%%

program
    : %empty
    | program definition
    ;

definition
    : NAME '[' { global_vector($1); array_len = 0; } vector ';' { emit(""); }
    | NAME ';' { global_int($1, 0); }
    | NAME CST ';' { global_int($1, $2); }
    | NAME LITERAL ';' { global_string($1, $2); free($2); }
    | NAME '(' { fn_decl_enter($1); } arguments ')' statement { emit("leave"); emit("ret"); pop_context(); }
    | NAME '(' { fn_decl_enter($1); } ')' statement { emit("leave"); emit("ret"); pop_context(); }
    ;

vector
	: CST ']' ivals { global_vector_extra($1 - array_len, 0); }
	| CST ']' { global_vector_extra($1, 1); }
    | ']' ivals
    ;

ivals
    : ival { ++array_len; }
    | ivals ',' { ++array_len; emit_raw(", "); } ival 
    ;

ival
    : CST { emit_raw("%d", $1); }
	| NAME { emit_raw("\"%s\"", $1); free($1); }
	;

constant
    : CST { emit("mov eax, %d", $1); }
    | LITERAL {
        int id = get_constant_label();
        emit(".section .rodata");
        emit(".LC%d:", id);
        emit(".long .LC%d + 4", id);
        emit(".string %s", $1);
        emit(".text");
        emit("mov eax, .LC%d", id);
        free($1);
    }
    ;

arguments
    : NAME { argument($1); }
    | arguments ',' NAME { argument($3); }
    ;

statement
    : AUTO auto_names ';' statement
    | EXTRN extrn_names ';' statement
    | NAME ':' { emit("%s:", $1); free($1); } statement
    | SWITCH '(' rvalue ')' { switch_start(); } statement { switch_end(); }
    | CASE CST ':' { case_start($2); } statement { case_end(); }
    | '{' { push_context(); } statements '}' { pop_context(); }
    | '{' '}'
    | if_start statement %prec LOWER_THAN_ELSE {
        emit(".I%d:", get_top_context()->end_label);
        pop_context();
    }
    | if_start statement ELSE {
        get_top_context()->start_label = get_jump_label();
        emit("jmp .I%d", get_top_context()->start_label);
        emit(".I%d:", get_top_context()->end_label);
    } statement {
        emit(".I%d:", get_top_context()->start_label);
        pop_context();
    }
    | WHILE {
        push_context();
        get_top_context()->start_label = get_jump_label();
        emit(".L%d:", get_top_context()->start_label);
    } '(' rvalue ')' {
        get_top_context()->end_label = get_jump_label();
        emit("cmp eax, 0");
        emit("je .L%d", get_top_context()->end_label);
    } statement {
        emit("jmp .L%d", get_top_context()->start_label);
        emit(".L%d:", get_top_context()->end_label);
        pop_context();
    }
    | GOTO NAME ';' { emit("jmp %s", $2); free($2); }
    | RETURN ';' { emit("xor eax, eax"); emit("leave"); emit("ret"); }
    | RETURN '(' rvalue ')' ';' { emit("leave"); emit("ret"); }
    | rvalue ';'
    | ';'
    ;

if_start
    : IF '(' rvalue ')' {
        push_context();
        get_top_context()->end_label = get_jump_label();
        emit("cmp eax, 0");
        emit("je .I%d", get_top_context()->end_label);
    }
    ;

extrn_names
    : NAME { add_extrn_symbol($1); }
    | extrn_names ',' NAME { add_extrn_symbol($3); }
    ;

auto_name
    : NAME { add_auto_symbol($1); emit("push 0"); }
    | NAME constant { add_auto_symbol($1); emit("push eax"); }
    ;

auto_names
    : auto_name
    | auto_names ',' auto_name
    ;

statements
    : statement
    | statements statement
    ;

lvalue
    : '*' postfix
    | postfix '[' {
        emit("push eax");
    } rvalue ']' {
        emit("pop ebx");
        emit("shl eax, 2");
        emit("add eax, ebx");
    }
    | NAME {
        t_symbol *sym = get_symbol($1);
        if (!sym || sym->type == EXTRN_S)
            emit("lea eax, \"%s\"", sym->name);
        else if (((t_symbol_stack *)sym)->stack_offset > 0)
            emit("lea eax, [ebp - %d]",((t_symbol_stack *) sym)->stack_offset);
        else
            emit("lea eax, [ebp + %d]", -((t_symbol_stack *)sym)->stack_offset);
        free($1);
    }
    ;

rvalue
    : unary
    | binary
    | comparison
    | ternary
    | assignation
    ;

unary
    : '&' lvalue %prec UADDR
    | INC lvalue { pre("inc"); }
    | DEC lvalue { pre("dec"); }
    | '-' rvalue %prec USUB { emit("not eax"); emit("inc eax"); }
    | F_SUB rvalue %prec UF_SUB { emit("xor eax, 0x80000000"); }
    | '!' rvalue { emit("push 0"); compare("sete"); }
    | '~' rvalue { emit("NOT eax"); }
    | TO_FLOAT rvalue { to_float(); }
    | TO_INT   rvalue { to_int(); }
    | postfix
    ;

postfix
    : lvalue INC { post("inc"); }
    | lvalue DEC { post("dec"); }
    | lvalue { emit("mov eax, [eax]"); }
    | '(' rvalue ')'
    | constant
    | fncall
    ;

binary
    : rvalue '*'   { emit("push eax"); } rvalue { op_mul(); }
    | rvalue '/'   { emit("push eax"); } rvalue { op_div(); }
    | rvalue '%'   { emit("push eax"); } rvalue { op_mod(); }
    | rvalue '+'   { emit("push eax"); } rvalue { op("add"); }
    | rvalue '-'   { emit("push eax"); } rvalue { op("sub"); }
    | rvalue F_MUL { emit("push eax"); } rvalue { opf("mulss"); }
    | rvalue F_DIV { emit("push eax"); } rvalue { opf("divss"); }
    | rvalue F_ADD { emit("push eax"); } rvalue { opf("addss"); }
    | rvalue F_SUB { emit("push eax"); } rvalue { opf("subss"); }
    | rvalue RIGHT { emit("push eax"); } rvalue { shift("shr"); }
    | rvalue LEFT  { emit("push eax"); } rvalue { shift("shl"); }
    | rvalue '&'   { emit("push eax"); } rvalue { op("and"); }
    | rvalue '|'   { emit("push eax"); } rvalue { op("or"); }
    ;

ternary
    : rvalue '?' {
        push_context();
        get_top_context()->end_label = get_jump_label();
        emit("cmp eax, 0");
        emit("je .I%d", get_top_context()->end_label);
    }  rvalue ':' {
        get_top_context()->start_label = get_jump_label();
        emit("jmp .I%d", get_top_context()->start_label);
        emit(".I%d:", get_top_context()->end_label);
    } rvalue {
        emit(".I%d:", get_top_context()->start_label);
        pop_context();
    }
    ;

comparison
    : rvalue '>'                { emit("push eax"); } rvalue { compare("setg"); }
    | rvalue '<'                { emit("push eax"); } rvalue { compare("setl"); }
    | rvalue EQ                 { emit("push eax"); } rvalue { compare("sete"); }
    | rvalue NEQ                { emit("push eax"); } rvalue { compare("setne"); }
    | rvalue LOWER_EQ           { emit("push eax"); } rvalue { compare("setle"); }
    | rvalue GREATER_EQ         { emit("push eax"); } rvalue { compare("setge"); }
    ;

assignation
    : lvalue '='                { emit("push eax"); } rvalue { emit("pop ebx"); emit("mov [ebx], eax"); }
    | lvalue BITOR_ASSIGN       { emit("push eax"); } rvalue { op_assign("or"); }
    | lvalue BITAND_ASSIGN      { emit("push eax"); } rvalue { op_assign("and"); }
    | lvalue ADD_ASSIGN         { emit("push eax"); } rvalue { op_assign("add"); }
    | lvalue SUB_ASSIGN         { emit("push eax"); } rvalue { op_assign("sub"); }
    | lvalue MUL_ASSIGN         { emit("push eax"); } rvalue { mul_assign(); }
    | lvalue DIV_ASSIGN         { emit("push eax"); } rvalue { div_assign(); }
    | lvalue MOD_ASSIGN         { emit("push eax"); } rvalue { mod_assign(); }
    | lvalue RIGHT_ASSIGN       { emit("push eax"); } rvalue { shift_assign("shr"); }
    | lvalue LEFT_ASSIGN        { emit("push eax"); } rvalue { shift_assign("shl"); }
    | lvalue LOWER_ASSIGN       { emit("push eax"); } rvalue { compare_assign("setl"); }
    | lvalue LOWER_EQ_ASSIGN    { emit("push eax"); } rvalue { compare_assign("setle"); }
    | lvalue GREATER_ASSIGN     { emit("push eax"); } rvalue { compare_assign("setg"); }
    | lvalue GREATER_EQ_ASSIGN  { emit("push eax"); } rvalue { compare_assign("setge"); }
    | lvalue EQ_ASSIGN          { emit("push eax"); } rvalue { compare_assign("sete"); }
    | lvalue NEQ_ASSIGN         { emit("push eax"); } rvalue { compare_assign("setne"); }
    ;

fncall
    : postfix '(' { push_call(); } fnparams ')' { pop_call(); }
    | postfix '(' { push_call(); }          ')' { pop_call(); }
    ;

fnparams
    : rvalue { add_arg(); }
    | fnparams ',' rvalue { add_arg(); }
    ;

%%

int main() {
    int result;

    emit(".intel_syntax noprefix");
    emit(".text");

    do {
        result = yyparse();
    } while (result != 0 && !feof(stdin));
    pop_context();
    return 0;
}

int yyerror(const char* msg) {
    error("%s", msg);
    return 1;
}
