test_that("without the columh specified in `.by`, errors gracefully", {
  data <- tibble::tibble(lacks_id = 1)
  expect_snapshot_error(nest_chunk(data, .by = "x"))
})

test_that("each unique value of .by stays in the same chunk", {
  data <- tibble::tibble(id = c(1, 1, 2))
  out <- nest_chunk(data, .by = "id", chunks = 2)
  chunk2 <- filter(unnest(out, data), chunk == 2)$id
  expect_false(any(chunk2 == 1))
})

test_that("if the number of chunks isn't greater than 1, errors gracefully", {
  data <- tibble::tibble(id = 1)
  expect_error(nest_chunk(data, .by = "id", chunks = 1), "> 1")
})
