#!/usr/bin/env bash
set -e
set -u
set -x

docker run --name dbpedia \
  -p 8890:8890 \
  -e DEFAULT_GRAPH=http://dbpedia.org \
  -v ${PWD}/db:/usr/local/virtuoso-opensource/var/lib/virtuoso/db \
  -v ${PWD}/virtuoso/virtuoso.ini:/virtuoso.ini \
  -v ${PWD}/dbpedia:/import \
  -d tenforce/virtuoso
