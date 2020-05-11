# Providing data to the vangoghworldwide.org platform
In this repo we provide documentation and examples of the way we expect metadata about Van Gogh to be used in https://vangoghworldwide.org/. 

## Linked Art
We use [Linked Art](https://linked.art), a profile for encoding metadata as Linked Data with the CIDOC-CRM ontology, serialized as JSON-LD. We prefer JSON-LD (obviously as it is the standard) but accept other RDF-serializations, like RDF/XML or Turtle, as well.

Important: avoid blank nodes.

### Typing
* always type a Thing with rdf:type and often with crm:P2_has_type too.
* use xsd:dateTime

### Usage of the AAT, ULAN and TGN
* we don't redefine terms, like Linked Art does.
* we allow delivery with references to other (eg. your own) SKOS-thesauri, iff it contains skos:exactMatch's to AAT, ULAN or TGN.

## Artworks
Deliver metadata about the artworks by Van Gogh in your collection.
Provide:
* identifiers (todo: link)
* ...

## Technical documents
Deliver metadata about technical documents. We mean 'documents' in the broader sense of the word, eg. paint-samples, x-ray images, reports.
Provide:
* ...

