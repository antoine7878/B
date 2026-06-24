FROM --platform=linux/amd64 ubuntu:24.04

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential gcc-multilib libc6-dev-i386 \
    binutils bison make flex zsh vim file gdb && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /work

CMD ["sleep", "infinity"]
