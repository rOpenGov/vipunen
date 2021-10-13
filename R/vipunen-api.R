#' get_data_count
#'
#' Get the count of data items available through the API, which is useful for
#' estimating the maximum number of items available.
#'
#' @param resource character name of the resource. Name provided must be a valid
#'                 resource name.
#'
#' @importFrom glue glue
#' @importFrom httr content
#'
#' @return numeric count of data items.
#' @export
#'
#' @examples
#' get_data_count("avoin_yliopisto")
get_data_count <- function(resource) {
  if (!valid_resource(resource)) {
    stop(resource, " is not a valid resource name", call. = FALSE)
  }

  # Define a general url pattern in which the resource can be changed
  count_url <- glue::glue("api/resources/{resource}/data/count")

  # Get the requested response and its content and coerce to numeric
  count <- vipunen_api(count_url)$content

  return(count)
}

#' get_parameters
#'
#' Low level function used for getting the valid API query parameters for
#' a given resource endpoint.
#'
#' @param resource character name of the resource. Name provided must be a valid
#'                 resource name.
#'
#' @importFrom dplyr bind_rows
#' @importFrom httr content
#' @importFrom magrittr %>%
#' @importFrom purrr map
#'
#' @return tibble of query parameters.
#' @export
#'
#' @examples
#' params <- get_parameters("julkaisut")
get_parameters <- function(resource) {
  if (!valid_resource(resource)) {
    stop(resource, " is not a valid resource name", call. = FALSE)
  }

  # Resource needs to be appended to an url body
  resource_url <- paste0("api/resources/", resource)

  # Get the requested response and its content, and bind to a tibble
  params <- vipunen_api(resource_url)$content %>%
    dplyr::bind_rows()

  return(params)
}

#' vipunen_api
#'
#' Make a request to one of the Vipunen API's endopoints. The base url is
#' http://api.vipunen.fi to which a specific url defined by `path` is
#' appended.
#'
#' This is a low-level function intended to be used by other higher level
#' functions in the package.
#'
#' @param path character url to be appended to the host.
#'
#' @importFrom httr content http_error http_type modify_url status_code user_agent
#' @importFrom httpcache GET
#' @importFrom jsonlite fromJSON
#'
#' @return vipunen_api (S3) object with the following attributes:
#'        \describe{
#'           \item{content}{a list of parsed JSON content.}
#'           \item{path}{path provided to get the resonse.}
#'           \item{response}{the original response object.}
#'         }
#'
#' @export
#'
#' @examples
#' # Get available resources
#' vipunen_api("api/resources")
vipunen_api <- function(path) {
  ua <- httr::user_agent("https://github.com/rOpenGov/vipunen")

  url <- httr::modify_url("http://api.vipunen.fi", path = path)
  resp <- httpcache::GET(url, ua)

  parsed <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = FALSE)

  if (httr::http_error(resp)) {
    stop(
      sprintf(
        "Vipunen API request failed [%s]",
        httr::status_code(resp)
      ),
      call. = FALSE
    )
  }

  api_obj <- structure(
    list(
      content = parsed,
      path = path,
      response = resp
    ),
    class = "vipunen_api"
  )

  return(api_obj)
}

#' Print method for vipunen_api class
#'
#' @param x vipunen_api object
#' @param ... ignored
#'
#' @importFrom utils str
#'
#' @return vipunen_api object
#' @export
#'
#' @examples
#' # Get available resources
#' v <- vipunen_api("api/resources")
#' print(v)
print.vipunen_api <- function(x, ...) {
  cat("<Vipunen API ", x$path, ">\n", sep = "")
  str(x$content)
  invisible(x)
}
