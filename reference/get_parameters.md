# get_parameters

Low level function used for getting the valid API query parameters for a
given resource endpoint.

## Usage

``` r
get_parameters(resource)
```

## Arguments

- resource:

  character name of the resource. Name provided must be a valid resource
  name.

## Value

tibble of query parameters.

## Examples

``` r
params <- get_parameters("julkaisut")
#> No encoding supplied: defaulting to UTF-8.
#> No encoding supplied: defaulting to UTF-8.
```
