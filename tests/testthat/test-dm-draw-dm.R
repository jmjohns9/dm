test_that("API", {
  expect_identical(
    color_quos_to_display(
      flights = "blue",
      airlines = ,
      airports = "orange",
      planes = "green_nb"
    ),
    set_names(
      c("flights", "airlines", "airports", "planes"),
      c("blue", "orange", "orange", "green_nb")
    )
  )
})

test_that("`dm_set_colors()` works", {
  expect_identical(
    dm_set_colors(
      dm_nycflights_small,
      blue = starts_with("air"),
      green = contains("h")
    ) %>%
      dm_get_colors(),
    set_names(
      src_tbls(dm_nycflights_small),
      c("#00FF00", NA_character_, "#0000FF", "#0000FF", "#00FF00")
    )
  )

  # test splicing
  colset <- c(blue = "flights", green = "airports")

  expect_identical(
    dm_set_colors(
      dm_nycflights_small,
      !!!colset
    ) %>%
      dm_get_colors(),
    set_names(
      src_tbls(dm_nycflights_small),
      c("#0000FF", NA_character_, NA_character_, "#00FF00", NA_character_)
    )
  )
})

test_that("`dm_set_colors()` errors if old syntax used", {
  expect_dm_error(
    dm_set_colors(
      dm_nycflights_small,
      airports = ,
      airlines = "blue",
      flights = ,
      weather = "green"
    ),
    class = "wrong_syntax_set_cols"
  )
})

test_that("last", {
  expect_dm_error(
    color_quos_to_display(
      flights = "blue",
      airlines =
      ),
    class = "last_col_missing"
  )
})

test_that("bad color", {
  skip_if_not(getRversion() >= "3.5")

  expect_dm_error(
    dm_set_colors(
      dm_nycflights_small,
      "zzz-bogus" = flights
    ),
    class = "cols_not_avail"
  )
})

test_that("getter", {
  expect_equal(
    dm_get_colors(dm_nycflights13()),
    c(
      "#ED7D31" = "airlines",
      "#ED7D31" = "airports",
      "#5B9BD5" = "flights",
      "#ED7D31" = "planes",
      "#70AD47" = "weather"
    )
  )
})
