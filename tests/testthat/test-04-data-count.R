testthat::context("Data counts")

httptest::with_mock_api({

  test_that("Correct counts are returned", {
    # resource = "avoin_yliopisto"
    expect_equal(get_data_count("avoin_yliopisto"), 342)
  })

})