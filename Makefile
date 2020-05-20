DOCKER_ORG	?= quay.io/enmasse
TAG ?= latest


all: docker_build docker_tag docker_push

docker_build:
	if [ -f Dockerfile ]; then docker build --build-arg version=$(VERSION) -t enmasse-test-container:$(TAG) . ; fi
	docker images | grep enmasse-test-container

docker_push:
	docker push $(DOCKER_ORG)/enmasse-test-container:$(TAG)

docker_tag:
	docker tag enmasse-test-container:$(TAG) $(DOCKER_ORG)/enmasse-test-container:$(TAG)


.PHONY: docker_build docker_tag docker_push