test_that("without the column `chunk` errors gracefully", {
  data <- tibble::tibble(lacks_chunk = "bad")
  expect_error(add_file(data, parent = "a"), "chunk")
})

test_that("adds a file", {
  data <- tibble::tibble(chunk = 1:2)
  out <- add_file(data, parent = "a")
  expect_equal(as.character(out$file), c("a/1.rds", "a/2.rds"))
})

test_that("is sensitive to `ext`", {
  data <- tibble::tibble(chunk = 1:2)
  out <- add_file(data, parent = "a", ext = ".csv")
  expect_equal(as.character(out$file), c("a/1.csv", "a/2.csv"))
})
