
#' get_resource_names
#'
#' Get the resource names available through the API.
#'
#'
#' @return vector of valid resource names
#' @export
#'
#' @examples
#' get_resource_names()
get_resource_names <- function() {
  return(unlist(vipunen_api("api/resources")$content))
}


#' get_data_count
#'
#' Get the count of data items available through the API, which is useful for
#' estimating the maximum number of items available.
#'
#' @param resource character name of the resource. Name provided must be a valid
#'                 resource name.
#'
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
  count_url <- paste0("api/resources/",resource,"/data/count")

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
  params <- vipunen_api(resource_url)$content |>
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
#' @importFrom httr2 request req_user_agent req_url_path_append resp_is_error resp_body_json
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
vipunen_api <- function(path,timeout = 60) {



  url <- httr2::request("http://api.vipunen.fi") |>
    httr2::req_user_agent("https://github.com/rOpenGov/vipunen") |>
    httr2::req_url_path_append(path) |> httr2::req_cache(tempdir())



if(grepl("/data",url$url) & !grepl("/count",url$url)) {
  resu =sub(paste0(".*/resources/(.*?)/data.*"), "\\1", url$url)
  message(paste("Total rows in unfiltered data:",get_data_count(resu),"\n"))

}



resp = tryCatch(url |> httr2::req_timeout(timeout) |> httr2::req_perform(),
                httr2_http = function(cnd) {
                  rlang::abort("Vipunen API request failed [%s]", parent = cnd)})



  parsed = resp |> httr2::resp_body_json(simplifyVector = T)


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


#' get_data
#'
#' Low level function used for getting the data for
#' a given resource endpoint.
#'
#' @param resource character name of the resource. Name provided must be a valid
#'                 resource name.
#'
#' @importFrom dplyr bind_rows
#' @importFrom purrr map
#'
#' @return tibble of query parameters.
#' @export
#'
#' @examples
#' data <- get_data("julkaisut")

get_data <- function(resource, limit=NULL) {
  if (!valid_resource(resource)) {
    stop(resource, " is not a valid resource name", call. = FALSE)
  }
  if (!is.null(limit)) {
    if(is.numeric(limit)) {
      if(limit <0) {
        stop("Limit parameter is invalid, please select a positive integer.", call. = FALSE)
      }
    } else {
      stop("Limit parameter is invalid, please select a positive integer.", call. = FALSE)
    }
  }


  tim = get_data_count(resource)

  # Define a general url pattern in which the resource can be changed
  data_url <- paste0("api/resources/",resource,"/data")
  if(!is.null(limit)) {
    data_url <- paste0(data_url,"?limit=",limit)
  }

#'/count?filter=tilastovuosi==", tilastovuosi)
#'

  data <- vipunen_api(data_url,timeout = tim/10)$content

  return(data)
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
