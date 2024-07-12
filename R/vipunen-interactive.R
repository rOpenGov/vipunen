#' vipunen_interactive
#'
#' Interactive function that helps to fetch data from Vipunen API
#'
#'
#'
#' @return fetched data and prompt
#' @export
#'
#' @examples
#'
vipunen_interactive <- function() {
  print(get_resource_names())

  resource_name <- readline(prompt = "Enter resource name for the data: ")
  co = get_data_count(resource_name)
  message(paste0("Total number of rows: ",co))


  rows <- switch(
    menu(c("Yes", "No"),
         title = "Return all rows?")+1,
    return(invisible()),TRUE,FALSE)

if(!rows) {
    while (TRUE) {
      input <- readline(prompt = paste("Enter a number between 1 and", co, ": "))

      num <- as.numeric(input)

      # Check if input is a number and within the valid range
      if (!is.na(num) && num >= 1 && num <= co) {
        limit = num
        break
      } else {
        cat("Invalid input. Please enter a number between 1 and", co, "\n")
      }
    }
  return(get_data(resource_name, limit=limit))
} else {
  return(get_data(resource_name))
}

}
