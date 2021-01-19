# Spinque data mapping template for Adlib
This document describes how to convert your collection data in Adlib to Linked Art, using the Spinque Desk data mapping tools. 

We provide examples for the topics describe in the [The Van Gogh Worldwide data guidelines](../README.md). See also the TOC below. 

DISCLAIMER. The examples serve as a guide. You might need to adapt them to your specific scenario. The data exported from Adlib may vary per version and your specific configuration. 

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
* [Exhibitions](#exhibitions) the artwork was used in
* [Inscriptions](#inscriptions) on the artwork such as signatures and labels
* [Literature](#literature) about an artwork
* [Technical research](#technical-research) (e.g. x-rays, technical reports)

## Adlib grouped export format
@TBD describe this format

## Declaring namespaces and common properties
As we will use a number of namespaces throughout the data mapping we declare them up front. 

The objects in your collection will all be identified with a URI. Therefore we start with the base of this URI, for example http://vangoghmuseum.nl/data. 

```xml
<xsl:variable name="base">{{http://YOURDOMAIN.org/data/}}</xsl:variable>
```
Make sure to change ```{{http://YOURDOMAIN.org/data/}}``` in the example above to your base URI ;)

Next we declare variables with the namespace for CIDOC-CRM and the Linked Art.
```xml
<xsl:variable name="crm">http://www.cidoc-crm.org/cidoc-crm/</xsl:variable>
<xsl:variable name="la">https://linked.art/ns/terms/</xsl:variable>
```

Finally we add some shortcuts to properties from the RDF and SKOS vocabularies that we will use frequently.
```xml
<xsl:variable name="type">http://www.w3.org/1999/02/22-rdf-syntax-ns#type</xsl:variable>
<xsl:variable name="skosConcept">http://www.w3.org/2004/02/skos/core#Concept</xsl:variable>
<xsl:variable name="skosPrefLabel">http://www.w3.org/2004/02/skos/core#prefLabel</xsl:variable>
<xsl:variable name="label">http://www.w3.org/2000/01/rdf-schema#label</xsl:variable>
```

## Artwork
To start the data mapping of our Adlib record we create a template that matches the record element. Within this template we create the URI for the artwork and create relation that defines the rdf:type to HumanMadeObject, in CIDOC-CRM the class is defined by the URI http://www.cidoc-crm.org/cidoc-crm/E22_Human-Made_Object. 
```xml
<xsl:template match="record">
  <xsl:variable name="artwork" select="su:uri($base, 'artwork', @priref)"/>
  <spinque:relation subject="{$artwork}" predicate="{$type}" object="{su:uri($crm, 'E22_Human-Made_Object')}"/>
</xsl:template>
```
The uri for the artwork is constructed using the utility function ```su:uri```. It uses the base URI that we declared as a variable on top. Note the use of ```$``` when using variables, ```$base```. To identify the artwork we use the priref attribute that is part of the record element. Note that in xslt ```@``` is used to refer to attributes, ```@priref```. If the priref is provided in a separate element, use `priref` to refer to it.

In the next line we define the type of the artwork. Let's dive into this a bit more because a lot is happening. First of all spinque provides two ways to create triples ```<spinque:relation>``` and ```<spinque:attribute>```. The first is used to define a relation between two resources. The second is used to define a literal attribute such as a string, a date or a number. We will see examples of this later. In the relation we define the subject, predicate and object. The subject is the URI of the artwork that we just created. The predicate uses the $type variable we declare on top for rdf:type. For the object we construct the URI for the class, again using the su:uri utility function.

To process the other elements we use the xslt apply-templates
```xml
<xsl:apply-templates select="*">
  <xsl:with-param name="artwork" select="$artwork"/>
  <xsl:with-param name="production" select="$production"/>
</xsl:apply-templates>
```

## Specific artwork type
```xml
<xsl:template match="object_name">
  <xsl:param name="artwork"/>
  <xsl:variable name="artwork_type" select="su:uri($base, 'term', @linkref)"/>
  <spinque:relation subject="{$artwork}" predicate="{su:uri($crm, 'P2_has_type')}" object="{$artwork_type}"/>
  <spinque:relation subject="{$artwork_type}" predicate="{$type}" object="{su:uri($crm, 'E55_Type')}"/>
  <spinque:attribute subject="{$artwork_type}" attribute="{$skosPrefLabel}" value="{term}" type="string"/>
</xsl:template>
```

## Link to Van Gogh Worldwide URI


## Identifiers
```xml
<xsl:template match="object_number">
  <xsl:param name="artwork"/>
  <xsl:variable name="identifier" select="su:uri($base, 'identifier', .)"/>
  <spinque:relation subject="{$identifier}" predicate="{$type}" object="{su:uri($crm, 'E42_Identifier')}"/>
  <spinque:relation subject="{$identifier}" predicate="{su:uri($crm, 'P2_has_type')}" object="http://vocab.getty.edu/aat/300312355"/>
  <spinque:relation subject="http://vocab.getty.edu/aat/300312355" predicate="{$type}" object="{su:uri($crm, 'E55_Type')}"/>
  <spinque:attribute subject="{$identifier}" attribute="{su:uri($crm, 'P190_has_symbolic_content')}" value="{.}" type="string"/>
  <spinque:relation subject="{$artwork}" predicate="{su:uri($crm, 'P1_is_identified_by')}" object="{$identifier}"/>
</xsl:template>
```

```xml
<xsl:template match="Alternative_number">
  <xsl:param name="artwork"/>
  <xsl:variable name="identifier" select="su:uri($base, 'identifier', alternative_number)"/>
  <spinque:relation subject="{$identifier}" predicate="{$type}" object="{su:uri($crm, 'E42_Identifier')}"/>
  <xsl:choose>
    <xsl:when test="su:normalizeWhiteSpace(alternative_number.type) = 'de la Faille nummer'">
      <spinque:relation subject="{$identifier}" predicate="{su:uri($crm, 'P2_has_type')}" object="https://vangoghworldwide.org/data/concept/f_number"/>
      <spinque:relation subject="https://vangoghworldwide.org/data/concept/f_number" predicate="{$type}" object="{su:uri($crm, 'E55_Type')}"/>
      <spinque:relation subject="{$artwork}" predicate="http://www.w3.org/2000/01/rdf-schema#seeAlso" object="{su:uri('https://vangoghworldwide.org/data/artwork/', alternative_number)}"/>
    </xsl:when>
    <xsl:when test="su:normalizeWhiteSpace(alternative_number.type) = 'Jan Hulsker nummer'">
      <spinque:relation subject="{$identifier}" predicate="{su:uri($crm, 'P2_has_type')}" object="https://vangoghworldwide.org/data/concept/jh_number"/>
      <spinque:relation subject="https://vangoghworldwide.org/data/concept/jh_number" predicate="{$type}" object="{su:uri($crm, 'E55_Type')}"/>
    </xsl:when>
  </xsl:choose>
  <spinque:attribute subject="{$identifier}" attribute="{su:uri($crm, 'P190_has_symbolic_content')}" value="{alternative_number}" type="string"/>
  <spinque:relation subject="{$artwork}" predicate="{su:uri($crm, 'P1_is_identified_by')}" object="{$identifier}"/>
</xsl:template>
```

## Titles
```xml
<xsl:template match="titel">
  <xsl:param name="artwork"/>
  <xsl:variable name="title" select="su:e('title')"/>
  <spinque:relation subject="{$title}" predicate="{$type}" object="{su:uri($crm, 'E33_E41_Linguistic_Appellation')}"/>
  <spinque:relation subject="{$title}" predicate="{su:uri($crm, 'P2_has_type')}" object="http://vocab.getty.edu/aat/300404670"/>
  <spinque:relation subject="http://vocab.getty.edu/aat/300404670" predicate="{$type}" object="{su:uri($crm, 'E55_Type')}"/>
  <spinque:attribute subject="{$title}" attribute="{su:uri($crm, 'P190_has_symbolic_content')}" value="{title}" type="string"/>
  <spinque:attribute subject="{$title}" attribute="{su:uri($crm, 'P72_has_language')}" value="http://vocab.getty.edu/aat/300388256" type="string"/>
  <spinque:relation subject="http://vocab.getty.edu/aat/300388256" predicate="{$type}" object="{su:uri($crm, 'E56_Language')}"/>
  <spinque:relation subject="{$artwork}" predicate="{su:uri($crm, 'P1_is_identified_by')}" object="{$title}"/>
</xsl:template>
```

```xml
  <xsl:template match="title_english">
    <xsl:param name="artwork"/>
    <xsl:variable name="title" select="su:e('title')"/>
    <spinque:relation subject="{$title}" predicate="{$type}" object="{su:uri($crm, 'E33_E41_Linguistic_Appellation')}"/>
    <spinque:relation subject="{$title}" predicate="{su:uri($crm, 'P2_has_type')}" object="http://vocab.getty.edu/aat/300404670"/>
    <spinque:relation subject="http://vocab.getty.edu/aat/300404670" predicate="{$type}" object="{su:uri($crm, 'E55_Type')}"/>
    <spinque:attribute subject="{$title}" attribute="{su:uri($crm, 'P190_has_symbolic_content')}" value="{.}" type="string"/>
    <spinque:attribute subject="{$title}" attribute="{su:uri($crm, 'P72_has_language')}" value="http://vocab.getty.edu/aat/300388277" type="string"/>
    <spinque:relation subject="http://vocab.getty.edu/aat/300388277" predicate="{$type}" object="{su:uri($crm, 'E56_Language')}"/>
    <spinque:relation subject="{$artwork}" predicate="{su:uri($crm, 'P1_is_identified_by')}" object="{$title}"/>
  </xsl:template>
```

## Current owner
As the owners is the same for each object we hardcode it in the record template. 
```xml
<xsl:variable name="organization">https://data.rkd.nl/artists/494309</xsl:variable>
<spinque:relation subject="{$artwork}" predicate="{su:uri($crm, 'P52_has_current_owner')}" object="{$organization}"/>
```

## Production
The production activity is defined in multiple within the Adlib record. Therefore we define the production URI in the record template. In subsequent templates the creator, location and timespan are added to this production. 
```xml
<xsl:variable name="production" select="su:uri($base, 'production', priref)"/>
<spinque:relation subject="{$production}" predicate="{$type}" object="{su:uri($crm, 'E12_Production')}"/>
<spinque:relation subject="{$production}" predicate="{su:uri($crm, 'P108_has_produced')}" object="{$artwork}"/>
```

```xml
<xsl:template match="creator">
  <xsl:param name="production"/>
  <xsl:variable name="person">https://data.rkd.nl/artists/32439</xsl:variable>
  <spinque:relation subject="{$production}" predicate="{su:uri($crm, 'P14_carried_out_by')}" object="{$person}"/>
  <spinque:relation subject="{$person}" predicate="{$type}" object="{su:uri($crm, 'E39_Actor')}"/>
</xsl:template>
```

```xml
<xsl:template match="production.place">
  <xsl:param name="production"/>
  <xsl:variable name="place" select="su:uri($base, 'place', @linkref)"/>
  <spinque:relation subject="{$production}" predicate="{su:uri($crm, 'P7_took_place_at')}" object="{$place}"/>
  <spinque:relation subject="{$place}" predicate="{$type}" object="{su:uri($crm, 'E53_Place')}"/>
  <spinque:attribute subject="{$place}" attribute="{$skosPrefLabel}" value="{term}" type="string"/>
</xsl:template>
```

## Dimensions
```xml
<xsl:template match="dimension.value[position() = 1]">
  <xsl:param name="artwork"/>
  <xsl:variable name="dimension" select="su:e('dimension')"/>
  <spinque:relation subject="{$dimension}" predicate="{$type}" object="{su:uri($crm, 'E54_Dimension')}"/>
  <spinque:attribute subject="{$dimension}" attribute="{su:uri($crm, 'P90_has_value')}" value="{su:normalizeDouble(., 'NL')}" type="double"/>
  <spinque:relation subject="{$dimension}" predicate="{su:uri($crm, 'P2_has_type')}" object="http://vocab.getty.edu/aat/300055644"/>
  <spinque:relation subject="http://vocab.getty.edu/aat/300055644" predicate="{$type}" object="{su:uri($crm, 'E55_Type')}"/>
  <spinque:relation subject="{$dimension}" predicate="{su:uri($crm, 'P91_has_unit')}" object="http://vocab.getty.edu/aat/300379098"/>
  <spinque:relation subject="http://vocab.getty.edu/aat/300379098" predicate="{$type}" object="{su:uri($crm, 'E58_Measurement_Unit')}"/>
  <spinque:relation subject="{$artwork}" predicate="{su:uri($crm, 'P43_has_dimension')}" object="{$dimension}"/>
</xsl:template>
```

```xml
<xsl:template match="dimension.value[position() = 2]">
  <xsl:param name="artwork"/>
  <xsl:variable name="dimension" select="su:e('dimension')"/>
  <spinque:relation subject="{$dimension}" predicate="{$type}" object="{su:uri($crm, 'E54_Dimension')}"/>
  <spinque:attribute subject="{$dimension}" attribute="{su:uri($crm, 'P90_has_value')}" value="{su:normalizeDouble(., 'NL')}" type="double"/>
  <spinque:relation subject="{$dimension}" predicate="{su:uri($crm, 'P2_has_type')}" object="http://vocab.getty.edu/aat/300055647"/>
  <spinque:relation subject="http://vocab.getty.edu/aat/300055647" predicate="{$type}" object="{su:uri($crm, 'E55_Type')}"/>
  <spinque:relation subject="{$dimension}" predicate="{su:uri($crm, 'P91_has_unit')}" object="http://vocab.getty.edu/aat/300379098"/>
  <spinque:relation subject="http://vocab.getty.edu/aat/300379098" predicate="{$type}" object="{su:uri($crm, 'E58_Measurement_Unit')}"/>
  <spinque:relation subject="{$artwork}" predicate="{su:uri($crm, 'P43_has_dimension')}" object="{$dimension}"/>
</xsl:template>
```

## Material
```xml
<xsl:template match="Material">
  <xsl:param name="artwork"/>
  <xsl:variable name="material" select="su:uri($base, 'term', material/term)"/>
  <spinque:relation subject="{$material}" predicate="{$type}" object="{su:uri($crm, 'E57_Material')}"/>
  <spinque:attribute subject="{$material}" attribute="{$label}" value="{material/term}" type="string"/>
  <xsl:choose>
    <xsl:when test="material.part='drager'">
      <xsl:variable name="part" select="su:e('part')"/>
      <spinque:relation subject="{$part}" predicate="{$type}" object="{su:uri($crm, 'E22_Human-Made_Object')}"/>
      <spinque:relation subject="{$part}" predicate="{su:uri($crm, 'P2_has_type')}" object="http://vocab.getty.edu/aat/300014844"/>
      <spinque:relation subject="http://vocab.getty.edu/aat/300055644" predicate="{$type}" object="{su:uri($crm, 'E55_Type')}"/>
      <spinque:relation subject="{$artwork}" predicate="{su:uri($crm, 'P46_is_composed_of')}" object="{$part}"/>
      <spinque:relation subject="{$part}" predicate="{su:uri($crm, 'P45_consists_of')}" object="{$material}"/>
    </xsl:when>
    <xsl:otherwise>
      <spinque:relation subject="{$artwork}" predicate="{su:uri($crm, 'P45_consists_of')}" object="{$material}"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
```

```xml
<xsl:template match="physical_description">
  <xsl:param name="artwork"/>
  <xsl:variable name="statement" select="su:e('statement')"/>
  <spinque:relation subject="{$statement}" predicate="{$type}" object="{su:uri($crm, 'E33_Linguistic_Object')}"/>
  <spinque:attribute subject="{$statement}" attribute="{su:uri($crm, 'P190_has_symbolic_content')}" value="{.}" type="string"/>
  <spinque:relation subject="{$statement}" predicate="{su:uri($crm, 'P2_has_type')}" object="http://vocab.getty.edu/aat/300435429"/>
  <spinque:relation subject="http://vocab.getty.edu/aat/300435429" predicate="{$type}" object="{su:uri($crm, 'E55_Type')}"/>
  <spinque:relation subject="http://vocab.getty.edu/aat/300435429" predicate="{su:uri($crm, 'P2_has_type')}" object="http://vocab.getty.edu/aat/300418049"/>
  <spinque:relation subject="http://vocab.getty.edu/aat/300418049" predicate="{$type}" object="{su:uri($crm, 'E55_Type')}"/>
  <spinque:relation subject="{$artwork}" predicate="{su:uri($crm, 'P67i_is_referred_to_by')}" object="{$statement}"/>
</xsl:template>
```

## Subject type

## Parts

## Digital representation

## Credit / attribution
```xml
<xsl:template match="credit_line">
  <xsl:param name="artwork"/>
  <xsl:variable name="credit_line" select="su:uri($artwork, 'credit_line')"/>
  <spinque:relation subject="{$artwork}" predicate="{su:uri($crm, 'P67i_is_referred_to_by')}" object="{$credit_line}"/> 
  <spinque:relation subject="{$credit_line}" predicate="{$type}" object="{su:uri($crm, 'E33_Linguistic_Object')}"/> 
  <spinque:relation subject="{$credit_line}" predicate="{su:uri($crm, 'P2_has_type')}" object="http://vocab.getty.edu/aat/300026687"/> 
  <spinque:relation subject="http://vocab.getty.edu/aat/300026687" predicate="{$type}" object="{su:uri($crm, 'E55_Type')}"/>
  <spinque:attribute subject="{$credit_line}" attribute="{su:uri($crm, 'P190_has_symbolic_content')}" value="{.}" type="string"/> 
</xsl:template>
```
## Provenance

## Exhibitions
```xml
<xsl:template match="Exhibition">
  <xsl:param name="artwork"/>
  <xsl:variable name="exhibition" select="su:uri($base, 'exhibition', exhibition/@linkref)"/>
  <xsl:variable name="name" select="su:uri($exhibition, 'name')"/>
  <xsl:variable name="timespan" select="su:uri($exhibition, 'timespan')"/>
  <spinque:relation subject="{$exhibition}" predicate="{su:uri($crm, 'P16_used_specific_object')}" object="{$artwork}"/>
  <spinque:relation subject="{$exhibition}" predicate="{$type}" object="{su:uri($crm, 'E7_Activity')}"/>
  <spinque:relation subject="{$exhibition}" predicate="{su:uri($crm, 'P1_is_identified_by')}" object="{$name}"/>
  <spinque:relation subject="{$name}" predicate="{$type}" object="{su:uri($crm, 'E33_E41_Linguistic_Appellation')}"/>
  <spinque:attribute subject="{$name}" attribute="{su:uri($crm, 'P190_has_symbolic_content')}" value="{exhibition/title}" type="string"/>
  <spinque:relation subject="{$exhibition}" predicate="{su:uri($crm, 'P2_has_type')}" object="http://vocab.getty.edu/aat/300054766"/>
  <spinque:relation subject="http://vocab.getty.edu/aat/300054766" predicate="{$type}" object="{su:uri($crm, 'E55_Type')}"/>
  <spinque:relation subject="{$timespan}" predicate="{$type}" object="{su:uri($crm, 'E52_Time-Span')}"/>
  <spinque:relation subject="{$exhibition}" predicate="{su:uri($crm, 'P4_has_time-span')}" object="{$timespan}"/>
  <spinque:attribute subject="{$timespan}" attribute="{su:uri($crm, 'P82a_begin_of_the_begin')}" value="{su:parseDate(exhibition.date.start, 'NL-nl', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy')}" type="date"/>
  <spinque:attribute subject="{$timespan}" attribute="{su:uri($crm, 'P82b_end_of_the_end')}" value="{su:parseDate(exhibition.date.end, 'NL_nl', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy')}" type="date"/>
  <xsl:if test="exhibition.venue != ''">
    <xsl:variable name="organization" select="su:uri($base, 'organization', exhibition.venue)"/>
    <spinque:relation subject="{$exhibition}" predicate="{su:uri($crm, 'P14_carried_out_by')}" object="{$organization}"/>
    <spinque:relation subject="{$organization}" predicate="{$type}" object="{su:uri($crm, 'E39_Actor')}"/>
    <spinque:attribute subject="{$organization}" attribute="{$label}" value="{exhibition.venue}" type="string"/>
  </xsl:if>
  <xsl:if test="exhibition.venue.place != ''">
    <xsl:variable name="place" select="su:uri($base, 'place', exhibition.venue.place)"/>
    <spinque:relation subject="{$exhibition}" predicate="{su:uri($crm, 'P7_took_place_at')}" object="{$place}"/>
    <spinque:relation subject="{$place}" predicate="{$type}" object="{su:uri($crm, 'E53_Place')}"/>
    <spinque:attribute subject="{$place}" attribute="{$label}" value="{exhibition.venue.place}" type="string"/>
  </xsl:if>
</xsl:template>
```

## Inscriptions
```xml
<xsl:template match="Inscription">
  <xsl:param name="artwork"/>
  <xsl:variable name="part" select="su:e('part')"/>
  <spinque:relation subject="{$artwork}" predicate="{su:uri($crm, 'P46_is_composed_of')}" object="{$part}"/>
  <spinque:relation subject="{$part}" predicate="{$type}" object="{su:uri($crm, 'E22_Human-Made_Object')}"/>
  <xsl:variable name="inscription" select="su:e('inscription')"/>
  <spinque:relation subject="{$inscription}" predicate="{$type}" object="{su:uri($crm, 'E33_Linguistic_Object')}"/>
  <spinque:attribute subject="{$inscription}" attribute="{su:uri($crm, 'P190_has_symbolic_content')}" value="{inscription.content}" type="string"/>
  <xsl:choose>
    <xsl:when test="inscription.type/term='signatuur'">
      <spinque:relation subject="{$inscription}" predicate="{su:uri($crm, 'P2_has_type')}" object="http://vocab.getty.edu/aat/300028705"/>
      <spinque:relation subject="http://vocab.getty.edu/aat/300028705" predicate="{$type}" object="{su:uri($crm, 'E55_Type')}"/>
    </xsl:when>
    <xsl:otherwise></xsl:otherwise>
  </xsl:choose>
</xsl:template>
```

## Literature
```xml
<xsl:template match="Documentation">
  <xsl:param name="artwork"/>
  <xsl:variable name="part" select="su:e('part')"/>
  <xsl:variable name="pages" select="su:e('pages')"/>
  <spinque:relation subject="{$part}" predicate="{$type}" object="{su:uri($crm, 'E33_Linguistic_Object')}"/>
  <spinque:relation subject="{$part}" predicate="{su:uri($crm, 'P67i_is_referred_to_by')}" object="{$pages}"/>
  <spinque:relation subject="{$pages}" predicate="{$type}" object="{su:uri($crm, 'E33_Linguistic_Object')}"/>
  <spinque:relation subject="{$pages}" predicate="{su:uri($crm, 'P2_has_type')}" object="http://vocab.getty.edu/aat/300435440"/>
  <spinque:relation subject="http://vocab.getty.edu/aat/300435440" predicate="{$type}" object="{su:uri($crm, 'E55_Type')}"/>
  <spinque:attribute subject="{$pages}" attribute="{su:uri($crm, 'P190_has_symbolic_content')}" value="{documentation.page_reference}" type="string"/>

  <xsl:variable name="document" select="su:uri($base, 'document', documentation.title/@linkref)"/>
  <xsl:variable name="name" select="su:uri($document, 'title')"/>
  <spinque:relation subject="{$document}" predicate="{$type}" object="{su:uri($crm, 'E33_Linguistic_Object')}"/>
  <spinque:relation subject="{$document}" predicate="{su:uri($crm, 'P1_is_identified_by')}" object="{$name}"/>
  <spinque:relation subject="{$name}" predicate="{$type}" object="{su:uri($crm, 'E33_E41_Linguistic_Appellation')}"/>
  <spinque:attribute subject="{$name}" attribute="{su:uri($crm, 'P190_has_symbolic_content')}" value="{documentation.title/title}" type="string"/>
  <spinque:relation subject="{$document}" predicate="{su:uri($crm, 'P2_has_type')}" object="http://vocab.getty.edu/aat/300028051"/>
  <spinque:relation subject="http://vocab.getty.edu/aat/300028051" predicate="{$type}" object="{su:uri($crm, 'E55_Type')}"/>
  
  <xsl:variable name="creation" select="su:uri($document, 'creation')"/>
  <xsl:variable name="author" select="su:uri($base, 'person', documentation.author)"/>
  <spinque:relation subject="{$creation}" predicate="{$type}" object="{su:uri($crm, 'E65_Creation')}"/>
  <spinque:relation subject="{$document}" predicate="{su:uri($crm, 'P94i_was_created_by')}" object="{$creation}"/>
  <spinque:relation subject="{$author}" predicate="{$type}" object="{su:uri($crm, 'E21_Person')}"/>
  <spinque:attribute subject="{$author}" attribute="{$label}" value="{documentation.author}" type="string"/>
  <spinque:relation subject="{$creation}" predicate="{su:uri($crm, 'P14_carried_out_by')}" object="{$author}"/>
  
  <spinque:relation subject="{$artwork}" predicate="{su:uri($crm, 'P67i_is_referred_to_by')}" object="{$part}"/>
  <spinque:relation subject="{$part}" predicate="{su:uri($crm, 'P106i_forms_part_of')}" object="{$document}"/>
</xsl:template>
```

## Technical research