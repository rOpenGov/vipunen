# valid_resource

Test if a provided argument is a valid resource in Vipunen API. Valid
resources are fetched from the API.

## Usage

``` r
valid_resource(x)
```

## Arguments

- x:

  character name of the resource

## Value

logical TRUE/FALSE

## Examples

``` r
# TRUE
valid_resource("julkaisut")
#> No encoding supplied: defaulting to UTF-8.
#> [1] TRUE
# FALSE
valid_resource("foobar")
#> No encoding supplied: defaulting to UTF-8.
#> [1] FALSE
```
