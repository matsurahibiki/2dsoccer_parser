library(tidyverse)

source("read_rcg.Rファイルのパス")
path <- "rcgファイルのパス"
rcg_player <- read_rcg_player(path)
rcg_ball <- read_rcg_ball(path)

head(rcg_player)
head(rcg_ball)

#データをcsvに出力
write.csv(rcg_player, "player.csv",row.names = FALSE)
write.csv(rcg_ball, "ball.csv",row.names = FALSE)

