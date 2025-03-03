testthat::context("Data counts")

httptest2::with_mock_api({
  test_that("Only correct resource names are accepted", {
    # This should raise an error
    expect_error(get_data_count("foobar"))
  })

  test_that("Correct counts are returned", {
    # resource = "avoin_yliopisto"
    expect_equal(get_data_count("avoin_yliopisto"), 342)
  })
})
