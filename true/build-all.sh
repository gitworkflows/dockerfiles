#!/usr/bin/env bash
set -Eeuo pipefail

dir="$(dirname "$BASH_SOURCE")"
cd "$dir"

make clean
docker build --pull --file Dockerfile.all --tag docker-pkg/true:all .
docker run --rm docker-pkg/true:all sh -c 'tar --create true-*' | tar --extract --verbose
