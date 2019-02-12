testthat::context("Package utilities")

test_that("Resource validation works", {
  expect_identical(valid_resource("suoritteet"), TRUE)
  expect_identical(valid_resource("julkaisut"), TRUE)
  expect_identical(valid_resource("foobar"), FALSE)
})
