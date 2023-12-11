test_that("default", {
  expected <- as.character(fs::path_file(rappdirs::user_cache_dir("dchunkr")))
  actual <- as.character(fs::path_file(cache_path()))
  expect_equal(actual, expected)
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
