#' Add and filter (un)done files in a data frame
#'
#' @param data A data frame with the column `file`.
#'
#' @return A data frame.
#' @export
#'
#' @examples
#' data <- tibble::tibble(file = c(
#'   withr::local_tempdir(pattern = "exists_"),
#'   withr::local_tempfile(pattern = "doesnt_exist_")
#' ))
#' data
#'
#' pick_undone(data)
pick_undone <- function(data) {
  data |>
    add_done() |>
    filter(!.data$done)
}

add_done <- function(data, file) {
  stopifnot(hasName(data, "file"))
  mutate(data, done = unname(file_exists(file)))
}
