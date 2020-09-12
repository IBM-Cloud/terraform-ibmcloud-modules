## Docker image naming; overridable by environment
TESTDIR ?= $(PWD)
NONE_IMAGES ?=  $(docker images --filter "dangling=true" -q --no-trunc)
IMAGE_NAME ?= terraform-ibmcloud-modules
IMAGE_VERSION_LATEST ?= latest
#IBMCLOUD_IAM_API_ENDPOINT = "https://iam.test.cloud.ibm.com"
#IBMCLOUD_IS_NG_API_ENDPOINT = "us-south-stage01.iaasdev.cloud.ibm.com"
#IBMCLOUD_IS_API_ENDPOINT= "https://us-south-stage01.iaasdev.cloud.ibm.com"
DOCKER_RUN_ENV_CMDLINE_ARGUMENTS ?= --env IBMCLOUD_API_KEY=${IBMCLOUD_API_KEY}\
 									--env IBMCLOUD_IAM_API_ENDPOINT=${IBMCLOUD_IAM_API_ENDPOINT}\
 									--env IBMCLOUD_IS_NG_API_ENDPOINT=${IBMCLOUD_IS_NG_API_ENDPOINT}\
 									--env IBMCLOUD_IS_API_ENDPOINT=${IBMCLOUD_IS_API_ENDPOINT}\
 									--env IBMCLOUD_RESOURCE_MANAGEMENT_API_ENDPOINT=${IBMCLOUD_RESOURCE_MANAGEMENT_API_ENDPOINT}

default: docker-build run-tests

docker-build:
	@echo 'Build a container'
	docker build . -t ${IMAGE_NAME}:${IMAGE_VERSION_LATEST}

run-tests:
	@echo 'Run some tests!!!'
	docker run  ${DOCKER_RUN_ENV_CMDLINE_ARGUMENTS} -v `pwd`:/terraform-ibmcloud-modules ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} gotestsum --format testname --junitfile terratest-output.xml ./test/...

debug-container:
	docker run -it  ${DOCKER_RUN_ENV_CMDLINE_ARGUMENTS} -v `pwd`:/terraform-ibmcloud-modules ${IMAGE_NAME}:${IMAGE_VERSION_LATEST} bash

clean-docker:
	docker rmi -f $(IMAGE_NAME):${IMAGE_VERSION_LATEST}

.PHONY: all
