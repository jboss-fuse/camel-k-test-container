REPOSITORY	?= quay.io/jbouska
TAG ?= latest
CONTAINER_NAME = camel-k-test-container

.PHONY: all
all: build push

.PHONY: build
build:
	docker build -t $(REPOSITORY)/$(CONTAINER_NAME):$(TAG) .

.PHONY: push
push:
	docker push $(REPOSITORY)/$(CONTAINER_NAME):$(TAG)
