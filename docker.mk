docker.mk: ;

CONTAINER = b-cont
IMAGE     = b-env

build:
	docker build --platform linux/amd64 -t $(IMAGE) .

up: build
	docker run --platform linux/amd64 -v ".:/work" -w /work --name $(CONTAINER) -d $(IMAGE)

down:
	docker rm -f $(CONTAINER)

run:
	docker exec -it $(CONTAINER) zsh

%: .FORCE
	docker exec $(CONTAINER) make $@

.FORCE:
.PHONY: build up down run .FORCE
