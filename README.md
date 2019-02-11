[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build status](https://travis-ci.org/rOpenGov/vipunen.svg?branch=master)](https://travis-ci.org/rOpenGov/vipunen)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/rOpenGov/vipunen?branch=master&svg=true)](https://ci.appveyor.com/project/rOpenGov/vipunen)
[![Coverage status](https://codecov.io/gh/rOpenGov/vipunen/branch/master/graph/badge.svg)](https://codecov.io/github/rOpenGov/vipunen?branch=master)

# vipunen

<img align="right" src="inst/vipunen_logo_258.png">

`vipunen` is a client package for [Vipunen](https://vipunen.fi/en-gb/), the 
education administration's reporting portal. The Ministry of Education and 
Culture and the Finnish National Agency for Education are jointly responsible for 
the content on Vipunen, but have nothing to do with this R package.

Statistical data from Vipunen is also machine readable through a REST/JSON API.
The API was opened in August 2017 and is currently still in development phase.
In this first phase, the content is moslty related to the data collected from 
universities.

For further details about the API (in Finnish only), please see:

https://vipunen.fi/fi-fi/Sivut/Vipunen-API

## Installation

`vipunen` is not yet on CRAN, but you can install it from GitHub with:

``` r
install.packages("remotes")
remotes::install_github("ropengov/vipunen")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
## basic example code
```

