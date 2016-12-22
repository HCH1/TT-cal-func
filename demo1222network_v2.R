# install.packages("reshape2")
# library(reshape2)
## http://stackoverflow.com/questions/13281303/creating-co-occurrence-matrix
mx_dptt = read.csv("28LPSe_Rev1.0_1.0_Truth_Tables_DPTTn2v2 - Copy (2).csv", header = TRUE)
# make sure the boolean value is 1 or 0 will be better.
mx_dptt2 <- mx_dptt
# unpivot by library(reshape2) -> 1d db
mx_dptt2 <- melt(mx_dptt2, id = "Device", na.rm = TRUE)
write.csv(x = mx_dptt2, file = "o1222_mx_dptt2.csv")
# mx_dptt["x"] <- 0.01
# gsub("x","0.01", mx_dptt)
# mx_dptt3 <- dcast(mx_dptt2, Device ~ variable)
# write.csv(x = mx_dptt3, file = "o1222_mx_dptt3.csv")
mx_dptt4 <- as.matrix(mx_dptt[,-1]) # set colname as a matrix type
# head(mx_dptt4)
mx_dptt4_adja <- mx_dptt4 %*% t(mx_dptt4) #the magic matrix 
diag(mx_dptt4_adja) <- 0 #repalce diagonal
dimnames(mx_dptt4_adja) <- list(mx_dptt[,1], mx_dptt[,1]) #name the dimensions
write.csv(x = mx_dptt4_adja, file = "o1222_mx_dptt4_adja.csv")
## 
# install.packages("igraph")
# library(igraph)
#g <- graph.adjacency(mx_dptt4_adja, weighted=TRUE, mode ='undirected')
#g <- simplify(g)
# set labels and degrees of vertices
#mx_dptt4_adja(g)$label <- mx_dptt4_adja(g)$name
#mx_dptt4_adja(g)$degree <- degree(g)
#plot(g)
##
