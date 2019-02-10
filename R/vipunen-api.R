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
#' @importFrom httr content http_error http_type modify_url status_code
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
vipunen_api <- function(path) {
  url <- httr::modify_url("http://api.vipunen.fi", path = path)
  resp <- httpcache::GET(url)

  response_type <- httr::http_type(resp)

  if (response_type == "text/html" && grepl("404 Not Found", httr::content(resp))) {
    stop("Request failed with 404", call. = FALSE)
  } else if (response_type != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = FALSE)

  if (httr::http_error(resp)) {
    stop(
      sprintf(
        "Vipunen API request failed [%s]\n%s\n<%s>",
        httr::status_code(resp),
        parsed$message,
        parsed$documentation_url
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

print.vipunen_api <- function(x, ...) {
  cat("<Vipunen API ", x$path, ">\n", sep = "")
  str(x$content)
  invisible(x)
}