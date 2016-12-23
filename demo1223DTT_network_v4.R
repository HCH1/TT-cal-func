# install.packages("reshape2")
# library(reshape2)
## http://stackoverflow.com/questions/13281303/creating-co-occurrence-matrix
#opt1_DTT 
mx_dtt = read.csv("28LPSe_Rev1.0_1.0_Truth_Tables_DTTn2v3.csv", header = TRUE)
#opt2_DPTT mx_dtt = read.csv("28LPSe_Rev1.0_1.0_Truth_Tables_DPTTn2v2.csv", header = TRUE)
mx_dtt2 <- mx_dtt
#opt1_DTT 
mx_dtt2 <- melt(mx_dtt2, id = c("Device", "SPICE"), na.rm = TRUE) # unpivot
#opt2_DPTT mx_dtt2 <- melt(mx_dtt2, id = "Device", na.rm = TRUE) # unpivot
## http://stackoverflow.com/questions/5612821/replace-specific-column-words-into-number-or-blank
mx_dtt2[mx_dtt2$value == "x",]$value = 1.1 # Replace specific column “word”.
write.csv(x = mx_dtt2, file = "o1223_mx_dtt2.csv")
##
#mx_dtt3 <- dcast(mx_dtt2, Device + SPICE ~ variable), will same as mx_dtt
mx_dtt3 <- dcast(mx_dtt2, Device ~ variable) # re-updated boolean matrix
# summary(mx_dtt3)-> tpye is char, not numb
write.csv(x = mx_dtt3, file = "o1223_mx_dtt3.csv")
##
mx_dtt3r = read.csv("o1223_mx_dtt3.csv", header = TRUE) # value will be numb
mx_dtt4 <- as.matrix(mx_dtt3r[,-c(1:2)]) # set colname as a matrix type
mx_dtt4_adja <- mx_dtt4 %*% t(mx_dtt4) #the magic matrix 
diag(mx_dtt4_adja) <- 0 #repalce diagonal
dimnames(mx_dtt4_adja) <- list(mx_dtt[,1], mx_dtt[,1]) #name the dimensions
write.csv(x = mx_dtt4_adja, file = "o1223_mx_dtt4_adja.csv")
##
#install.packages("igraph")
#library(igraph)
g <- graph.adjacency(mx_dtt4_adja, weighted=TRUE, mode ='undirected')
g <- simplify(g)
plot(g)
# set labels and degrees of vertices
#mx_dtt4_adja(g)$label <- mx_dtt4_adja(g)$name
#mx_dtt4_adja(g)$degree <- degree(g)
##
####
#df <- as.data.frame(mx_dtt2_rem2)
#df[df=="x"] <- NA
#df[is.na(df)] <- 2
#write.csv(x = df, file = "o1223_df.csv")
# unpivot by library(reshape2) -> 1d db
#mx_dtt2 <- data.frame(mx_dtt2)
#mx_dtt2[mx_dtt2$value=="x"] <- 2
#write.csv(x = mx_dtt2, file = "o1223_mx_dtt2v2.csv")
#mx_dtt2[ mx_dtt2 == x ] <- 0.5
#write.csv(x = mx_dtt2_rem2, file = "o1223_mx_dtt2_rem2.csv")
# mx_dtt["x"] <- 0.01
# gsub("x","0.01", mx_dtt)
####