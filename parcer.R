library(tidyverse)

source("/Users/k20108kk/class/趣味/研究室/2Dサッカー/parser/read_rcg.R")
path <- "/Users/k20108kk/class/趣味/研究室/2Dサッカー/20210626170407-FRA-UNIted_2-vs-MT2021_0.rcg"
rcg_player <- read_rcg_player(path)
rcg_ball <- read_rcg_ball(path)

head(rcg_player)
head(rcg_ball)

#データをcsvに出力
write.csv(rcg_player, "player.csv",row.names = FALSE)
write.csv(rcg_ball, "ball.csv",row.names = FALSE)

