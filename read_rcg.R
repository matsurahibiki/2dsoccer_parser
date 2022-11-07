tag <- c("x","y","vx","vy")

read_rcg_ball <- function(path){
    ball_log <- path |>
    readr::read_lines() |>
    tibble::as_tibble() |>
    dplyr::mutate(
        step = value |> stringr::str_extract("\\(show ([0-9]*)*")
                    |> stringr::str_remove("\\(show "),
        ball = value |> stringr::str_extract("\\(\\(b\\)( [0-9\\-\\.]*)*\\)")
            |> stringr::str_remove("\\(\\(b\\) ")
            |> stringr::str_remove("\\)"),
        x = ball |> stringr::str_extract("[0-9\\-\\.]+"),
        y = ball |> stringr::str_remove(x)
            |> stringr::str_extract("[0-9\\-\\.]+"),
        vx = ball  |> stringr::str_remove(x)
            |> stringr::str_remove(y)
            |> stringr::str_extract("[0-9\\-\\.]+"),
        vy = ball  |> stringr::str_remove(x)
            |> stringr::str_remove(y)
            |> stringr::str_remove(vx)
            |> stringr::str_extract("[0-9\\-\\.]+"),
    )|>
    dplyr::select(
        step,
        # ball,
        x,
        y,
        vx,
        vy,
    ) %>% tidyr::drop_na()
    return(ball_log)
}

read_rcg_player <- function(path){
    player_log <- path |>
    readr::read_lines() |>
    tibble::as_tibble() |>
    dplyr::mutate(
        step = value |> stringr::str_extract("\\(show ([0-9]*)*")
                    |> stringr::str_remove("\\(show "),
        players = value |> stringr::str_extract_all("\\(\\([lr] [0-9]*\\) [0-9]* [0-9x]* ([0-9\\-\\.]* )*\\(v h [0-9\\-\\.]*\\) \\(s( [0-9\\-\\.]*)*\\)( \\(f [rl] [0-9\\-\\.]*\\))* \\(c( [0-9\\-\\.]*)*\\)\\)")
    ) |>
    tidyr::unnest(players) |>
    dplyr::mutate(
        player = players |> stringr::str_extract("\\([rl] [0-9]+\\)"),
        team = player |> stringr::str_extract("[rl]"),
        unum = player |> stringr::str_extract("[0-9]+"),
        params = players |> stringr::str_remove("\\([rl] [0-9]+\\)"),

        type = params|> stringr::str_extract("[0-9\\-\\.x]+"),
        l1 = params |> stringr::str_remove(type),

        state = l1 |> stringr::str_extract("[0-9\\-\\.x]+"),
        l2 = l1 |> stringr::str_remove(state),

        x = l2 |> stringr::str_extract("[0-9\\-\\.]+"),
        l3 = l2 |> stringr::str_remove(x),

        y = l3 |> stringr::str_extract("[0-9\\-\\.]+"),
        l4 = l3 |> stringr::str_remove(y),

        vx = l4 |> stringr::str_extract("[0-9\\-\\.]+"),
        l5 = l4 |> stringr::str_remove(vx),

        vy = l5 |> stringr::str_extract("[0-9\\-\\.]+"),
        l6 = l5 |> stringr::str_remove(vy),

        body = l6 |> stringr::str_extract("[0-9\\-\\.]+"),
        l7 = l6 |> stringr::str_remove(body),

        neck = l7 |> stringr::str_extract("[0-9\\-\\.]+"),
        l8 = l7 |> stringr::str_remove(neck),
    ) |>
    dplyr::select(
        step,
        # players,
        # player,
        team,
        unum,
        # params,
        #type,
        #state,
        x,
        y,
        vx,
        vy,
        body,
        neck,
    )  %>% tidyr::drop_na()
    return(player_log)
}


