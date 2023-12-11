#' Adds the `file` column to a data frame
#'
#' @param data A data frame.
#' @param parent A directory.
#' @param ext An extension.
#'
#' @return A data frame.
#' @export
#'
#' @examples
#' data <- tibble::tibble(chunk = 1)
#' add_file(data, parent = tempdir())
add_file <- function(data, parent, ext = ".rds") {
  stopifnot(hasName(data, "chunk"))
  dir_create(parent)
  mutate(data, file = path(parent, paste0(.data$chunk, ext)))
}
