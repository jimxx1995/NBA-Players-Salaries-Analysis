#title: "performance.R"
#subtitle: "Stat 133, Fall 2016, Prof. Sanchez"
#author: "Cho Fung Chan"
#description: code from performance of players to value of a player
#imported function: Missed_FG_funct and Missed FT_funct

library(dplyr)
library(shiny)
setwd('C:/Users/Alvin/Desktop/project')
source('code/functions/MFG-MFT.R')
player_data <- read.csv('data/cleandata/roster-salary-stats.csv')

player_data$MFG <- Missed_FG_funct(player_data$FG,player_data$FGA)
player_data$MFT <- Missed_FT_funct(player_data$FT,player_data$FTA)

#subset by position
pos_C  <- subset(player_data,position == "C")
pos_PF <- subset(player_data,position == "PF")
pos_SF <- subset(player_data,position == "SF")
pos_SG <- subset(player_data,position == "SG")
pos_PG <- subset(player_data,position == "PG")

#Perform PCA on each set
#weights are in the first column of 'rotation' 
#TRB,AST,STL,BLK,TOV,PTS,MFG,MFT (column 12-16, 18, 20-21)
pca_C <- prcomp(pos_C[,c(12:16, 18, 20:21)], center=TRUE, .scaled=TRUE)
weights_C <- abs(pca_C$rotation[, 1])

pca_PF <- prcomp(pos_PF[,c(12:16, 18, 20:21)], center=TRUE, .scaled=TRUE)
weights_PF <- abs(pca_PF$rotation[, 1])

pca_SF <- prcomp(pos_SF[,c(12:16, 18, 20:21)], center=TRUE, .scaled=TRUE)
weights_SF <- abs(pca_SF$rotation[, 1])

pca_SG <- prcomp(pos_SG[,c(12:16, 18, 20:21)], center=TRUE, .scaled=TRUE)
weights_SG <- abs(pca_SG$rotation[, 1])

pca_PG <- prcomp(pos_PG[,c(12:16, 18, 20:21)], center=TRUE, .scaled=TRUE)
weights_PG <- abs(pca_PG$rotation[, 1])

EFF<-c()
for(i in 1:length(player_data$player)){
  if(player_data$position[i] == "C"){
    #for TOV,MFG and MFT, we use negative sign
    EFF[i] <- ((weights_C[1] * player_data$TRB[i] / sd(pos_C$TRB)) + 
              (weights_C[2] * player_data$AST[i] / sd(pos_C$AST)) +
              (weights_C[3] * player_data$STL[i] / sd(pos_C$STL)) + 
              (weights_C[4] * player_data$BLK[i] / sd(pos_C$BLK)) -
              (weights_C[5] * player_data$TOV[i] / sd(pos_C$TOV)) + 
              (weights_C[6] * player_data$PTS[i] / sd(pos_C$PTS)) -
              (weights_C[7] * player_data$MFG[i] / sd(pos_C$MFG)) - 
              (weights_C[8] * player_data$MFT[i] / sd(pos_C$MFT))) / player_data$G[i]
  }else if(player_data$position[i] == "PF"){
    EFF[i] <- ((weights_PF[1] * player_data$TRB[i] / sd(pos_PF$TRB)) + 
              (weights_PF[2] * player_data$AST[i] / sd(pos_PF$AST)) +
              (weights_PF[3] * player_data$STL[i] / sd(pos_PF$STL)) + 
              (weights_PF[4] * player_data$BLK[i] / sd(pos_PF$BLK)) -
              (weights_PF[5] * player_data$TOV[i] / sd(pos_PF$TOV)) + 
              (weights_PF[6] * player_data$PTS[i] / sd(pos_PF$PTS)) -
              (weights_PF[7] * player_data$MFG[i] / sd(pos_PF$MFG)) - 
              (weights_PF[8] * player_data$MFT[i] / sd(pos_PF$MFT))) / player_data$G[i]
  }else if(player_data$position[i] == "SF"){
    EFF[i] <- ((weights_SF[1] * player_data$TRB[i] / sd(pos_SF$TRB)) + 
              (weights_SF[2] * player_data$AST[i] / sd(pos_SF$AST)) +
              (weights_SF[3] * player_data$STL[i] / sd(pos_SF$STL)) +
              (weights_SF[4] * player_data$BLK[i] / sd(pos_SF$BLK)) -
              (weights_SF[5] * player_data$TOV[i] / sd(pos_SF$TOV)) +
              (weights_SF[6] * player_data$PTS[i] / sd(pos_SF$PTS)) -
              (weights_SF[7] * player_data$MFG[i] / sd(pos_SF$MFG)) -
              (weights_SF[8] * player_data$MFT[i] / sd(pos_SF$MFT))) / player_data$G[i]
  }else if(player_data$position[i] == "SG"){
    EFF[i] <- ((weights_SG[1] * player_data$TRB[i] / sd(pos_SG$TRB)) +
              (weights_SG[2] * player_data$AST[i] / sd(pos_SG$AST)) +
              (weights_SG[3] * player_data$STL[i] / sd(pos_SG$STL)) +
              (weights_SG[4] * player_data$BLK[i] / sd(pos_SG$BLK)) -
              (weights_SG[5] * player_data$TOV[i] / sd(pos_SG$TOV)) +
              (weights_SG[6] * player_data$PTS[i] / sd(pos_SG$PTS)) -
              (weights_SG[7] * player_data$MFG[i] / sd(pos_SG$MFG)) -
              (weights_SG[8] * player_data$MFT[i] / sd(pos_SG$MFT))) / player_data$G[i]
  }else{
    EFF[i]<-((weights_PG[1] * player_data$TRB[i] / sd(pos_PG$TRB)) +
            (weights_PG[2] * player_data$AST[i] / sd(pos_PG$AST)) +
            (weights_PG[3] * player_data$STL[i] / sd(pos_PG$STL)) + 
            (weights_PG[4] * player_data$BLK[i] / sd(pos_PG$BLK)) -
            (weights_PG[5] * player_data$TOV[i] / sd(pos_PG$TOV)) + 
            (weights_PG[6] * player_data$PTS[i] / sd(pos_PG$PTS)) -
            (weights_PG[7] * player_data$MFG[i] / sd(pos_PG$MFG)) - 
            (weights_PG[8] * player_data$MFT[i] / sd(pos_PG$MFT))) / player_data$G[i]
  }
}

#create a data frame with the required columns  
player_data_ver2 <- data.frame(player = player_data$player, PTS = player_data$PTS, TRB = player_data$TRB, 
                             AST = player_data$AST, STL = player_data$STL, BLK = player_data$BLK, 
                             MFG = player_data$MFG, MFT = player_data$MFT, TOV = player_data$TOV, 
                             G = player_data$G , EFF, salaries = player_data$salaries, position = player_data$position)
write.csv(player_data_ver2,'data/cleandata/eff-salary-stats.csv',row.names = FALSE)

player_data_ver3 <- player_data_ver2
player_data_ver3$value <- EFF / player_data_ver3$salaries
#rank players according to their value
player_data_ver3 <- player_data_ver3 %>% select(player, value) %>% arrange(desc(value))
write.table(rbind(head(player_data_ver3, 20), tail(player_data_ver3, 20)), 'data/cleandata/best-worst-value-players.txt', sep=", ")
  
