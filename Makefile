COMPOSE_RUN_TERRAFORM = docker-compose run --rm tf
COMPOSE_RUN_BASH = docker-compose run --rm --entrypoint bash tf
COMPOSE_RUN_AWS = docker-compose run --rm --entrypoint aws tf

# .PHONY: build_push
# build_push: build push

.PHONY: build
build:  
		./scripts/build_container.sh

.PHONY: push
push:   
		./scripts/push_container.sh
