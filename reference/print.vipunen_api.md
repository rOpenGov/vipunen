# Print method for vipunen_api class

Print method for vipunen_api class

## Usage

``` r
# S3 method for class 'vipunen_api'
print(x, ...)
```

## Arguments

- x:

  vipunen_api object

- ...:

  ignored

## Value

vipunen_api object

## Examples

``` r
# Get available resources
v <- vipunen_api("api/resources")
#> No encoding supplied: defaulting to UTF-8.
print(v)
#> <Vipunen API api/resources>
#> List of 42
#>  $ : chr "erilliset_opinto_oikeudet"
#>  $ : chr "esi_ja_perusopetus_oppilaat_lukuvuosi_koulutusmuoto"
#>  $ : chr "perusopetus_oppilaat_lukuvuosi_oppilaitos"
#>  $ : chr "lukio_opiskelijat_vuosi_tutkinto"
#>  $ : chr "yo_talous2"
#>  $ : chr "avoin_amk"
#>  $ : chr "amk_talous"
#>  $ : chr "lukio_opiskelijat_kuukausi_maakunta"
#>  $ : chr "suorittanut55"
#>  $ : chr "harjoittelukoulut"
#>  $ : chr "tavoiteajassa_tutkinnon_suorittaneet"
#>  $ : chr "henkilosto"
#>  $ : chr "amm_perusrahoituksen_kohdennukset"
#>  $ : chr "taydennyskoulutukset"
#>  $ : chr "amm_myonnetty_rahoitus"
#>  $ : chr "opinnaytetyot"
#>  $ : chr "amm_rahoitus_opiskelijavuodet"
#>  $ : chr "julkaisut"
#>  $ : chr "avoin_yliopisto"
#>  $ : chr "suoritteet"
#>  $ : chr "amk_opintopisteet_kuukausi"
#>  $ : chr "opiskelijat_ja_tutkinnot"
#>  $ : chr "toimipisteet"
#>  $ : chr "amm_opiskelijat_ja_tutkinnot_kuukausi_maakunta"
#>  $ : chr "amm_rahoitusperusteet_ja_myonnetty_rahoitus"
#>  $ : chr "korkeakoulutus_kv_liikkuvuus"
#>  $ : chr "yo_opintopisteet"
#>  $ : chr "amm_harkinnanvarainen_rahoitus"
#>  $ : chr "amk_opintopisteet"
#>  $ : chr "koulutusluokitus"
#>  $ : chr "yo_talous"
#>  $ : chr "amk_talous2"
#>  $ : chr "ytl_arvosanat"
#>  $ : chr "korkeakoulutus_hakeneet_ja_paikan_vastaanottaneet"
#>  $ : chr "alayksikkokoodisto"
#>  $ : chr "koulutuksenkustannukset"
#>  $ : chr "toimitilat"
#>  $ : chr "muu_henkilosto_amk"
#>  $ : chr "yamk_tutkinnot"
#>  $ : chr "perusopetuksen_jalkeinen_koulutus_hakeneet_ja_paikan_vastaanottaneet"
#>  $ : chr "amm_opiskelijat_ja_tutkinnot_vuosi_tutkinto"
#>  $ : chr "yo_opintopisteet_kuukausi"
```
