test_that("default", {
  expect_equal(as.character(cache_path()), "~/.cache/dchunkr")
})

test_that("is sensitive to `...`", {
  out <- as.character(cache_path("a", "b.csv"))
  expect_equal(fs::path_file(out), "b.csv")
  expect_equal(fs::path_file(fs::path_dir(out)), "a")
})

test_that("is sensitive to `cache_dir`", {
  dir <- withr::local_tempfile()
  expect_false(fs::dir_exists(dir))
  cache_path(cache_dir = dir)
  expect_true(fs::dir_exists(dir))
})
