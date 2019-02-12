testthat::context("Cache")

httptest::without_internet({
  test_that("When the cache is set, can read from it even with no connection", {
    expect_identical(httpcache::GET("http://api.vipunen.fi/api/resources")$url,
                     "http://api.vipunen.fi/api/resources")
  })
  test_that("But uncached() prevents reading from the cache", {
    expect_error(httpcache::uncached(httpcache::GET("http://api.vipunen.fi/api/resources")),
                 "GET http://api.vipunen.fi/api/resources")
  })
})