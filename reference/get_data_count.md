# get_data_count

Get the count of data items available through the API, which is useful
for estimating the maximum number of items available.

## Usage

``` r
get_data_count(resource)
```

## Arguments

- resource:

  character name of the resource. Name provided must be a valid resource
  name.

## Value

numeric count of data items.

## Examples

``` r
get_data_count("avoin_yliopisto")
#> No encoding supplied: defaulting to UTF-8.
#> No encoding supplied: defaulting to UTF-8.
#> [1] 654
```
