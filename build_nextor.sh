#!/usr/bin/env bash
#
# Builds the Nextor ROMs using the Docker image gilbertfrancois/nextor-builder:latest
# The ROM artefacts are copied to the dist directory after building.
#
# usage: ./build_nextor.sh

set -e

rm -rf dist
mkdir -p dist

cat <<EOF | docker run --rm --interactive \
	-v $(pwd)/dist:/dist \
	-v $(pwd)/source:/workdir/source \
	gilbertfrancois/nextor-builder:latest \
	/bin/bash
	make -C /workdir/source clean all
    find /workdir/source -name *.ROM | xargs cp -t /dist 
EOF
