#' @title Crate a Data Bibliography
#'
#' @description
#' Crates a bibliography from selected resource.
#'
#'
#' @param resource resource name from Vipunen API
#' @param format Default is "Biblatex", alternatives are "bibentry" or "Bibtex".
#'
#' @return a Biblatex, bibentry or Bibtex object.
#'
#' @seealso [utils::bibentry()] [RefManageR::toBiblatex()]
#'
#' @references See citation("sotkanet")
#'
#' @importFrom RefManageR toBiblatex
#' @importFrom utils toBibtex person
#' @importFrom lubridate ymd year
#' @examples
#' \dontrun{
#' vipunen_cite("koulutusluokitus")
#' }
#' @export
vipunen_cite <- function(resource,
                          format = "Biblatex"){

  format <- tolower(as.character(format))



  if(!(resource %in% get_resource_names())){
    stop("The resource doesn't match any in the database")
  }


  if(!format %in% c("bibentry", "bibtex", "biblatex")){
    warning("The ", format, " is not recognized, will return Biblatex as default.")
    format <- "biblatex"
  }

  datadate = max(get_data(resource)$tietojoukkoPaivitettyPvm)

  urldate <- as.character(Sys.Date())

  last_update_date <- lubridate::ymd(datadate)
  last_update_year <- lubridate::year(last_update_date)

  ref <- RefManageR::BibEntry(
    bibtype = "Misc",
    title = paste(resource),
    url = paste0("http://api.vipunen.fi/api/resources/",resource,"/data"),
    organization = "Vipunen - opetushallinnon tilastopalvelu",
    year = last_update_year,
    author = utils::person(given = ""),
    urldate = urldate,
    type = "Dataset",
    note = paste0("Accessed ", as.Date(urldate),
                  ", dataset last updated ", as.Date(last_update_date))
  )

  if(format == "bibtex"){
    ref <- utils::toBibtex(ref)
  } else if (format == "biblatex"){
    ref <- RefManageR::toBiblatex(ref)
  }
  ref
}