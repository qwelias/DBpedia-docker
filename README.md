# DBpedia Docker Container

Build yourself a DBpedia container.

## Warning!
* Building Virtuoso with DBpedia requires significant resources.
* The exact amount of resources would depend on languages you're importing.
* Core requires about 50GB of disk space and 16GB of ram.
* Make sure to properly configure `virtuoso/virtuoso.ini`

## Building

1. Download, unpack and prepare required DBpedia files:
```sh
$ ./prepare.sh
```
2. Start new virtuoso instance:
```sh
$ ./dbpedia.sh
```
3. Start import procedure:
```sh
$ ./import.sh
```

In the end it should yield a ready-to-use running dbpedia container and db directory filled with built db data.

Access point is http://localhost:8890/sparql.

## Additional languages

Currently scripts will only download and import core DBpedia files.

If you wish to add more languages, you'll need to edit `download`, `unpack` and `move` targets in Makefile as well as list of imported folders in `virtuoso/import.sh` file.
