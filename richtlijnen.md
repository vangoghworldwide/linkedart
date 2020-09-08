# Richtlijnen Van Gogh Worldwide - minimale verplichte informatie

Uit: Evelien de Visser & Marijke Heslenfeld, _Richtlijnen Van Gogh Worldwide_, versie 1.2, dd. 03-12-2019

## Kunsthistorische metadata
### Metadata identificatie
Naam | Uitleg | Linked Art patroon | Wat staat er in de database?
--- | ----- | ----- | -----
Toeschrijving/vervaardiger | Wie heeft het kunstwerk gemaakt? Aan wie is het toegeschreven? | [production](https://github.com/vangoghworldwide/linkedart#production) | URI uit RKDartists (of ULAN)
Status | Gaat over de status van de toeschrijving: huidig, verworpen. | [previous attribution](https://github.com/vangoghworldwide/linkedart#previous-attribution) | ???
Datering | Wanneer is het kunstwerk gemaakt? Zo nauwkeurig mogelijk. | [production](https://github.com/vangoghworldwide/linkedart#production) | Twee velden: begindatum en einddatum. Beide in ISO formaat (dwz bv. "1890-04-06").
Titel | Titel(s) van het kunstwerk, waaronder ook oude titels uit bijvoorbeeld veilingcatalogi of tentoonstellingscatalogi waaruit een duidelijk verkeerde/andere interpretatie van het onderwerp blijkt. | [titles](https://github.com/vangoghworldwide/linkedart#titles) | String, bij voorkeur in het Engels
Vervaardigd in plaats/land | Waar heeft Van Gogh het werk het gemaakt? | [production](https://github.com/vangoghworldwide/linkedart#production) | URI uit TGN
Onderwerpstrefwoord (uit de terminologiebronnen) | Trefwoorden die aangeven wat er op het schilderij staat afgebeeld. Tot welk genre behoort het kunstwerk? Welk onderwerp/gebeurtenis staat er op het schilderij afgebeeld? Wie is er afgebeeld? | [subject-type](https://github.com/vangoghworldwide/linkedart#subject-type) | URI uit AAT
identificatie-nummer | De la Faille-nummer (oeuvrecatalogus 1970) van het kunstwerk/Hulsker-nummer (oeuvrecatalogus 1996) van het kunstwerk/Hyperion-nummer (oeuvrecatalogus 1939) van het kunstwerk | [identifiers](https://github.com/vangoghworldwide/linkedart#identifiers) | Twee velden: string met oeuvre verwijzing (bv. JH 23452) en URI uit de lijst van VGWW kunstwerken.

### Metadata fysieke kenmerken
Naam | Uitleg | Linked Art patroon | Wat staat er in de database?
----- | ----- | ----- | -----
Objecttype | Wat voor type object is het kunstwerk? Schilderij, tekening, prent, aquarel etc. | [specific artwork type](https://github.com/vangoghworldwide/linkedart#specific-artwork-type) | Een veld: URI uit de AAT (bv. voor 'schilderijen')
Materiaal/techniek | Met welke techniek (1) en welk materiaal (2) is het kunstwerk gemaakt? Welke drager (3) en schilder/ tekenmaterialen zijn gebruikt? | [material](https://github.com/vangoghworldwide/linkedart#material) & [material-support](https://github.com/vangoghworldwide/linkedart#material-support) | Drie velden: alledrie URI's uit de AAT
Afmetingen | Wat zijn de afmetingen van het kunstwerk? | [dimensions](https://github.com/vangoghworldwide/linkedart#dimensions) | Twee keer drie velden. Type (bv. hoogte, breedte): een URI uit de AAT; waarde (bv. 54.4) in Amerikaanse notatie; eenheid (bv. 'cm'): een URI uit de AAT.

### Metadata opschriften/merken (Indien aanwezig)
Naam | Uitleg | Linked Art patroon
--- | ----- | -----
Positie | Waar is het opschrift gesitueerd? | 
Soort | Wat voor soort opschrift is het? | [inscriptions](https://github.com/vangoghworldwide/linkedart#inscriptions)
Inhoud | Transcriptie van het opschrift | [inscriptions](https://github.com/vangoghworldwide/linkedart#inscriptions)

### Metadata collecties
Naam | Uitleg | Linked Art patroon
--- | ----- | -----
Soort collectie | Museum, instelling, particuliere collectie | ??? [current owner](https://github.com/vangoghworldwide/linkedart#current-owner)
Eigenaar | Wie heeft het kunstwerk door de tijd heen in zijn bezit gehad of beheerd? Dit kan een museum, instelling, (particuliere) collectie zijn. | [provenance](https://github.com/vangoghworldwide/linkedart#provenance)
Plaats | De plaats waar het kunstwerk zich bevindt/bevond | [provenance](https://github.com/vangoghworldwide/linkedart#provenance)
Inventarisnummer | Nummer dat de eigenaar gebruikt(e) om het kunstwerk te identificeren | [identifier](https://github.com/vangoghworldwide/linkedart#identifier)
Begin-en einddatum | Sinds en tot wanneer heeft de eigenaar het kunstwerk in het bezit (gehad)? | [provenance](https://github.com/vangoghworldwide/linkedart#provenance)
Creditline collectie | Verantwoording eigenaar/beherende instelling |

### Metadata tentoonstellingen
Naam | Uitleg | Linked Art patroon
--- | ----- | -----
Tentoonstellingstitel| De titel van de tentoonstelling. | [exhibitions](https://github.com/vangoghworldwide/linkedart#exhibitions)
Instelling | De instelling(en) waar de tentoonstelling heeft plaatsgevonden. | [exhibitions](https://github.com/vangoghworldwide/linkedart#exhibitions)
Plaats | De plaats(en) waar de tentoonstelling heeft plaatsgevonden. | [exhibitions](https://github.com/vangoghworldwide/linkedart#exhibitions)
Begin-en einddatum| Wanneer de tentoonstelling heeft plaatsgevonden. | [exhibitions](https://github.com/vangoghworldwide/linkedart#exhibitions)
catalogusnummer| Het nummer dat het kunstwerk heeft in de tentoonstellingscatalogus. | 

### Metadata literatuur/bronnen
Naam | Uitleg | Linked Art patroon
--- | ----- | -----
Bibliografische referentie/literatuurverwijzing | Literatuur waarin het werk wordt vermeld, met bijhorend paginanummer en of het al dat niet is geïllustreerd en aangegeven in welke bibliotheek het te vinden is (d.m.v. link naar bv. Worldcat) | [literature](https://github.com/vangoghworldwide/linkedart#literature)
Brief | Verwijzing naar de brief waarin het kunstwerk wordt genoemd (d.m.v. permalink naar brievenwebsite) | Deze wordt gerealiseerd vanuit de brievenwebsite en hoeft niet te worden aangeleverd vanuit het collectieregistratiesysteem

## Materiaal-technische documentatie en informatie

### Context
Naam | Uitleg | Linked Art patroon
--- | ----- | -----
Kunstwerk | Welk kunstwerk is onderzocht? | [technical-research](https://github.com/vangoghworldwide/linkedart#technical-research)
Project | Context van het onderzoek: restauratie, onderzoek, tentoonstelling etc. | 

### Metadata onderzoek/document
Naam | Uitleg | Linked Art patroon
--- | ----- | -----
Type onderzoek | Röntgenonderzoek, infrarood onderzoek etc. | [technical-research](https://github.com/vangoghworldwide/linkedart#technical-research)
documentatietype | Beschrijving van het document: zwart-wit foto, Röntgenfilm, negatief, onderzoeksverslag etc. | [technical-research](https://github.com/vangoghworldwide/linkedart#technical-research)
Onderzoeker/maker | Betrokkenen bij het onderzoek | [technical-research](https://github.com/vangoghworldwide/linkedart#technical-research)
Begin-en einddatum | Wanneer heeft het onderzoek plaatsgevonden? | [technical-research](https://github.com/vangoghworldwide/linkedart#technical-research)
Verblijfplaats | Waar bevindt het document zich? |
Standplaats | Waar bevindt het document zich binnen de instelling? |

### Metadata bestand (Indien gedigitaliseerd) 
Naam | Uitleg | Linked Art patroon
--- | ----- | -----
Bestandsnaam | Bestandsnaam van gedigitaliseerde document |
Maker | Wie heeft het document gedigitaliseerd? Bv. het bedrijf |
Datum | Wanneer is het document gedigitaliseerd? |
licenties | Verwijzing naar CCC licenties of naar de eigenaar van de afbeelding d.m.v. creditline |
