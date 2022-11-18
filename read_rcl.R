library(tidyverse)

"+" <- function(e1, e2) {
    if (is.character(c(e1, e2))) {
        paste(e1, e2, sep = "")
    } else {
        base::"+"(e1, e2)
    }
}

read_rcl <- function(path) {
  rcl <- path |>
  readr::read_lines() |>
  tibble::as_tibble() |>
  dplyr::mutate(
    step     = value |> stringr::str_extract("\\d+"),
    agent    = value |> stringr::str_extract("\\w+_([0-9]{1,2}|Coach)"),
    team     = agent |> stringr::str_remove("_([0-9]{1,2}|Coach)"),
    unum     = agent |> stringr::str_extract("([0-9]{1,2}|Coach)$"),
    commands = value |>
      stringr::str_extract("\\(.+\\)$") |>
      purrr::map(~ .x |>
                   stringr::str_split("\\(|\\)", simplify = TRUE) |>
                   stringr::str_trim() |>
                   purrr::discard(~ .x == "")),
  ) |>
  tidyr::unnest(commands) |>
  dplyr::mutate(
    commands = commands |> stringr::str_split("\\ ", n = 2),
    command  = commands |> purrr::map_chr(1),
    args     = commands |> purrr::map(~ .x[-1]),
  ) |>
  dplyr::select(
    step,
    team,
    unum,
    command,
#    args,
    line = value,
  )
  
  return(rcl)
}

path <- "rclファイルがあるディレクトリのパス"
file <- "rclファイル名（拡張子なし）"
filename <- file + ".rcl"
filepath <- path + filename

rcl <- read_rcl(filepath)
head(rcl)
#csvファイルに出力
write.csv(rcl, file + "_rcl.csv",row.names = FALSE)