#' valid_resource
#'
#' Test if a provided argument is a valid resource in Vipunen API. Valid
#' resources are fetched from the API.
#'
#' @param x character name of the resource
#'
#' @return logical TRUE/FALSE
#' @export
#'
#' @examples
#' # TRUE
#' valid_resource("julkaisut")
#' # FALSE
#' valid_resource("foobar")
valid_resource <- function(x) {
  resources <- unlist(vipunen_api("api/resources")$content)
  return(x %in% resources)
}
