# Providing data to the vangoghworldwide.org platform
In this repo we provide documentation and examples of the way we expect metadata about Van Gogh to be used in https://vangoghworldwide.org/. 

## Linked Art
We use [Linked Art](https://linked.art), a profile for encoding metadata as Linked Data with the CIDOC-CRM ontology, serialized as JSON-LD. We prefer JSON-LD (obviously as it is the standard) but accept other RDF-serializations, like RDF/XML or Turtle, as well. We encourage you to get acquinted with the [fundemantals of linked art](https://linked.art/model/) and it's [basic patterns](https://linked.art/model/base/). 

## General guidelines

* Provide metadata about the artworks made by Vincent van Gogh in your collection using the patterns described below.
<!-- IZ: All these patterns are "MUST HAVES" for participating in the platform unless stated otherwise. -->
* Add a link to the VGW URI for the artwork. The VGW URI is based on the De La Faile number when available, for example https://vangoghworldwide.org/data/artwork/F4.
* Use concepts from the Getty vocabularies (AAT, ULAN and TGN) to describe the medata values, such as the materials, locations, and museums. You can also use the terms from own thesauri provided they contain links (skos:exactMatch) to the Getty vocabularies. <!-- IZ: Linked Art prescribes to add your own _label, to increase usability of the data. Be careful to use a label that is in line with the AAT concept. Although required in the Linked Art VGW ignores the _labels in order to prevent ambiguity. -->
* Model dates according to the xsd:dateTime. With machine processable dates we can for example sort artworks by their production date.
* Add a link to a digital representation of the artwork (image).
<!-- * Provide provenance information about the artwork's current and previous owners.
* Provide information about the exhibitions the artworks were used in.
* Provide information about relevant literature.
* Provide metadata about technical documents. We mean 'documents' in the broader sense of the word, eg. paint-samples, x-ray images, reports. -->

## VGW Patterns
### Artworks
In Linked Art artworks are typed as HumanMadeObjects.

See [example](https://json-ld.org/playground/#startTab=tab-expanded&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fartwork.jsonld).

### Object types
To further specify the object type Linked Art provides a classification pattern. Use a concept from AAT to define the object type.

See [example](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fclassification.jsonld).

The AAT concepts that are relevant for the oeuvre of Vincent van Gogh are:
* http://vocab.getty.edu/aat/300033618: Paintings 
* http://vocab.getty.edu/aat/300033973: Drawings
* http://vocab.getty.edu/aat/300015617: Sketches
* http://vocab.getty.edu/aat/300041273: Prints

### Link to VGW URI
To identify how your artwork relates to Van Gogh Worldwide provide a link to a VGW URI. The VGW URI is based on the Fnumber. A list of the available VGW-URIs is found [here](https://github.com/vangoghworldwide/delafaille).

See [example](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fvgw_uri.jsonld).

### Identifiers
Apart from the VGW-URI the artwork can be identified with identifiers used in the context of a current owner or in oeuvre catalogues.

As a classification use 
* http://vocab.getty.edu/aat/300312355: accession number

Two identifiers take a special role in the oeuvre of Vincent van Gogh. The F-number provided by De La Faille in catalogue, and the JH-number provided by Jan Hulsker in [The complete Van Gogh](http://www.worldcat.org/oclc/541422596). The concepts to classify identifiers are defined in the VGW vocabulary.
For F-numbers and JH-numbers we recommend the format F4 and JH... Do not use F0004, F 4 or f4.
<!-- IZ? Tot nu toe was dit steeds expliciet MET spatie. Dus juist wel "F 4" ipv "F4" -->

See [example](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fidentifiers.jsonld).

### Titles
In Linked Art titles are also considered identifiers. We thus use the same pattern with identified_by, but with type Name. 

As a classification use
* http://vocab.getty.edu/aat/300404670: Preferred name
<!-- IZ: je gebruikt "Primary Name" ipv "Preferred Name" als label in je voorbeeld. Is dat bewust? -->
<!-- IZ: ik heb in mijn voorbeeld een extra titel in het Nederlands. Zullen we die ook toevoegen aan de json? -->

<!-- IZ: Parallel titles in various languages can be added, but only one preferred name per language is allowed. We expect at least one title in English. Titles must be typed in Linked Art style. For general Linked Data purposes please add the usual Linked Data construct for language marking as well.

The AAT concepts that are relevant for languages are:
English http://vocab.getty.edu/aat/300388277
Dutch http://vocab.getty.edu/aat/300388256 -->

See [example](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Ftitles.jsonld).

### Current owner
Relate the current owner of the artwork with the current-owner-pattern.

Use ULAN concepts to relate the current owner or RKDartist if not available:
* http://vocab.getty.edu/ulan/500275558: Van Gogh Museum 
* http://vocab.getty.edu/ulan/500235923: Kröller-Müller Museum
* http://vocab.getty.edu/ulan/500246547: Rijksmuseum

See [example](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fcurrent_owner.jsonld).

<!-- IZ: typeren: in het jsonld voorbeeld is de current owner niet getypeerd. Ik heb in mijn voorbeeld gekozen voor E39_Actor Als je kiest voor Group sluit je personen als individu uit als eigenaar. -->

### Production
The production of the artwork is modeled as an Event, with agent, place, time and technique.

See [example](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fproduction.jsonld).

#### Creator
Obviously (most of) the artworks in the platform are created by Vincent van Gogh. Use the ULAN-uri to model the relation.
* http://vocab.getty.edu/ulan/500115588: Vincent van Gogh

Sometimes artworks are previously attributed to Van Gogh. Creating a pattern for this situation is to be decided on.

#### Location
Relate the location of the production-event.

* http://vocab.getty.edu/tgn/7006835: Nuenen
* http://vocab.getty.edu/tgn/7008038: Paris
* http://vocab.getty.edu/tgn/7008775: Arles
* http://vocab.getty.edu/tgn/7006810: 's-Gravenhage
* http://vocab.getty.edu/tgn/7008030: Auvers-sur-Oise
* http://vocab.getty.edu/tgn/7250304: Parijs
* http://vocab.getty.edu/tgn/7007856: Antwerpen
* http://vocab.getty.edu/tgn/7006824: Etten
* http://vocab.getty.edu/tgn/7003614: Drenthe
* http://vocab.getty.edu/tgn/7008792: Saintes-Maries-de-la-Mer
* http://vocab.getty.edu/tgn/7007868: Bruxelles
* http://vocab.getty.edu/tgn/7006952: Amsterdam
* http://vocab.getty.edu/tgn/1026382: Cuesmes
* http://vocab.getty.edu/tgn/1047973: Nieuw Amsterdam
* http://vocab.getty.edu/tgn/1047843: Helvoirt
* http://vocab.getty.edu/tgn/7006798: Dordrecht
* http://vocab.getty.edu/tgn/7012090: Isleworth
* http://vocab.getty.edu/tgn/7011562: Ramsgate
* http://vocab.getty.edu/tgn/7006842: Eindhoven
* http://vocab.getty.edu/tgn/7016995: Laken

#### Time
Time is modeled as timespan with a start and an end. This means that if you know that the artwork is created on 15 May 1888, it is created between 15 May 1888 00:00:00 (1888-05-15T00:00:00) and 15 May 1888 23:59:59 (1888-05-15T23:59:59). These machine readable dates are important, for example to sort artworks on date of production.

#### Technique
Relate the technique used in the production event.

Relevant AAT-concepts:
http://vocab.getty.edu/aat/300054216: painting 
(NB: this is the concept for "painting" as an activity, not the objectcategory "paintings")

<!-- IZ: deze heb ik tot nu toe steeds gemist :-( -->

### Dimensions
Dimension consist of a type (eg. height), a value and a measurement unit (eg. centimeters). There must be at least two dimensions (height and width).

See [example](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fdimensions.jsonld).

Relevant AAT-concepts:
* http://vocab.getty.edu/aat/300055644: height
* http://vocab.getty.edu/aat/300055647: width
* http://vocab.getty.edu/aat/300072633: depth
* http://vocab.getty.edu/aat/300379099: meters
* http://vocab.getty.edu/aat/300379098: centimeters
* http://vocab.getty.edu/aat/300379101: feet
* http://vocab.getty.edu/aat/300379100: inches	

### Material
The artwork is constructed out of various materials: the support material (eg. the canvas) and the material used to create the art itself (eg. paint).

See [example](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fmaterial.jsonld).

@TBD Add common AAT terms

#### Support material
Model the material of the support, such as the canvas in a separate part. 

See [example](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fmaterial_support.jsonld).

### Subject type 
<!-- IZ: is de Engelse term niet Subject matter? Dat gebruikte Chris in zijn proefschrift volgens mij-->
Quote from Linked Art “ This could include classifications such as "Landscape" or "Allusion", compared to classifications that are derived from the physical nature of the object such as a "Painting", "Photograph" or "Sculpture" which are associated with the object.

https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fsubject_type.jsonld

### Digital representation
Provide images via your own IIIF server

URL to online image. Van Gogh Platform will serve them via their IIIF Server.

Highest resolution possible. 

https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fdigital_representation.jsonld

### Provenance
Model a lifetime object. Phases within this lifetime. A phase can be initiated by an acquisition (auction, purchase, gift, loan)
<!-- IZ: MUST have its own uri -->

https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fprovenance.jsonld

@TBD Add AAT terms for acquisition types.

### Exhibitions
Integrate with VGW URIs for exhibitions
<!-- IZ: MUST have its own uri -->

https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fexhibition.jsonld

### Literature
<!-- IZ: MUST have its own uri -->

### Technical research
<!-- IZ: MUST have is own uri -->


