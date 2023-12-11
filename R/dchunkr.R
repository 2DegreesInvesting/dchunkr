undone_pwalk <- function(job, .f) {
  job |>
    pick_undone() |>
    select(.data$data, .data$file) |>
    future_pwalk(.f, .progress = TRUE)
}
