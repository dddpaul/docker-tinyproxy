.PHONY: all build release

IMAGE=dddpaul/tinyproxy
VERSION=1.10.0-2.1

all: build

build:
	@docker build --tag=${IMAGE} .

debug:
	@docker run -it --entrypoint=sh ${IMAGE}

release: build
	@docker build --tag=${IMAGE}:${VERSION} .

deploy: release
	@docker push ${IMAGE}
	@docker push ${IMAGE}:${VERSION}
