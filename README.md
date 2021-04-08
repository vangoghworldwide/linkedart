# Providing data to the vangoghworldwide.org platform
In this repo we explain how to provide information to http://vangoghworldwide.org/. Van Gogh Worldwide (VGW) brings together (professional) information about all artworks created by Vincent van Gogh. This documentation is intented for institutions that own or maintain artworks created by Vincent van Gogh and want to contribute. 

The starting point of Van Gogh Worldwide is the set of artworks defined in *The Works of Vincent van Gogh: His Paintings and Drawings* by Jacob Baart de la Faille (1970). Basic metadata of all artworks in de la Faille is provided as [open data](https://github.com/vangoghworldwide/delafaille). You can help extend this basic metadata with information about the production, titles, materials, exhibitions, literature, research and more. 

## Linked Art
Van Gogh Worldwide builds upon the shared data model provided by the [Linked Art](https://linked.art) community. Socially speaking Linked Art is a growing community of cultural heritiage professionals that are dedicated to sharing information about art as *complete* and *simple* as possible. Technically speaking Linked Art is an application profile for encoding metadata as Linked Data with the CIDOC-CRM ontology, serialized as JSON-LD. We encourage you to get acquinted with the [fundamentals of linked art](https://linked.art/model/) and its [basic patterns](https://linked.art/model/base/). 

We prefer JSON-LD (obviously as it is the standard) but accept other RDF-serializations, like RDF/XML or Turtle, as well. 

## General guidelines

Provide information about the artworks made by Vincent van Gogh in your collection according to the following patterns:
* [Artwork](#artwork)
* [Specific artwork type](#specific-artwork-type)
* [Link to Van Gogh Worldwide URI](#link-to-vgw-uri)
* [Identifiers](#identifiers) (e.g. de la faille number and catalogue numbers)
* [Titles](#titles)
* [Current owner](#current-owner) of the artwork
* [Production](#production) (creator, location, period and technique)
* [Dimensions](#dimensions) (width and height)
* [Material](#material) (e.g. oil paint)
* [Subject type](#subject-type) (e.g. landscape, portrait)
* [Parts](#parts) (e.g. backside)
* [Digital representation](#digital-representation) of the artwork (image)
* [Credit / attribution](#credit--attribution)
* [Provenance](#provenance) about the artwork's current and previous owners
* [Auctions](#auctions)
* [Exhibitions](#exhibitions) the artwork was used in
* [Inscriptions](#inscriptions) on the artwork such as signatures and labels
* [Literature](#literature) about an artwork
* [Technical research](#technical-research) (e.g. x-rays, technical reports)

### Getty vocabularies
Linked Art prescribes the use of the [Getty vocabularies](http://vocab.getty.edu/) (AAT, ULAN and TGN) to describe the metadata values, such as the artwork types, materials, locations, and museums. Van Gogh Worldwide follows this best practice. The modelling patterns below include URIs of Getty concepts that are relevant for Van Gogh Worldwide. Please feel free to share additional URIs of Getty concepts where needed.

We identified three methods to provide the Getty URIs in your metadata:
1. Directly use the URI of a Getty concept in your data. 
2. Use a term from your own thesaurus and include a skos:exactMatch link to the URI of a Getty concept.
3. When there is no exactMatch to a getty Concept include a skos:broader relation to a broader getty Concept.

(Examples [JSON-LD playground](https://json-ld.org/playground/#startTab=tab-expanded&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fskos.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/skos.rdf.xml)). 

Linked Art prescribes the use of \_label (rdfs:label) to increase human readability of data. Please do so, but be aware that VGW does not use this \_label on [vangoghworldwide.org](https://vangoghworldwide.org). There is no need to add other information about the Getty concepts as Van Gogh Worldwide already contains all relevant information about the Getty concepts. 

In case you use concepts from your own thesauri and do not provide links to the Getty vocabularies your data is still accepted. However, be aware that it will be ignored in various functions of [vangoghworldwide.org](https://vangoghworldwide.org). The website uses the Getty concepts to provide an integrated view. For example, the facet filters only show concepts from AAT, TGN and ULAN. 

### Dates
In Linked Art all dates are modelled as timespans. Please study the [linked art documentation on timespans](https://linked.art/model/base/#events-and-activities). Within the timespan the dates should be modelled according to the xsd:dateTime standard. For [vangoghworldwide.org](https://vangoghworldwide.org) this is important as only with machine processable dates we can sort on dates, for example to artworks by their production date. 

Optionally a textual description of the date can be included in the timespan.

## VGW Patterns
### Artwork
Your artwork needs to be identified by an http URI. In jsonld this is provided as the *id*. In Linked Art an artwork is typed as a [HumanMadeObject](https://linked.art/model/base/#types-and-classifications). 

```javascript
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-expanded&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fartwork.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/artwork.rdf.xml)

### Specific artwork type
Add a more specific object type by [classifying](https://linked.art/model/base/#types-and-classifications) the artwork with a concept from AAT.

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
http://vocab.getty.edu/aat/300041273 | Prints

### Link to VGW URI
To identify how your artwork relates to Van Gogh Worldwide provide a *see_also* link to a VGW URI. The VGW URI is based on the Fnumber. The VGW URIs can be found by searching for a work on [vangoghworldwide.org](http://vangoghworldwide.org). Use the url of the artwork page, but make sure to use **https://** and include **/data** in the path. Thus the url for the artwork https://vangoghworldwide.org/artwork/F4 becomes the VGW URI https://vangoghworldwide.org/data/artwork/F4.

Notice that the reference to De La Faille sometimes contains additional lettering, arabic or Roman numbers, eg. F1009a, F1116ar, F1664-13 or FXXXIII. These additions are part of the URI.

```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "see_also": [
    {
      "id": "https://vangoghworldwide.org/data/artwork/F4"
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fvgw_uri.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/vgw_uri.rdf.xml)

When an artwork was not part of De La Faille because it was attributed to Vincent Van Gogh after 1970 please contact us. 

### Identifiers
Apart from the VGW-URI the artwork can be identified with [identifiers](https://linked.art/model/base/#identifiers) used in the context of a current owner or in oeuvre catalogues.
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

Two identifiers take a special role in the oeuvre of Vincent van Gogh. The F-number provided by De La Faille in his catalogue mentioned above, and the JH-number provided by Jan Hulsker in [The complete Van Gogh](http://www.worldcat.org/oclc/541422596). For F-numbers and JH-numbers we recommend the format F4. Do not use F0004, F 4 or f4.

The concepts to classify identifiers are defined in the VGW vocabulary:
URI | Label
--- | -----
https://vangoghworldwide.org/data/concept/f_number | De La Faille number
https://vangoghworldwide.org/data/concept/jh_number | Jan Hulsker number

### Titles
In Linked Art titles are also considered identifiers. We thus use the same pattern with identified_by, but with type [Name](https://linked.art/model/base/#names). 

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
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Ftitles.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/titles.rdf.xml)

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
Describe the [current owner](https://linked.art/model/object/ownership/#ownership) of the artwork by relating it to a museum or person. Use the Linked Art type Group for a Museum and the Linked art type Person for an individual. You're allowed to use the Linked Art type Actor if you're uncertain about the type.

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
The [production](https://linked.art/model/object/production/) of the artwork is modeled as an activity with an agent, a place, a timespan. Optionally the technique by which the artwork was made can be added.
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
        "begin_of_the_begin": "1882-08-21T23:59:59",
        "identified_by": [
          {
            "type": "Name", 
            "content": "Probably on August 21 1882",
            "language": [
              {
                "id": "http://vocab.getty.edu/aat/300388277",
                "type": "Language",
                "_label": "English"
              }
            ]
          }
        ]
      }
    ]
  }
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fproduction.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/production.rdf.xml)

#### Creator
Obviously (most of) the artworks in the platform are created by Vincent van Gogh. Use the ULAN URI or the RKDArtists URI to model the relation.
URI | Label
--- | -----
http://vocab.getty.edu/ulan/500115588 | Vincent van Gogh
https://data.rkd.nl/artists/32439 | Vincent van Gogh

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
http://vocab.getty.edu/tgn/7007865 | Borinage
http://vocab.getty.edu/tgn/7009654 | Saint-Rémy-de-Provence


#### Timespan
Time is modeled as timespan with a start and an end date. This means that if you know that the artwork is created on 15 May 1888, it is created between 15 May 1888 00:00:00 (1888-05-15T00:00:00) and 15 May 1888 23:59:59 (1888-05-15T23:59:59). When the date is not known exactly model the first possible begin and the latest possible end. 

These machine readable dates are important, for example to sort artworks on date of production. Optionally a textual description of the date can be provided with an *identified_by* relation on the timespan.

#### Technique
Technique relates to the way in which Van Gogh used materials in order to create the art work. For Van Gogh Worldwide, it specifically relates to a technique which is not apparent or can be deducted from the used materials. For example, for ‘oil on canvas’ it is not necessary to list the technique ‘painted’ (there is also a subject type stating the object is a ‘painting’). This is not the case for works on paper. Watercolor can be applied using various techniques. Those can be specified here. The term Technique is not limited to works on paper. It can be applied to any work of Vincent van Gogh, as long as the term is not redundant (as in case of the example ‘painted’).

Relevant AAT-concepts:
URI | Label
--- | -----
http://vocab.getty.edu/aat/300182748 | wash technique of colorwashing
http://vocab.getty.edu/aat/300053062 | colorwashing
http://vocab.getty.edu/aat/300053418 | heightening
http://vocab.getty.edu/aat/300053412 | stumping
http://vocab.getty.edu/aat/300379457 | scratching (process)
http://vocab.getty.edu/aat/300054196 | stumping
http://vocab.getty.edu/aat/300053431 | squaring (transferring technique)

### Previous attribution

Sometimes artworks were falsely assigned to Vincent van Gogh. Linked Art provides a mechanism to model [uncertain and changing attributions](https://linked.art/model/object/production/#uncertain-or-changing-attributions). You model the production activity in the same way as described above, but instead of providing the *carried_out_by* directly we use an attribute assignment. Classify the assignment with the concept from the VGW vocabulary *Previously attributed to Vincent van Gogh*. In the assignment the timespan is used to indicate when the attribution was believed to be valid, thus Van Gogh being the creator. 

```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0076V1962",
  "type": "HumanMadeObject",
  "produced_by": {
    "id": "http://vangoghmuseum.nl/data/artwork_production/s0076V1962",
    "type": "Production",
    "assigned_by": [
      {
        "id": "http://vangoghmuseum.nl/data/artwork_production/s0076V1962/assignment/1", 
        "type": "AttributeAssignment", 
        "classified_as": [
          {
            "id": "https://vangoghworldwide.org/data/concept/previous_attribution", 
            "type": "Type", 
            "_label": "Previously attributed to Vincent van Gogh"
          }
        ], 
        "timespan": {
          "id": "https://linked.art/example/time/19", 
          "type": "TimeSpan", 
          "end_of_the_end": "2016-01-01"
        }, 
        "carried_out_by": [
          {
            "id": "https://linked.art/example/person/30", 
            "type": "Person", 
            "_label": "Paintings Curator"
          }
        ], 
        "assigned": {
          "id": "https://linked.art/example/activity/48", 
          "type": "Production", 
          "carried_out_by": [
            {
              "id": "http://vocab.getty.edu/ulan/500115588",
              "type": "Actor",
              "_label": "Gogh, Vincent van"
            }
          ]
        }
      }
    ]
  }
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fprevious_attribution.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/previous_attribution.rdf.xml)

### Dimensions
A [Dimension](https://linked.art/model/object/physical/#dimensions) consists of a type (eg. height), a value and a measurement unit (eg. centimeters). There must be at least two dimensions (height and width).
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
The artwork is constructed out of various materials. Model the [material](https://linked.art/model/object/physical/#materials) that is used to create the art itself (eg. paint) as a property of the artwork. For the support material (eg. the canvas) see the pattern [Support material](#support-material).

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
          "type": "Type",
          "_label": "Canvas Support"
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

#### Materials statement
In addition to the definition of the material (and support material) using AAT concept you can describe the materials in free text. This is done using a statement [](https://linked.art/model/object/physical/#materials-statement)
```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "referred_to_by": [
    {
      "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990/materials-statement", 
      "type": "LinguisticObject", 
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300435429", 
          "type": "Type", 
          "_label": "Material Statement", 
          "classified_as": [
            {
              "id": "http://vocab.getty.edu/aat/300418049", 
              "type": "Type", 
              "_label": "Brief Text"
            }
          ]
        }
      ], 
      "content": "Oil paint on canvas"
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fmaterials_statement.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/materials_statement.rdf.xml)

### Subject type
For the subject matter we only ask you to provide the [type of the subject](https://linked.art/model/object/aboutness/#other-classifications), such as landscape or portrait. You are free to provide the depicted content as well, but these are currently not shown on the VGW platform.

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
http://vocab.getty.edu/aat/300263554 | animal paintings
http://vocab.getty.edu/aat/300124520 | interior views
http://vocab.getty.edu/aat/300236227 | townscapes

### Parts
By modelling the parts of an artwork we define more specifically where information belongs to. We have already seen this pattern to model the [support material](#support-material). The backside of an artwork is another important part. Use it to model that a [digital representation](#digital-representation) depicts this part. Or to define the precise location of a [label](#label).

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
          "id": "http://vocab.getty.edu/aat/300190692",
          "type": "HumanMadeObject",
          "_label": "backs"
        }
      ],
      "representation": [
        {...}
      ]
    }
  ]
}
```

#### Sibblings
@TDB

<!-- <http://vangoghmuseum.nl/data/artwork/s0004V1962> crm:P1_is_identified_by [a crm:E42_Identifier ; 
                                                                           crm:P2_has_type <http://vocab.getty.edu/aat/300435704> ; 
                                                                           crm:P190_has_symbolic_content "32882"],
                                                                          [a crm:E42_Identifier ; 
                                                                           crm:P2_has_type <http://vocab.getty.edu/aat/300312355> ; 
                                                                           crm:P190_has_symbolic_content "s0004V1962"];
                                                  crm:P2_has_type <http://vangoghmuseum.nl/data/term/4200>;
                                                  crm:P46_is_composed_of <http://vangoghmuseum.nl/data/artwork/s0004V1962r>,
                                                                         <http://vangoghmuseum.nl/data/artwork/s0004V1962v>;
                                                  a crm:E22_Human-Made_Object. -->
                                                  
### Digital representation
For an artwork provide at least one image of the front side of the artwork. To model photographs of other sides of the artwork see [parts](#parts). Representations made with special techniques, such as raking light or x-ray, are considered as [technical research](#technical-research) and should be modelled as such.

Van Gogh Worldwide follows the [IIIF standard](https://iiif.io/) for images. This enables various functions such as zooming and comparison. To support this please provide the highest resolution you can share. We identified three scenarios to share your images and model the metadata about them.

#### Your own IIIF server
In case you provide images via your own IIIF server use the following pattern in your data:
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

#### Images via url
In case your images are available for public download you provide the urls for each image in the data. Van Gogh Worldwide will then pick up these images and make them available through its IIIF server. 
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

#### IIIF server Van Gogh Worldwide
For some institutions it is not possible to make high resolution images available for public download. A IIIF server provides a solution in this case. The IIIF server of Van Gogh Worldwide restricts the download of images to a maximum area of 640000 pixels per request (800px\*800px). But at the same time images are available in the VGW image viewer in full detail using the tiling mechanism of IIIF. 

If this case applies to you please contact us. We will make your images available via the IIIF server of Van Gogh Worldwide. 

In your data refer to the IIIF server of Van Gogh Worldwide and the identifier of the image. Also include the name of organisation identifier (ORG_ID) that you received from us.
```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "representation": [
    {
      "id": "https://data.spinque.com/iiif/2/vangoghworldwide%2F{ORG_ID}%2F{IMAGE_FILENAME}.jp2",
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

### Credit / attribution
When an explicit credit line needs to be displayd on [vangoghworldwide.org](http://vangoghworldwide.org) provide it as a linguist object that is classified with the AAT Concept for *Credit Statement*. 
```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "referred_to_by": [
    {
      "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990/credit", 
      "type": "LinguisticObject", 
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300026687", 
          "type": "Type", 
          "_label": "Credit Statement",
          "classified_as": [
            {
              "id": "http://vocab.getty.edu/aat/300418049", 
              "type": "Type", 
              "_label": "Brief Text"
            }
          ]
        }
      ], 
      "content": "Van Gogh Museum, Amsterdam (Vincent van Gogh Foundation)"
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fcredit.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/credit.rdf.xml)

### Provenance
In Linked Art the [provenance](https://linked.art/model/provenance/) of an artwork is modelled a series of events. The provenance event describes the actor, the timespan and optionnaly a title or identifier. The details are modelled by specific subsequent events (parts), such as an acquisition event, an auction or a the transfer of custody. See the [Linked Art documentation](https://linked.art/model/provenance/#parts) for more details.

(A provenance entry may wrap information for multiple artworks, for example when multiple artworks were acquired in one single transaction. In this case it is thus important that the same provenance entry is used for each o artwork.)

```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990/purchase/1",
  "type": "Activity",
  "_label": "Purchase of Painting", 
  "classified_as": [
    {
      "id": "http://vocab.getty.edu/aat/300055863", 
      "type": "Type", 
      "_label": "Provenance Entry"
    },
    {
      "id": "http://vocab.getty.edu/aat/300417642", 
      "type": "Type",
      "_label": "Purchase"
    }
  ], 
  "timespan": [
    {
      "type": "TimeSpan",
      "end_of_the_end": "1949-12-31",
      "begin_of_the_begin": "1949-01-01",
      "identified_by": [ 
        {
          "type": "Name",
          "content": "1949"
        }
      ]
    }
  ],
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
  "part": [
    {
      "type": "Acquisition", 
      "_label": "Acquisition of Painting from Seller",
      "transferred_title_of": [
        {
          "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
          "type": "HumanMadeObject"
        }
      ],
      "transferred_title_from": [
        {
          "type": "Actor",
          "_label": "PREVIOUS_OWNER"
        }
      ],
      "transferred_title_to": [
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
      ]
    }
  ] 
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fprovenance_acquisition.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/provenance_acquisition.rdf.xml)

The specific type of the provenance activity should be added to clarify the particular event as an extra entry in the "classified_as".
URI | Label
--- | -----
http://vocab.getty.edu/aat/300417642 | purchase
http://vocab.getty.edu/aat/300417645 | Loan
http://vocab.getty.edu/aat/300417644 | transfer
http://vocab.getty.edu/aat/300417637 | gift
http://vocab.getty.edu/aat/300417646 | long-term loan
http://vocab.getty.edu/aat/300417641 | bequest

A loan is modelled in a similar fashion, but using the specific part of type "TransferOfCustody".
```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990/activity/2",
  "type": "Activity",
  "_label": "Loan of Painting", 
  "classified_as": [
    {
      "id": "http://vocab.getty.edu/aat/300055863", 
      "type": "Type", 
      "_label": "Provenance Entry"
    },
    {
      "id": "http://vocab.getty.edu/aat/300417645", 
      "type": "Type", 
      "_label": "Loan"
    }
  ], 
  "timespan": [
    {
      "type": "TimeSpan",
      "end_of_the_end": "1949-12-31",
      "begin_of_the_begin": "1949-01-01"
    }
  ],
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
  "part": [
    {
      "type": "TransferOfCustody", 
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300417645", 
          "type": "Type", 
          "_label": "Loan"
        }
      ], 
      "transferred_custody_of": [
        {
          "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
          "type": "HumanMadeObject"
        }
      ],
      "transferred_custody_from": [
        {
          "type": "Actor",
          "_label": "PREVIOUS_OWNER"
        }
      ],
      "transferred_custody_to": [
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
      ]
    }
  ] 
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fprovenance_loan.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/provenance_loan.rdf.xml)

#### Provenance statement
In addition to the definition the provenance phases you can describe the entire provenance of an artwork in free text. This is done using a [statement(https://linked.art/model/object/physical/#materials-statement)
```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "referred_to_by": [
    {
      "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990/provenance-statement", 
      "type": "LinguisticObject", 
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300435438", 
          "type": "Type", 
          "_label": "Provenance Statement", 
          "classified_as": [
            {
              "id": "http://vocab.getty.edu/aat/300418049", 
              "type": "Type", 
              "_label": "Brief Text"
            }
          ]
        }
      ], 
      "content": "..."
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fprovenance_statement.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/provenance_statement.rdf.xml)

### Auctions
Auctions are a specific way to change ownership. Linked Art provides an elaborate model for auctions (https://linked.art/model/provenance/auctions.html). We start with the auction itself, defining the actor that carried it out, the location and the timespan. As a part of the auction we define the specific activities of auctioning a specific lot. The lot then defines the set of objects that are auctioned "uses_specific_object". This set ocontain the actual artworks as the members. The set may also have information about the lot number or information related to prices (so called dimensions).
 
```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/auction/914",
  "type": "Activity",
  "_label_": "Impressionist and modern drawings and watercolors. The properties of: Brown University, Providence, Rhode Island [...].",
  "classified_as": [
    {
      "id": "http://vocab.getty.edu/aat/300054751", 
      "type": "Type", 
      "_label": "Auction Event"
    }
  ], 
  "carried_out_by": [
    {
      "@id": "http://vocab.getty.edu/ulan/500371692",
      "type": "Actor",
      "_label": "Christie's New York"
    }
  ],
  "took_place_at": [
    {
      "@id": "http://vocab.getty.edu/tgn/7007567",
      "type": "Place",
      "_label": "New York"
    }
  ],
  "timespan": [
    {
      "type": "TimeSpan",
      "end_of_the_end": "1979-05-16",
      "begin_of_the_begin": "1979-05-16"
    }
  ],
  "part": [
    {
      "id": "http://vangoghmuseum.nl/data/auction/914/lot/437", 
      "type": "Activity", 
      "_label": "Auction of lot 437", 
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300420001", 
          "type": "Type", 
          "_label": "Auction of Lot"
        }
      ], 
      "carried_out_by": [
        {
          "type": "Person", 
          "_label": "Example Auctioneer"
        }
      ], 
      "used_specific_object": [
        {
          "id": "http://vangoghmuseum.nl/data/auction/914/lot/437/set", 
          "type": "Set", 
          "_label": "Set of Objects for Lot 437",
          "identified_by": [
            {
              "type": "Identifier", 
              "content": "437",
              "classified_as": [
                {
                  "id": "http://vocab.getty.edu/aat/300404628",
                  "type": "Type",
                  "_label": "Lot number"
                }
              ]
            }
          ],
          "member": [
            {
              "id": "http://vangoghmuseum.nl/data/artwork/d0372V1968",
              "type": "HumanMadeObject"
            }
          ],
          "dimension": [
            {
              "type": "MonetaryAmount",
              "value": "30000",
              "classified_as": [
                {
                  "id": "http://vocab.getty.edu/aat/300417244",
                  "type": "Type",
                  "_label": "estimated price"
                }
              ],
              "currency": [
                {
                  "id": "http://vocab.getty.edu/aat/300411998",
                  "type": "Type",
                  "_label": "pound sterling"
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fauction.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/auction.rdf.xml)

(For most relations in Linked Art an inverse relation is available. When modelling the data either of these relations may be used. For example, From lot to set with "used_specific_object" or from set to lot with "used_for". From set to artwork with "member" or from artwork to set with "member_of". For auction to lot with "part" or from lot to auction with "part_of").

The set of objects in the lot may be acquired by someone. This is how the provenance and the auctions are linked together. Linked Art specifies this with a relation between the provenance entry and the object set, "used_specific_object". In addition we advise you to model the causal relation between the provenance entry and the activity of auctioning the lot, using the "caused_by" relation.
```json
{
  "id": "http://vangoghmuseum.nl/data/artwork/d0372V1968/activity/1",
  "type": "Activity",
  "classified_as": [
    {
      "id": "http://vocab.getty.edu/aat/300055863",
      "type": "Type",
      "_label": "provenance"
    }
  ],
  "used_specific_object": [
    {
      "id": "http://vangoghmuseum.nl/data/auction/914/lot/437/set"
    }
  ],
  "caused_by": [
    {
      "id": "http://vangoghmuseum.nl/data/auction/914/lot/437", 
      "type": "Activity", 
      "_label": "Auction of Lot 437"
    }
  ],
  "part": [
    {
      "type": "Acquisition", 
      "_label": "Acquisition of Painting at auction",
      "transferred_title_of": [
        {
          "id": "http://vangoghmuseum.nl/data/artwork/d0372V1968",
          "type": "HumanMadeObject"
        }
      ],
      "transferred_title_from": [
        {
          "type": "Actor",
          "_label": "PREVIOUS_OWNER"
        }
      ],
      "transferred_title_to": [
        {
          "type": "Actor", 
          "_label": "NEW_OWNER"
        }
      ]
    },
    {
      "type": "Payment",
      "paid_amount": [
        {
          "type": "MonetaryAmount",
          "value": "16000",
          "currency": [
            {
              "id": "",
              "type": "Currency",
              "_label": "pound sterling"
            }
          ]
        }
      ]
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fprovenance_auction.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/provenance_auction.rdf.xml)

Also here the set of objects can be related to the provenance entry in both directions. From provenance to set with "used_specific_object". From set to provenance with "used_for". 

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
          "end_of_the_end": "1953-09-20",
          "begin_of_the_begin": "1953-07-23"
        }
      ]
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fexhibition.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/exhibition.rdf.xml)

### Inscriptions
#### Signatures
In Linked Art the textual content of an inscription, such as a signature, is a linguistic object that is carried by the artwork. As we might want to capture the physical characteristics of an inscription, such as the material or color, we first model a part of the artwork to represent the inscription. This part then carries the linguistic content of the inscription.
```json  
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0100V1962",
  "type": "HumanMadeObject",
  "part": [
    {
      "type": "HumanMadeObject",
      "carries": [
        {
          "type": "LinguisticObject", 
          "classified_as": [
            {
              "id": "http://vocab.getty.edu/aat/300028705",
              "type": "Type",
              "_label": "signatures"
            }
          ],
          "content": "Vincent"
        }
      ],
      "made_of": [
        {
          "id": "http://vocab.getty.edu/aat/300015012",
          "type": "Material",
          "_label": "ink"
        }
      ]
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Finscription.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/inscription.rdf.xml)

URI | Label
--- | -----
http://vocab.getty.edu/aat/300028705 | signatures
http://vocab.getty.edu/aat/300028702 | inscriptions

#### Labels
The same pattern is used to model the content of labels added to the arwork, such as stickers or watermarks. 
```json  
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "https://rkd.nl/explore/images/52947",
  "type": "HumanMadeObject",
  "part": [
    {
      "type": "HumanMadeObject",
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300207379",
          "type": "Type",
          "_label": "stickers"
        }
      ],  
      "carries": [
        {
          "type": "LinguisticObject",
          "content": "Kunsthandel Oldenzeel Rotterdam" 
        }
      ]
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Flabels.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/labels.rdf.xml)

Relevant concepts to classify labels:
URI | Label
--- | -----
http://vocab.getty.edu/aat/300207379 | stickers
http://vocab.getty.edu/aat/300028749 | watermark

### Literature
Artworks are referred to in literature such as scientific publications, books or news articles. In Linked art publications are modeled as [linguistic objects](https://linked.art/model/document). A publication is identified by a title in a similar fashion as an artwork. Instead of a production activity linguistic objects have a creation activity. The publication of a linguistic object is modeled as an activity as well.

```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "referred_to_by": [
    {
        "id": "http://vangoghmuseum.nl/data/document/11030", 
      "type": "LinguisticObject",
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300028051", 
          "type": "Type", 
          "_label": "Book"
        }
      ],
      "identified_by": [
        {
          "id": "http://vangoghmuseum.nl/data/document/11030/title",
          "type": "Name", 
          "content": "The complete Van Gogh : paintings, drawings, sketches"
        },
        {
          "type": "Identifier",
          "content": "9780810917019",
          "classified_as": [
            {
              "id": "http://vocab.getty.edu/aat/300417443", 
              "type": "Type", 
              "_label": "ISBN"
            }
          ]
        }
      ], 
      "created_by": {
        "type": "Creation", 
        "carried_out_by": [
          {
            "id": "http://vangoghmuseum.nl/data/document/11030/author1",
            "type": "Person", 
            "_label": "Hulsker, Jan"
          }
        ]
      },
      "used_for": [
        {
          "type": "Activity", 
          "classified_as": [
            {
              "id": "http://vocab.getty.edu/aat/300054686", 
              "type": "Type", 
              "_label": "Publishing"
            }
          ], 
          "carried_out_by": [
            {
              "id": "http://vangoghmuseum.nl/data/document/11030/publisher",
              "type": "Group", 
              "_label": "Abrams"
            }
          ],
          "took_place_at": [
            {
              "id": "http://vangoghmuseum.nl/data/document/11030/publisher_place",
              "type": "Place",
              "_label": "New York"
            }
          ],
          "timespan": [
            {
              "type": "TimeSpan",
              "begin_of_the_begin": "2018-01-01",
              "end_of_the_end": "2018-12-31"
            }
          ]
        }
      ]
    }
  ]
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fliterature.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/literature.rdf.xml)

URI | Label
--- | -----
http://vocab.getty.edu/aat/300417443 | books
http://vocab.getty.edu/aat/300048715 | articles
http://vocab.getty.edu/aat/300026061 | catalogues raisonnés	
http://vocab.getty.edu/aat/300026096 | exhibition catalogs	
http://vocab.getty.edu/aat/300026068 | auction catalogs	
http://vocab.getty.edu/aat/300026074 | sales catalogs	
http://vocab.getty.edu/aat/300264578 | Web pages

#### Literature parts

In other cases the reference to an article is more specific. For example, an article within a book, journal or newspaper. We model the article itself as a Linguistic Object and define that it as part of the book/journal/newspaper/... 

```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "referred_to_by": [
    {
      "id": "http://vangoghmuseum.nl/data/document/11031",
      "type": "LinguisticObject",
      "classified_as": [
        {
          "id": "http://vocab.getty.edu/aat/300048715", 
          "type": "Type", 
          "_label": "articles"
        }
      ],
      "identified_by": [
        {
          "id": "http://vangoghmuseum.nl/data/document/11031/title",
          "type": "Name", 
          "content": "Een vroege Van Gogh voor Het Noordbrabants Museum : het verhaal van een ambitieuze aankoop"
        }
      ], 
      "created_by": {
        "type": "Creation", 
        "carried_out_by": [
          {
            "id": "http://vangoghmuseum.nl/data/document/11031/author1",
            "type": "Person", 
            "_label": "Berger, Helewise"
          }
        ]
      },
      "part_of": [
        {
          "id": "http://vangoghmuseum.nl/data/document/7351"
        }
      ]
    }
  ]
}
```

[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fliterature_article.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/literature_article.rdf.xml)

#### Literature pages
In case the specific part can not be referred to as an article we might be able to still define a set of the pages. In this case we also add an additional linguistic object but use a [pagination statement](https://linked.art/model/document/#pages) to refer to it. 

```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990",
  "type": "HumanMadeObject",
  "referred_to_by": [
    {
      "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990/reference/1",
      "type": "LinguisticObject",
      "part_of": [
        {
          "id": "http://vangoghmuseum.nl/data/document/7351"
        }
      ],
      "referred_to_by": [
        {
          "id": "http://vangoghmuseum.nl/data/artwork/s0416M1990/reference/1/pages",
          "type": "LinguisticObject", 
          "classified_as": [
            {
              "id": "http://vocab.getty.edu/aat/300435440", 
              "type": "Type", 
              "_label": "Pagination Statement"
            }
          ], 
          "content": "125-135"
        }
      ]
    }
  ],
  "content": "..."
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Fliterature_reference.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/literature_reference.rdf.xml)

### Technical research
Artworks are analysed in research activities. The output of this research occurs in the form of technical recordings, such as x-rays, or in the form of research reports.

#### Technical recordings
Technical recordings are itself human made objects and are thus modelled in a similar way as the artworks. A classification is used to indicate the specific type of object. The production activity describes the creator, the creation dates and the technique that is used to create the object. The production activity also defines that the artwork is used as the source (*used_specified_object*) to produce the technical recording. The digital representation follows the same standards as described in [digital representation](#digital-representation), thus using IIIF or a URL.
```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "https://data.rkd.nl/technical/5018290",
  "type": "HumanMadeObject",
  "classified_as": [
    {
      "id": "http://vocab.getty.edu/aat/300419325",
      "type": "Type",
      "_label": "x-radiographs"
    }
  ],
  "produced_by": {
    "id": "https://data.rkd.nl/technical/production/5018290",
    "type": "Production",
    "_label": "Production of the x-ray",
    "used_specific_object": [
      {
        "id": "https://data.rkd.nl/images/52947",
        "type": "HumanMadeObject",
        "_label": "The artwork from which the X-ray is created"
      }
    ],
    "carried_out_by": [
      {
        "id": "https://data.rkd.nl/artists/440500",
        "type": "Actor",
        "_label": "Gerritsen, René"
      }
    ],
    "timespan": [
      {
        "type": "TimeSpan",
        "begin_of_the_begin": "2016-01-19",
        "end_of_the_end": "2016-01-19"
      }
    ],
    "technique": [
      {
        "id": "http://vocab.getty.edu/aat/300419323",
        "type": "Type",
        "_label": "x-ray photography"
      }
    ]
  },
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
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Ftechnical_recording.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/technical_recording.rdf.xml)

Relevant objects types

URI | Label
--- | -----
http://vocab.getty.edu/aat/300419325 | x-radiographs
http://vocab.getty.edu/aat/300046300 | photographs

When a technical recording is classified as a photograph the production technique can be used to provide more detailed information. 

URI | Label
--- | -----
http://vocab.getty.edu/aat/300224399 | raking light

#### Technical reports
Reports are modelled in a similar way as technical recording. The only difference is that we are not modelling the physical object, but a linguistic object. Therefore use LinguistObject as the type and "created_by" instead of "produced_by". The relation to the artwork is also added. 
```json
{
  "@context": "https://linked.art/ns/v1/linked-art.json",
  "id": "https://data.rkd.nl/technical/5001263",
  "type": "LinguisticObject",
  "classified_as": [
    {
      "id": "http://vocab.getty.edu/aat/300027323",
      "type": "Type",
      "_label": "Technical report"
    }
  ],
  "identified_by": [
    {
      "type": "Name", 
      "content": "{Title of the report}"
    }
  ],
  "created_by": {
    "id": "https://data.rkd.nl/technical/creation/5018290",
    "type": "Creation",
    "_label": "Creation of the report",
    "used_specific_object": [
      {
        "id": "https://data.rkd.nl/images/52953",
        "type": "HumanMadeObject",
        "_label": "The artwork investigated in the report"
      }
    ],
    "carried_out_by": [
      {
        "id": "https://data.rkd.nl/artists/443078",
        "type": "Actor",
        "_label": "Werf, P. van der"
      }
    ],
    "timespan": [
      {
        "type": "TimeSpan",
        "begin_of_the_begin": "2016-01-19",
        "end_of_the_end": "2016-01-19"
      }
    ]
  }
}
```
[JSON-LD playground](https://json-ld.org/playground/#startTab=tab-nquads&json-ld=https%3A%2F%2Fraw.githubusercontent.com%2Fvangoghworldwide%2Flinkedart%2Fmaster%2Fexamples%2Fjsonld%2Ftechnical_report.jsonld) | [RDF/XML](https://github.com/vangoghworldwide/linkedart/blob/master/examples/rdfxml/technical_report.rdf.xml)

URI | Label
--- | ------
http://vocab.getty.edu/aat/300027323 | Technical report
