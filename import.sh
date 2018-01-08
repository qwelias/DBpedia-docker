#!/usr/bin/env bash
set -e
set -u
set -x

docker run --name dbpedia-import \
  -it \
  --rm \
  --link dbpedia \
  -v ${PWD}/dbpedia:/import \
  -v ${PWD}/virtuoso/import.sh:/import/import.sh \
  tenforce/virtuoso bash /import/import.sh
