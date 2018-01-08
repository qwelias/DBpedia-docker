DIR=$(shell pwd)

# Preparation procedures

# downloads dbpedia core, ontology and en folders
download:
	wget -r -nc -nH --cut-dirs=1 -np -l1 \
		-A '*.ttl.bz2' -A '*.owl' -R '*unredirected*' \
		-P ./dbpedia \
		http://downloads.dbpedia.org/2016-10/core/
	wget -P ./dbpedia/classes http://downloads.dbpedia.org/2016-10/dbpedia_2016-10.owl

# unpacks downloaded files
unpack:
	for i in ./dbpedia/core/*.bz2 ; do echo $$i ; bzip2 -dk "$$i"; done

# moves unpacked files into separate folders for import
move:
	mkdir ./dbpedia/core-ttl
	mv ./dbpedia/core/*.ttl ./dbpedia/core-ttl/

# executes download, unpack and move one after another
prepare: download unpack move

# creates new instance of virtuoso
virtuoso:
	docker run --name dbpedia \
		-p 8890:8890 \
		-e DEFAULT_GRAPH=http://dbpedia.org \
		-v ${PWD}/db:/usr/local/virtuoso-opensource/var/lib/virtuoso/db \
		-v ${PWD}/virtuoso/virtuoso.ini:/virtuoso.ini \
		-v ${PWD}/dbpedia:/import \
		-d tenforce/virtuoso

# starts importing the data into running instance of virtuoso
import:
	docker run --name dbpedia-import \
		-it \
		--rm \
		--link dbpedia \
		-v ${PWD}/dbpedia:/import \
		-v ${PWD}/virtuoso/import.sh:/import/import.sh \
		tenforce/virtuoso bash /import/import.sh
