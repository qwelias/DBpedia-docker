#!/usr/bin/env bash
set -e
set -u
set -x

wget -r -nc -nH --cut-dirs=1 -np -l1 \
	-A '*.ttl.bz2' -A '*.owl' -R '*unredirected*' \
	-P ./dbpedia \
	http://downloads.dbpedia.org/2016-10/core/
wget -P ./dbpedia/classes http://downloads.dbpedia.org/2016-10/dbpedia_2016-10.owl

for i in ./dbpedia/core/*.bz2 ; do echo $$i ; bzip2 -dk "$$i"; done

mkdir ./dbpedia/core-ttl
mv ./dbpedia/core/*.ttl ./dbpedia/core-ttl/
