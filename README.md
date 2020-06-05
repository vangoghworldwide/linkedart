# Providing data to the vangoghworldwide.org platform
In this repo we explain how to provide information to https://vangoghworldwide.org/. Van Gogh Worldwide (VGW) brings together (professional) information about all artworks created by Vincent van Gogh. This documentation is intented for institutions that own or maintain artworks created by Vincent van Gogh and want to contribute. 

The starting point of Van Gogh Worldwide is the set of artworks defined in *The Works of Vincent van Gogh: His Paintings and Drawings* by Jacob Baart de la Faille. Basic metadata of all artworks in de la Faille is provided as [open data](https://github.com/vangoghworldwide/delafaille). You can help extend this basic metadata with information about the production, titles, materials, exhibitions, literature, research and more. 

## Linked Art
Van Gogh Worldwide builds upon the shared data model provided by the [Linked Art](https://linked.art) community. Socially speaking Linked Art is a growing community of cultural heritiage professionals that are dedicated to sharing information about art as *complete* and *simple* as possible. Technically speaking Linked Art is an application profile for encoding metadata as Linked Data with the CIDOC-CRM ontology, serialized as JSON-LD. We encourage you to get acquinted with the [fundemantals of linked art](https://linked.art/model/) and it's [basic patterns](https://linked.art/model/base/). 

We prefer JSON-LD (obviously as it is the standard) but accept other RDF-serializations, like RDF/XML or Turtle, as well. 

## General guidelines
* Provide metadata about the artworks made by Vincent van Gogh in your collection using the patterns described below.
* Add a link to the VGW URI for the artwork. The VGW URI is based on the De La Faile number when available, for example https://vangoghworldwide.org/data/artwork/F4.
* Use concepts from the Getty vocabularies (AAT, ULAN and TGN) to describe the medata values, such as the materials, locations, and museums. You can also use the terms from own thesauri provided they contain links (skos:exactMatch) to the Getty vocabularies. Linked Art prescribes to add your own \_label, to increase human readability of the data. Please do so, but be aware that VGW ignores the \_label and uses the preferred labels from the Getty vocabularies instead.
* Model dates according to the xsd:dateTime. With machine processable dates we can for example sort artworks by their production date.
* Add a link to a digital representation of the artwork (image).
* Provide provenance information about the artwork's current and previous owners.
* Provide information about the exhibitions the artworks were used in.
* Provide information about relevant literature.
* Provide metadata about technical documents. We mean 'documents' in the broader sense of the word, eg. paint-samples, x-ray images, reports.

## VGW Patterns
### Artwork
Your artwork needs to be identified by an http URI. In Linked Art an artwork is typed as a [HumanMadeObject](https://linked.art/model/base/#types-and-classifications).

```javascript
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject"
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-expanded&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fartwork.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/artwork.rdf.xml)

### Object classification
To further specify the object type Linked Art provides a classification pattern. Use a concept from AAT to define the object type.

```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "classified_as": [
    {
      "id": "http://vocab.getty.edu/aat/300177435",
      "type": "Type",
      "_label": "paintings"
    }
  ]
}
```

[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fclassification.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/classification.rdf.xml) 

The AAT concepts that are relevant for the oeuvre of Vincent van Gogh are:
URI | Label
--- | -----
http://vocab.getty.edu/aat/300033618 | Paintings
http://vocab.getty.edu/aat/300033973 | Drawings
http://vocab.getty.edu/aat/300015617 | Sketches
http://vocab.getty.edu/aat/300041273 | Prints

### Link to VGW URI
To identify how your artwork relates to Van Gogh Worldwide provide a link to a VGW URI. The VGW URI is based on the Fnumber. list of the available VGW-URIs is found [here](https://github.com/vangoghworldwide/delafaille).

@TBD sameAs does not exist in Linked Art
```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "sameAs": [
    {
      "id": "https://vangoghworldwide.org/data/artwork/F4"
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fvgw_uri.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/vgw_uri.rdf.xml)

### Identifiers
Apart from the VGW-URI the artwork can be identified with identifiers used in the context of a current owner or in oeuvre catalogues.
```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "identified_by": [
    {
      "type": "Identifier",
      "content": "s0416M1990",
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300312355",
          "type": "Type",
          "_label": "accession numbers"
        }
      ]
    },
    {
      "type": "Identifier",
      "content": "F4",
      "classified_as": [
        {
          "id": "https://vangoghworldwide.org/data/concept/f_number",
          "type": "Type",
          "_label": "De La Faille number"
        }
      ]
    },
    {
      "type": "Identifier",
      "content": "JH187",
      "classified_as": [
        {
          "id": "https://vangoghworldwide.org/data/concept/jh_number",
          "type": "Type",
          "_label": "Jan Hulsker number"
        }
      ]
    }
  ]
}
```

[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fidentifiers.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/identifiers.rdf.xml)

As a classification use 
URI | Label
--- | -----
http://vocab.getty.edu/aat/300312355 | accession number

Two identifiers take a special role in the oeuvre of Vincent van Gogh. The F-number provided by De La Faille in catalogue, and the JH-number provided by Jan Hulsker in [The complete Van Gogh](http://www.worldcat.org/oclc/541422596). For F-numbers and JH-numbers we recommend the format F4. Do not use F0004, F 4 or f4.

The concepts to classify identifiers are defined in the VGW vocabulary:
URI | Label
--- | -----
https://vangoghworldwide.org/data/concept/f_number | De La Faille number
https://vangoghworldwide.org/data/concept/jh_number | Jan Hulsker number

### Titles
In Linked Art titles are also considered identifiers. We thus use the same pattern with identified_by, but with type Name. 

```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "identified_by": [
    {
      "type": "Name",
      "content": "View of the Sea at Scheveningen",
      "language": [
        {
          "id": "http://vocab.getty.edu/aat/300388277",
          "type": "Language",
          "_label": "English"
        }
      ],
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300404670",
          "type": "Type",
          "_label": "Preferred terms"
        }
      ]
    }
  ],
  "identified_by": [
    {
      "type": "Name",
      "content": "Zeezicht in Scheveningen",
      "language": [
        {
          "id": "http://vocab.getty.edu/aat/300388256",
          "type": "Language",
          "_label": "Dutch"
        }
      ],
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300404670",
          "type": "Type",
          "_label": "Preferred terms"
        }
      ]
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Ftitles.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/identifiers.rdf.xml)

As a classification use
URI | Label
--- | -----
http://vocab.getty.edu/aat/300404670 | Preferred name

Multiple titles in various languages can be added, but only one preferred name per language is allowed. We expect at least one title in English. Note, that linked art does not use language tags as we know them in other RDF serializations. Instead the language is modelled as a relation to a Language object identified by an AAT concept for this language.

The AAT concepts that are relevant for languages are:
URI | Label
--- | -----
http://vocab.getty.edu/aat/300388277 | English
http://vocab.getty.edu/aat/300388256 | Dutch

### Current owner
Describe the current owner of the artwork by relating it to a museum or person. Use the Linked Art type Group for a Museum and the Linked art type Person for an individuel.

```javascript
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "current_owner": [
    {
      "id": "http://vocab.getty.edu/ulan/500275558",
      "type": "Group",
      "_label":"Van Gogh Museum"
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fcurrent_owner.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/current_owner.rdf.xml)

Use concepts from ULAN for the current owner. In case these are not available use your own identifier and label.
URI | Label
--- | -----
http://vocab.getty.edu/ulan/500275558 | Van Gogh Museum 
http://vocab.getty.edu/ulan/500235923 | Kröller-Müller Museum
http://vocab.getty.edu/ulan/500246547 | Rijksmuseum

### Production
The production of the artwork is modeled as an activity with an agent, a place, a timespan. Optionally the technique by which the artwork was made can be added.
```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "produced_by": {
    "id": "http://vangoghmuseum.nl/data/artwork_production/s0416M1990",
    "type": "Production",
    "carried_out_by": [
      {
        "id": "http://vocab.getty.edu/ulan/500115588",
        "type": "Actor",
        "_label": "Gogh, Vincent van"
      }
    ],
    "technique": [
      {
        "id": "http://vocab.getty.edu/aat/300054216",
        "type": "Type",
        "_label": "painting"
      }
    ],
    "took_place_at": [
      {
        "id": "http://vocab.getty.edu/tgn/7006810",
        "type": "Place",
        "_label": "'s-Gravenhage"
      }
    ],
    "timespan": [
      {
        "type": "TimeSpan",
        "end_of_the_end": "1882-08-21T00:00:00",
        "begin_of_the_begin": "1882-08-21T23:59:59"
      }
    ]
  }
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fproduction.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/production.rdf.xml)

#### Creator
Obviously (most of) the artworks in the platform are created by Vincent van Gogh. Use the ULAN URI to model the relation.
URI | Label
--- | -----
http://vocab.getty.edu/ulan/500115588 | Vincent van Gogh

Sometimes artworks are previously attributed to Van Gogh. Linked Art provides a mechanism to model [uncertain and changing attributions](https://linked.art/model/object/production/#uncertain-or-changing-attributions). Feel free to model these, but for simplicity reasons we ask you to add the 'previous attribution' concept from the VGW vocabulary:

URI | Label
--- | -----
https://vangoghworldwide.org/data/concept/previous_attribution | Previously attributed to Vincent van Gogh

#### Location
Use a URI from TGN for the production location
URI | Label
--- | -----
http://vocab.getty.edu/tgn/7006835 | Nuenen
http://vocab.getty.edu/tgn/7008038 | Paris
http://vocab.getty.edu/tgn/7008775 | Arles
http://vocab.getty.edu/tgn/7006810 | 's-Gravenhage
http://vocab.getty.edu/tgn/7008030 | Auvers-sur-Oise
http://vocab.getty.edu/tgn/7250304 | Parijs
http://vocab.getty.edu/tgn/7007856 | Antwerpen
http://vocab.getty.edu/tgn/7006824 | Etten
http://vocab.getty.edu/tgn/7003614 | Drenthe
http://vocab.getty.edu/tgn/7008792 | Saintes-Maries-de-la-Mer
http://vocab.getty.edu/tgn/7007868 | Bruxelles
http://vocab.getty.edu/tgn/7006952 | Amsterdam
http://vocab.getty.edu/tgn/1026382 | Cuesmes
http://vocab.getty.edu/tgn/1047973 | Nieuw Amsterdam
http://vocab.getty.edu/tgn/1047843 | Helvoirt
http://vocab.getty.edu/tgn/7006798 | Dordrecht
http://vocab.getty.edu/tgn/7012090 | Isleworth
http://vocab.getty.edu/tgn/7011562 | Ramsgate
http://vocab.getty.edu/tgn/7006842 | Eindhoven
http://vocab.getty.edu/tgn/7016995 | Laken

#### Timespan
Time is modeled as timespan with a start and an end date. This means that if you know that the artwork is created on 15 May 1888, it is created between 15 May 1888 00:00:00 (1888-05-15T00:00:00) and 15 May 1888 23:59:59 (1888-05-15T23:59:59). When the date is not known exactly model the first possible begin and the latest possible end. 

These machine readable dates are important, for example to sort artworks on date of production.

#### Technique
Relate the technique used in the production event.

Relevant AAT-concepts:
URI | Label
--- | -----
http://vocab.getty.edu/aat/300054216 | painting

(NB: this is the concept for "painting" as an activity, not the objectcategory "paintings")

### Dimensions
Dimension consist of a type (eg. height), a value and a measurement unit (eg. centimeters). There must be at least two dimensions (height and width).
```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "dimension": [
    {
      "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990/dimension/width",
      "type": "Dimension",
      "value": "51.9",
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300055647",
          "type": "Type",
          "_label": "width"
        }
      ],
      "unit": {
        "id": "http://vocab.getty.edu/aat/300379098",
        "type": "MeasurementUnit",
        "_label": "centimeters"
      }
    },
    {
      "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990/dimension/height",
      "type": "Dimension",
      "value": "36.4",
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300055644",
          "type": "Type",
          "_label": "height"
        }
      ],
      "unit": {
        "id": "http://vocab.getty.edu/aat/300379098",
        "type": "MeasurementUnit",
        "_label": "centimeters"
      }
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fdimensions.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/dimensions.rdf.xml)

Relevant AAT-concepts for dimension types:
URI | Label
--- | -----
http://vocab.getty.edu/aat/300055644 | height
http://vocab.getty.edu/aat/300055647 | width
http://vocab.getty.edu/aat/300072633 | depth

Relevant AAT-concepts for measurment units:
URI | Label
--- | -----
http://vocab.getty.edu/aat/300379099 | meters
http://vocab.getty.edu/aat/300379098 | centimeters
http://vocab.getty.edu/aat/300379101 | feet
http://vocab.getty.edu/aat/300379100 | inches	

### Material
The artwork is constructed out of various materials. Model the material that is used to create the art itself (eg. paint) as a property of the artwork. For the support material (eg. the canvas) see the pattern Support material.

```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "made_of": [
    {
      "id": "http://vocab.getty.edu/aat/300015050",
      "type": "Material",
      "_label": "oil paint"
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fmaterial.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/material.rdf.xml)

URI | Label
--- | -----
http://vocab.getty.edu/aat/300015050 | oil paint
http://vocab.getty.edu/aat/300015012 | ink
http://vocab.getty.edu/aat/300011727 | chalk
http://vocab.getty.edu/aat/300080064 | red chalk
http://vocab.getty.edu/aat/300187371 | printing ink
http://vocab.getty.edu/aat/300015017 | Chinese ink

#### Support material
Model the material of the support, such as the canvas in a separate part. 
```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "part": [
    {
      "type": "HumanMadeObject",
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300014844",
          "type": "HumanMadeObject",
          "_label": "Canvast Support"
        }
      ],
      "made_of": [
        {
          "id": "http://vocab.getty.edu/aat/300014078",
          "type": "Material",
          "_label": "canvas"
        }
      ]
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fmaterial_support.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/material_support.rdf.xml)

URI | Label
--- | -----
http://vocab.getty.edu/aat/300014109 | paper
http://vocab.getty.edu/aat/300014078 | canvas
http://vocab.getty.edu/aat/300014657 | panel
http://vocab.getty.edu/aat/300014184 | laid paper
http://vocab.getty.edu/aat/300014187 | wove paper
http://vocab.getty.edu/aat/300014170 | watercolor paper
http://vocab.getty.edu/aat/300162474 | pasteboard
http://vocab.getty.edu/aat/300014224 | cardboard
http://vocab.getty.edu/aat/300014067 | cotton
http://vocab.getty.edu/aat/300053013 | pasting
http://vocab.getty.edu/aat/300014205 | Masonite (TM)
http://vocab.getty.edu/aat/300014076 | burlap

### Subject classification
For the subject matter we only ask you to probide the type of the subject, such as landscape or portrait. You are free to provide the depicted content as well, but these are currently not shown on the VGW platform.

```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "shows": [
    {
      "type": "VisualItem",
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300117546",
          "type": "Type",
          "_label": "Seascape"
        }
      ]
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fsubject_type.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/subject_type.rdf.xml)

URI | Label
--- | -----
http://vocab.getty.edu/aat/300015638 | still lifes
http://vocab.getty.edu/aat/300189808 | figures
http://vocab.getty.edu/aat/300015636 | landscapes
http://vocab.getty.edu/aat/300015571 | cityscapes
http://vocab.getty.edu/aat/300015637 | portraits
http://vocab.getty.edu/aat/300124534 | self-portraits
http://vocab.getty.edu/aat/300189568 | nudes
http://vocab.getty.edu/aat/300117546 | seascapes
http://vocab.getty.edu/aat/300139140 | genre

<!--### Parts
Some objects are composed of multiple smaller parts.
-->

### Digital representation
The digital representation of the artwork is an image that is available online. 
```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "representation": [
    {
      "id": "{URL_TO_YOUR_IMAGE}",
      "type": "VisualItem",
      "format": "image/jpeg",
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300215302",
          "type": "Type",
          "_label": "digital images"
        }
      ]
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fdigital_representation.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/digital_representation.rdf.xml)

