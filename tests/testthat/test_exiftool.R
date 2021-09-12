testthat::test_that("Exiftool can be found", {
  expect_true(suppressWarnings(check_exiftool()))
  expect_error(suppressWarnings(check_exiftool(toolname = "not_exiftool")))
})
