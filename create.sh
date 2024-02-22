#!/usr/bin/env zsh
source env
echo using stack image with tag ${IMAGE_TAG}
docker build --build-arg TAG=${IMAGE_TAG} -t build-keter .
docker create --name build-keter build-keter
rm -rf bin
docker cp build-keter:/build/bin $PWD/bin
docker rm -f build-keter
echo copied /build/bin to $PWD/bin