Van Gogh Worldwide makes your images available according to the [IIIF standard](https://iiif.io/). This enables various functions such as zooming of high resolition images. Please provide the highest resolution you can share. We take your images and add them to VGWs IIIF server.

In case you provide images via your own IIIF server use the following pattern:
```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "representation": [
    {
      "id": "{BASE_URL_TO_IMAGE_ON_IIIF_SERVER}",
      "type": "VisualItem",
      "conforms_to": [
        {
          "id": "http://iiif.io/api/image"
        }
      ],
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300215302",
          "type": "Type",
          "_label": "digital images"
        }
      ]
    }
  ]
}
```

[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fdigital_representation_iiif.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/digital_representation_iiif.rdf.xml)

### Provenance
The provenance defines the differnet owners of the artwork and how the acquired the work. Each ownership is modeled as a phase. A phase can be initiated by an acquisition (auction, purchase, gift, loan)
```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "has_phase": [
     {
      "type": "Phase",
      "carried_out_by": [
        {
          "id": "http://vocab.getty.edu/ulan/500275558", 
          "type": "Actor", 
          "_label": "Van Gogh Museum", 
          "classified_as": [
            {
              "id": "http://vocab.getty.edu/aat/300312281", 
              "type": "Type", 
              "_label": "Museum"
            }
          ]
        }
      ], 
      "took_place_at": [
        {
          "id": "http://vocab.getty.edu/tgn/7006952",
          "type": "Place",
          "_label": "Amsterdam"
        }
      ],
      "timespan": [
        {
          "type": "TimeSpan",
          "end_of_the_end": "1990-12-31",
          "begin_of_the_begin": "1949-01-01"
        }
      ],
      "initiated_by": [
        {
          "type": "Acquisition",
          "classified_as": [
            {
              "id": "http://vocab.getty.edu/aat/300417645",
              "type": "Type",
              "_label": "loan"
            }
          ]
        }
      ]
    }
  ]
}
```

[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fprovenance.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/provenance.rdf.xml)

@TBD Add AAT terms for acquisition types.
URI | Label
--- | -----

### Exhibitions
Artworks are used for exhibitions. An exhibition is identified by a name, the organisation that carried it out and the time that it took place. Every exhibition MUST HAVE an identifying URI. A blank node for an exhibition is not allowed.

```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "used_for": [
    {
      "id": "http://vangoghmuseum.nl/data/exhibition/858",
      "type": "Activity",
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300054766",
          "type": "Type",
          "_label": "exhibitions"
        }
      ],
      "identified_by": [
        {
          "type": "Name",
          "content": "Eeuwfeest Vincent van Gogh"
        }
      ],
      "carried_out_by": [
        {
          "id": "http://vangoghmuseum.nl/data/person/8045",
          "type": "Actor",
          "_label": "Stedelijk Museum Amsterdam"
        }
      ],
      "timespan": [
        {
          "type": "TimeSpan",
          "end_of_the_end": "1953-09-20",
          "begin_of_the_begin": "1953-07-23"
        }
      ]
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fexhibition.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/exhibition.rdf.xml)

### Literature
<!-- IZ: MUST have its own uri -->

### Technical research
<!-- IZ: MUST have is own uri -->


