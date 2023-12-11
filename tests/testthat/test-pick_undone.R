test_that("picks rows with file that do not exist", {
  data <- tibble::tibble(
    file = c(
      withr::local_tempdir(pattern = "exists_"),
      withr::local_tempfile(pattern = "doesnt_exist_")
    )
  )
  out <- pick_undone(data)
  expect_true(grepl("doesnt_exist", out$file))
  expect_false(out$done)
})

test_that("without the column `file`, errors gracefully", {
  expect_error(pick_undone(tibble::tibble(lacks_file = "bad")), "file")
})
