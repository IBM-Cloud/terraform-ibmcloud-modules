## Docker image naming; overridable by environment
TESTDIR ?= $(PWD)
NONE_IMAGES ?=  $(docker images --filter "dangling=true" -q --no-trunc)
IMAGE_NAME ?= terraform-ibmcloud-modules
IMAGE_VERSION_LATEST ?= latest

## Environment configuration file
ENVIRONMENT_DIR = ./environments
ENVIRONMENT ?= staging
ENVIRONMENT_FILE = $(ENVIRONMENT_DIR)/$(ENVIRONMENT).env

DOCKER_RUN_ENV_CMDLINE_ARGUMENTS ?= --env IBMCLOUD_API_KEY=${IBMCLOUD_API_KEY}\
									--env-file $(ENVIRONMENT_FILE)


default: docker-build run-tests

docker-build:
	@echo 'Build a container'
	echo "${DOCKER_PASSWORD}" | docker login -u ${DOCKER_USERNAME} --password-stdin
	docker build . -t ${IMAGE_NAME}:${IMAGE_VERSION_LATEST}

run-tests: $(ENVIRONMENT_FILE)
	@echo 'Run some tests!!!'
	docker run ${DOCKER_RUN_ENV_CMDLINE_ARGUMENTS} -v `pwd`:/terraform-ibmcloud-modules ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} gotestsum --format testname ./test/...

container-shell: $(ENVIRONMENT_FILE)
	docker run -it ${DOCKER_RUN_ENV_CMDLINE_ARGUMENTS} ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} bash

clean-docker:
	docker rmi -f $(IMAGE_NAME):${IMAGE_VERSION_LATEST}

.PHONY: all
