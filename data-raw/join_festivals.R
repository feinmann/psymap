## code to prepare `join_festivals` dataset goes here

library(data.table)
data("world.cities")
setDT(world.cities)

world.cities <- rbindlist(list(world.cities, 
  data.table(name = "Munchen", country.etc = "Germany", pop = 1500000, lat = 48.1, long = 11.56, capital = 0),
  data.table(name = "Zernez", country.etc = "Switzerland", pop = 1527, lat = 46.7, long = 10.1, capital = 0),
  data.table(name = "Lubz", country.etc = "Germany", pop = 6342, lat = 53.46, long = 12.028, capital = 0),
  data.table(name = "Solden", country.etc = "Germany", pop = 3145, lat = 46.966667, long = 11, capital = 0),
  data.table(name = "Ozora", country.etc = "Germany", pop = 1666, lat = 46.7529, long = 18.3985, capital = 0),
  data.table(name = "BA Almere", country.etc = "Netherlands", pop = 207904, lat = 52.3667, long = 5.2167, capital = 0),
  data.table(name = "Brussow", country.etc = "Germany", pop = 1831, lat = 53.4, long = 14.133333, capital = 0),
  data.table(name = "Gerstungen", country.etc = "Germany", pop = 9165, lat = 50.9625, long = 10.059722, capital = 0),
  data.table(name = "Gohlen", country.etc = "Germany", pop = 582, lat = 53.283333, long = 11.366667,capital = 0),
  data.table(name = "Grafenhainichen", country.etc = "Germany", pop = 11654, lat = 51.716667, long = 12.433333, capital = 0),
  data.table(name = "Hohenpeißenberg", country.etc = "Germany", pop = 3855, lat = 47.8, long = 11, capital = 0),
  data.table(name = "Hunxe", country.etc = "Germany", pop = 13567, lat = 51.641667, long = 6.767222, capital = 0),
  data.table(name = "Ilshofen", country.etc = "Germany", pop = 6584, lat = 49.170278, long = 9.920278, capital = 0),
  data.table(name = "Landau in der Pfalz", country.etc = "Germany", pop = 46677, lat = 49.2, long = 8.116667, capital = 0),
  data.table(name = "NB Spaarnwoude", country.etc = "Netherlands", pop = 200, lat = 52.382778, long = 4.671111, capital = 0),
  data.table(name = "Neustadt-Glewe", country.etc = "Germany", pop = 7009, lat = 53.366667, long = 11.583333, capital = 0),
  data.table(name = "Niedergorsdorf", country.etc = "Germany", pop = 6200, lat = 51.983333, long = 13, capital = 0),
  data.table(name = "Quasslin", country.etc = "Germany", pop = 507, lat = 53.384972, long = 12.11225, capital = 0),
  data.table(name = "Ramstein", country.etc = "Germany", pop = 7876, lat = 49.446111, long = 7.554722, capital = 0),
  data.table(name = "Speichersdorf", country.etc = "Germany", pop = 5769, lat = 49.876389, long = 11.783889, capital = 0),
  data.table(name = "Weeze", country.etc = "Germany", pop = 10697, lat = 51.626667, long = 6.196667, capital = 0)
  ))

festivals <- fread("data-raw/festivals.csv", fill = TRUE)

festivals[, place := gsub("ü", "u", place, fixed = TRUE)]
festivals[, place := gsub("ö", "o", place, fixed = TRUE)]
festivals[, place := gsub("ä", "a", place, fixed = TRUE)]
festivals[, web := paste0("<a href='", web,"'>", web, "</a>'")]

join_festivals <- merge(festivals, world.cities, by.x="place", by.y="name", all.x = TRUE)

join_festivals[is.na(info)]$info <- ""

usethis::use_data(join_festivals, overwrite = TRUE)
