# install.packages("reshape2")
# install.packages("compare")
# library(reshape2)
# library(compare)
## https://www.r-bloggers.com/reshape-and-aggregate-data-with-the-r-package-reshape2/
## http://seananderson.ca/2013/10/19/reshape.html
#mx_dtt = read.csv(file1, header = TRUE)
demo1209DTT_lay_can_useV1 <- function(file1){
## e.g. demo1209DTT_lay_can_useV1("28LPSe_Rev1.0_1.0_DTTn2.csv")

mx_dtt = read.csv(file1, header = TRUE)
# unpivot by library(reshape2)
mx_dtt2 <- melt(mx_dtt, id = c("Device", "SPICE"), na.rm = TRUE)
write.csv(x = mx_dtt2, file = "o1208_mx_dtt2.csv")
## http://stackoverflow.com/questions/13967063/remove-duplicate-rows-in-r
## http://stackoverflow.com/questions/8661514/concatenating-n-columns-of-text-in-r
## de-couple = unique; paste = merge columns
mx_dtt2_coldev2spi <- unique( paste(mx_dtt2$Device, mx_dtt2$SPICE, sep = " | ") ) 
write.csv(x = mx_dtt2_coldev2spi, file = "o1208_mx_dtt2_coldev2spi.csv")
## TT rows
mx_dtt2_coldev <- unique(mx_dtt2$Device) # 124ea
mx_dtt2_coldev <- gsub("\\/"," ", mx_dtt2_coldev) # / cant be filename
write.csv(x = mx_dtt2_coldev, file = "o1208_mx_dtt2_coldev.csv")
  
mx_dtt2_colspi <- unique(mx_dtt2$SPICE)
write.csv(x = mx_dtt2_colspi, file = "o1208_mx_dtt2_colspi.csv")
## TT columns
mx_dtt2_colvar <- unique(mx_dtt2$variable) # 49ea, 123x49=6076
write.csv(x = mx_dtt2_colvar, file = "o1208_mx_dtt2_colvar.csv")
## pivot back
mx_dtt3 <- dcast(mx_dtt2, Device + SPICE ~ variable)
write.csv(x = mx_dtt3, file = "o1208_mx_dtt3.csv")
##
#for(i in 1:2){ # rows 55ea
for( i in 1:length(mx_dtt2_coldev) ){ # rows 55ea
mx_dtt2_val1 <- mx_dtt2[mx_dtt2$value == "1",]
mx_dtt2_val2 <- mx_dtt2_val1[mx_dtt2_val1$Device == mx_dtt2_coldev[i],]
## use data.frame will be easy to cbind
df1 <- data.frame(mx_dtt2_val2$Device[1])
df2 <- data.frame(mx_dtt2_val2$SPICE[1])
df3 <- t(data.frame(mx_dtt2_val2$variable))
write.csv(x = cbind(df1, df2, df3), file = paste("can_use","28LPSe_Rev1.0_1.0_DTTn2.csv", mx_dtt2_coldev[i], ".csv", sep = "") )
}
return( cbind(df1, df2, df3) )
}
##