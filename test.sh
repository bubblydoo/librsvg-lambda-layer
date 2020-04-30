#!/bin/bash
set -euxo pipefail
base="${FILENAME##*/}"
mkdir -p tmp/test-out
cat $FILENAME | docker run -i $DOCKER_IMAGE > ./tmp/test-out/$base.png
