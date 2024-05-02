#!/usr/bin/env bash
#
# Builds the bulder image from the docker/Dockerfile.builder file for Intel and
# ARM architectures. The image is then pushed to Docker Hub.
# Note that you don't need to run this script for building Nextor ROMs. Only use
# this script if you want to create the builder image yourself.
#
# usage: ./build_builder.sh

set -e

# Change the USER and REPO to your Docker Hub username and repository name
USER=gilbertfrancois
REPO=nextor-builder
VERSION=v1.0.0
IMAGE=${REPO}
BUILDER_CONTAINER_NAME=${REPO}-docker-builder
PLATFORM="linux/amd64,linux/arm64"

if [[ $(docker container ls -a | grep ${BUILDER_CONTAINER_NAME} | wc -l) -eq 1 ]]; then
	echo "Builder container exists, skipping creation."
else
	docker buildx create --name ${BUILDER_CONTAINER_NAME}
	docker buildx use ${BUILDER_CONTAINER_NAME}
	docker buildx inspect --bootstrap
fi
# Create a new builder instance, if not already created
docker buildx build --platform=linux/amd64,linux/arm64 \
	--tag ${USER}/${REPO}:${VERSION} \
	--tag ${USER}/${REPO}:latest \
	-f docker/Dockerfile.builder \
	--push \
	.
