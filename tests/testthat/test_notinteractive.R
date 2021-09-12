library(ggplot2)
library(ggsource)

p = ggplot(mpg, aes(displ, hwy, colour = class)) +
  geom_point()

tmp_path = tempfile(fileext = ".pdf")
test_path = "test"

test_that("ggsource runs okay",{
  expect_error(ggsave(tmp_path, p, scriptname = test_path), NA)
  expect_true(file.exists(tmp_path))
  expect_equal(ggsource(tmp_path, interactive = F), test_path)
})
