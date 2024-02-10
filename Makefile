.PHONY: build
build:
	docker build --push -t tkgling/github-runner:node20.11.0 .

.PHONY: buildx
buildx:
	docker buildx build --push --platform=linux/amd64,linux/arm64 -t tkgling/github-runner:node20.11.0 .

.PHONY: buildx-base
buildx-base:
	docker buildx build --push --platform=linux/amd64,linux/arm64 -t tkgling/github-runner:base base