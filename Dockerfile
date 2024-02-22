ARG TAG=9
FROM haskell:${TAG} as build
COPY keter /build
WORKDIR /build
RUN <<EOF
# build keter
cabal update
cabal install
mkdir -p bin
cp -f ~/.local/bin/keter bin
EOF
