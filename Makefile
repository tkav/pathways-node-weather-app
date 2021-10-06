COMPOSE_RUN_TERRAFORM = docker-compose run --rm tf
COMPOSE_RUN_BASH = docker-compose run --rm --entrypoint bash tf
COMPOSE_RUN_AWS = docker-compose run --rm --entrypoint aws

.PHONY: build
build: docker build weather-app-dockerfile

# .PHONY: push
# push: ${COMPOSE_RUN_AWS} ecr get-login-password --region {aws-region} | docker login --username AWS --password-stdin {account-id}.dkr.ecr.{aws-region}.amazonaws.com
