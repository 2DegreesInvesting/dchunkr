#' Nest a data frame by chunks containing all elements of a group
#'
#' @param data A data frame.
#' @param .by A column which values should be.
#' @param chunks Integer. Number of chunks.
#'
#' @return A nested data frame.
#' @export
#'
#' @examples
#' data <- tibble::tibble(id = c(1, 1, 1, 2, 3))
#' out <- nest_chunk(data, .by = "id", chunks = 3)
#' out$data
nest_chunk <- function(data, .by, chunks) {
  stopifnot(hasName(data, .by))
  stopifnot(chunks > 1)

  data |>
    nest(.by = all_of(.by)) |>
    mutate(data, chunk = as.integer(cut(row_number(), chunks))) |>
    unnest(data) |>
    nest(.by = "chunk")
}
