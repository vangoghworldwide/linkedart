#!/bin/bash

# serialize RDF/XML into turtle for testing and adding examples in turtle
for rdf_file in rdfxml/*.rdf.xml
do
        ttl_file=$(basename -- "$rdf_file")
        rapper -q -o turtle $rdf_file > ttl/${ttl_file%%.*}.ttl
done