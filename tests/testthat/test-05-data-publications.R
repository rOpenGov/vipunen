testthat::context("Publications")

httptest::with_mock_api({

  resources_url <- "http://api.vipunen.fi/api/resources"
  api_url <- "api/resources/julkaisut"

  test_that("Requests happen", {
    expect_is(httpcache::GET(resources_url), "response")
  })

  test_that("Vipunen API is correctly parsed", {
    expect_is(vipunen_api(api_url), "vipunen_api")
    expect_identical(vipunen_api(api_url)$path,
                     api_url)
  })

  test_that("High-level functions work for publications", {
    # Invalid resource name should raise an error
    expect_error(get_parameters("foobar"),
                 "foobar is not a valid resource name")

    resp <- get_parameters("julkaisut")
    expect_equal(ncol(resp), 2)
    expect_identical(names(resp), c("name", "type"))
  })

})