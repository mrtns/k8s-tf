SHELL:=/bin/bash

PROJECT_NAME:=k8s_tf
PATH_HOST:=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))
PATH_CONTAINER:=/opt/$(PROJECT_NAME)

CONTAINER_IMAGE:=hashicorp/terraform
CONTAINER_TAG:=0.13.4

LOCAL_MINIKUBE_ARGS ?=\
	--mount type=bind,source=$(HOME)/.minikube/ca.crt,target=/minikube/cluster-ca-cert.crt \
	--mount type=bind,source=$(HOME)/.minikube/profiles/minikube/client.crt,target=/minikube/client.crt \
	--mount type=bind,source=$(HOME)/.minikube/profiles/minikube/client.key,target=/minikube/client.key \
	--env TF_VAR_kubernetes_cluster_ca_certificate_path=/minikube/cluster-ca-cert.crt \
	--env TF_VAR_kubernetes_client_certificate_path=/minikube/client.crt \
	--env TF_VAR_kubernetes_client_key_path=/minikube/client.key \
	--env TF_VAR_kubernetes_host=$(shell minikube ip):8443 \
	--env TF_VAR_kubernetes_username=minikube

DOCKER_ARGS ?=\
  $(LOCAL_MINIKUBE_ARGS) \
	--mount type=bind,source=$(PATH_HOST),target=$(PATH_CONTAINER) \
	-w $(PATH_CONTAINER)

.PHONY: init
init:
	@docker run -it \
		--rm \
		$(DOCKER_ARGS) \
		${CONTAINER_IMAGE}:${CONTAINER_TAG} \
		init

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

.PHONY: plan
plan:
	@docker run -it \
		--rm \
		$(DOCKER_ARGS) \
		${CONTAINER_IMAGE}:${CONTAINER_TAG} \
		plan

.PHONY: apply
apply:
	@docker run -it \
		--rm \
		$(DOCKER_ARGS) \
		${CONTAINER_IMAGE}:${CONTAINER_TAG} \
		apply

.PHONY: shell
shell:
	@docker run -it \
		--rm \
		$(DOCKER_ARGS) \
		--entrypoint /bin/bash \
		${CONTAINER_IMAGE}:${CONTAINER_TAG}

.PHONY: exec
exec:
	@docker run -it \
		--rm \
		$(DOCKER_ARGS) \
		${CONTAINER_IMAGE}:${CONTAINER_TAG} \
		${ARGS}

