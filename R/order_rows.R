#' Order the rows of a data frame
#'
#' @param data Data frame.
#' @param .fun Character. A function name.
#'
#' @return Data frame.
#' @export
#'
#' @examples
#' withr::local_seed(123)
#'
#' data <- tibble::tibble(x = 1:5)
#' order_rows(data)
#' order_rows(data, "rev")
#' order_rows(data, "sample")
order_rows <- function(data, .fun = c("identity", "rev", "sample")) {
  .fun <- rlang::arg_match(.fun)
  data[get(.fun)(seq_along(row.names(data))), ]
}
