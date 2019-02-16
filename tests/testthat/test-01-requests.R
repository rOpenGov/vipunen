testthat::context("Requests")

httptest::with_mock_api({
  resources_url <- "http://api.vipunen.fi/api/resources"
  api_url <- "api/resources"
  resources <- list("avoin_yliopisto", "erilliset_opinto_oikeudet", "suoritteet",
                    "toimipisteet", "avoin_amk", "amk_talous", "koulutusluokitus",
                    "yo_talous", "suorittanut55", "ytl_arvosanat",
                    "harjoittelukoulut", "alayksikkokoodisto",
                    "koulutuksenkustannukset", "toimitilat", "henkilosto",
                    "muu_henkilosto_amk", "taydennyskoulutukset", "opinnaytetyot",
                    "julkaisut")

  test_that("Requests happen", {
    expect_is(httpcache::GET(resources_url), "response")
  })

  test_that("Vipunen API is correctly parsed", {
    expect_is(vipunen_api(api_url), "vipunen_api")
    expect_identical(vipunen_api(api_url)$content,
                     resources)
    expect_identical(vipunen_api(api_url)$path,
                     api_url)
  })

  test_that("vipunen_api object prints", {
    expect_output(print(vipunen_api(api_url)))
  })

  test_that("Non-existing path causes a well-behaving error", {
    expect_error(vipunen_api("foo/bar"))
  })

  test_that("HTTP errors are dealt properly", {
    # NOTE: "suoritteet" is a valid resource name, BUT the mocked response
    # object is sourced from a manually edited file
    expect_error(vipunen_api(paste0(api_url, "/suoritteet")),
                 "Vipunen API request failed")
  })
})
