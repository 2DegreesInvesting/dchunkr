#' Create a path to the cache directory, ensuring it exists
#'
#' @inherit fs::path
#' @inheritParams fs::path
#' @param cache_dir Character. A directory for the cache.
#'
#' @return Character. A path.
#' @export
#'
#' @examples
#' dir <- withr::local_tempfile()
#' fs::dir_exists(dir)
#' cache_path("b", cache_dir = dir)
#' fs::dir_exists(dir)
cache_path <- function(..., cache_dir = rappdirs::user_cache_dir("dchunkr")) {
  dir_create(cache_dir)
  path(cache_dir, ...)
}
