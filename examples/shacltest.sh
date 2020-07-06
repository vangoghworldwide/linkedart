#!/bin/bash

export JENA_HOME=/usr/bin/apache-jena/apache-jena-3.14.0
export PATH=$PATH:$JENA_HOME/bin

riot --output turtle rdfxml/*.rdf.xml > ttl/complete_example.ttl

shacl v -s ../shapes/artwork_shacl.ttl -d ttl/complete_example.ttl > shaclreport.ttl