ARG TAG=9
FROM haskell:${TAG} as build
RUN apt-get update && apt-get install -y \
    postgresql \
    curl \
    rsync
COPY keter /build
WORKDIR /build
RUN cabal update \
 && cabal install \
 && mkdir -p bin \
 && cp -f ~/.cabal/bin/keter bin
