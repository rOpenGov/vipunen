testthat::context("Data counts")

httptest::with_mock_api({

  api_host <- "http://api.vipunen.fi"
  # Define a general url pattern in which the resource can be changed
  count_url_pattern <- "api/resources/{resource}/data/count"

  resource <- "avoin_yliopisto"
  count_url <- glue::glue(count_url_pattern)

  test_that("Requests happen", {
    expect_is(httr::GET(httr::modify_url(api_host, path = count_url)),
              "response")
  })

  test_that("Correct counts are returned", {
    # resource = "avoin_yliopisto"
    expect_equal(get_data_count(count_url), 342)
  })

  test_that("Non-existing path causes a well-behaving error", {
    expect_error(vipunen_api("foo/bar"))
  })
})