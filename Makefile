SHELL:=/bin/bash

PROJECT_NAME:=k8s_tf
PATH_HOST:=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))
PATH_CONTAINER:=/opt/$(PROJECT_NAME)

CONTAINER_IMAGE:=hashicorp/terraform
CONTAINER_TAG:=0.13.4

DOCKER_ARGS ?=\
	--mount type=bind,source=$(PATH_HOST),target=$(PATH_CONTAINER) \
	-w $(PATH_CONTAINER)

.PHONY: init
init:
	@docker run -it \
		--rm \
		$(DOCKER_ARGS) \
		--entrypoint /bin/sh \
		${CONTAINER_IMAGE}:${CONTAINER_TAG} \
		-c "terraform init"

.PHONY: format
format:
	@docker run -it \
		--rm \
		$(DOCKER_ARGS) \
		${CONTAINER_IMAGE}:${CONTAINER_TAG} \
		fmt -recursive

.PHONY: validate
validate:
	@docker run -it \
		--rm \
		$(DOCKER_ARGS) \
		${CONTAINER_IMAGE}:${CONTAINER_TAG} \
		validate

.PHONY: shell
shell:
	@docker run -it \
		--rm \
		$(DOCKER_ARGS) \
		--entrypoint /bin/sh \
		${CONTAINER_IMAGE}:${CONTAINER_TAG}

