include .env

.PHONY: buildx-node
buildx-node:
	docker buildx build --build-arg NODE_VERSION=${NODE_VERSION} --push --platform=linux/amd64,linux/arm64 -t tkgling/github-runner:node${NODE_VERSION} src/node  --no-cache

.PHONY: buildx-base
buildx-base:
	docker buildx build --push --platform=linux/amd64,linux/arm64 -t tkgling/github-runner:base src/base --no-cache