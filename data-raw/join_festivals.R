## code to prepare `join_festivals` dataset goes here

library(data.table)
data("world.cities")
setDT(world.cities)

world.cities <- rbindlist(list(world.cities, 
  data.table(name = "Munchen", country.etc = "Germany", pop = 1500000, lat = 48.1, long = 11.56, capital = 0),
  data.table(name = "Zernez", country.etc = "Switzerland", pop = 1527, lat = 46.7, long = 10.1, capital = 0),
  data.table(name = "Lubz", country.etc = "Germany", pop = 6342, lat = 53.46, long = 12.028, capital = 0)))

festivals <- fread("data-raw/festivals.csv")

festivals[, place := gsub("ü", "u", place, fixed = TRUE)]
festivals[, place := gsub("ö", "o", place, fixed = TRUE)]
festivals[, web := paste0("<a href='", web,"'>", web, "</a>'")]

join_festivals <- merge(festivals, world.cities, by.x="place", by.y="name", all.x = TRUE)

usethis::use_data(join_festivals, overwrite = TRUE)
