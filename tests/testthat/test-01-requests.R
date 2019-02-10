RESOURCES <- list("avoin_yliopisto", "erilliset_opinto_oikeudet", "suoritteet",
                  "toimipisteet", "avoin_amk", "amk_talous", "koulutusluokitus",
                  "yo_talous", "suorittanut55", "ytl_arvosanat",
                  "harjoittelukoulut", "alayksikkokoodisto",
                  "koulutuksenkustannukset", "toimitilat", "henkilosto",
                  "muu_henkilosto_amk", "taydennyskoulutukset", "opinnaytetyot",
                  "julkaisut")

RESOURCES_URL <- "http://api.vipunen.fi/api/resources"

testthat::context("Requests")

httptest::with_mock_api({

  api_url <- "api/resources"

  test_that("Requests happen", {
    expect_is(httpcache::GET(RESOURCES_URL), "response")
  })

  test_that("Vipunen API is correctly parsed", {
    expect_is(vipunen_api(api_url), "vipunen_api")
    expect_identical(vipunen_api(api_url)$content,
                     RESOURCES)
    expect_identical(vipunen_api(api_url)$path,
                     api_url)
  })

  test_that("Non-existing path causes a well-behaving error", {
    expect_error(vipunen_api("foo/bar"))
  })
})

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