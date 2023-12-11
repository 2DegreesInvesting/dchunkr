test_that("default", {
  expect_equal(as.character(cache_path()), "~/.cache/dchunkr")
})

test_that("is sensitive to `...`", {
  expect_equal(as.character(cache_path("a", "b.csv")), "~/.cache/dchunkr/a/b.csv")
})

test_that("is sensitive to `cache_dir`", {
  dir <- withr::local_tempfile()
  expect_false(fs::dir_exists(dir))
  cache_path(cache_dir = dir)
  expect_true(fs::dir_exists(dir))
})
