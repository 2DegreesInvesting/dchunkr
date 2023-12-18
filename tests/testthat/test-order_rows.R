test_that("defaults to returning `data` unchanged", {
  data <- tibble::tibble(x = 1:3)
  out <- order_rows(data)
  expect_equal(out, data)
})

test_that("'rev' reverses rows", {
  data <- tibble::tibble(x = 1:3)
  out <- order_rows(data, .fun = "rev")
  expect_equal(out$x, rev(1:3))
})

test_that("a bad `.fun` throws an error", {
  data <- tibble::tibble(x = 1:3)
  expect_error(order_rows(data, .fun = "bad"), "must be one of")
})

test_that("`.fun` must be character", {
  data <- tibble::tibble(x = 1:3)
  expect_error(order_rows(data, .fun = rev), "must be.* character")
})
