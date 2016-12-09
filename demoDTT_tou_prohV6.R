# install.packages("reshape2")
# install.packages("compare")
# library(reshape2)
# library(compare)
## https://www.r-bloggers.com/reshape-and-aggregate-data-with-the-r-package-reshape2/
## http://seananderson.ca/2013/10/19/reshape.html
demoFunc_TT_tou_proh <- function(file1){
## e.g. demoFunc_TT_tou_proh("28SLP_Rev1.1_4.0_Truth Table_DTTv1.csv","VNCAPHV")
## e.g. demoFunc_TT_tou_proh("28LPSe_Rev1.0_1.0_DTTn2.csv")

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
for(j in 1:length(mx_dtt2_colvar)){
## if target val=1 -> find unique devices val=0
mx_dtt2_fil1 <- mx_dtt2[mx_dtt2$variable == mx_dtt2_colvar[j],] ## e.g. demoFunc_TT_tou_proh("VNCAPHV")
mx_dtt2_fil1 <- mx_dtt2_fil1[mx_dtt2_fil1$value != "0",]
#write.csv(x = mx_dtt2_fil1, file = "o1208_mx_dtt2_fil1.csv")
mx_dtt2_fil2 <- unique(mx_dtt2_fil1$Device) # 36ea
#write.csv(x = mx_dtt2_fil2, file = "o1208_mx_dtt2_fil2.csv") 
## 124 filter != 36 -> 88
mx_dtt2_fil_oppo <- mx_dtt2

for(i in 1:length(mx_dtt2_fil2)) {
mx_dtt2_fil_oppo <- mx_dtt2_fil_oppo[mx_dtt2_fil_oppo$Device != mx_dtt2_fil2[i],]
}
#write.csv(x = mx_dtt2_fil_oppo, file = "o1208_mx_dtt2_fil_oppo.csv")
## 124 filter != 36 -> 88, then re-do 124 filter != 88 -> 36
mx_dtt2_fil_oppo2 <- mx_dtt2

for(i in 1:length(unique(mx_dtt2_fil_oppo$Device))) {
mx_dtt2_fil_oppo2 <- mx_dtt2_fil_oppo2[mx_dtt2_fil_oppo2$Device != mx_dtt2_fil_oppo$Device[i],]
}
#write.csv(x = mx_dtt2_fil_oppo2, file = "o1208_mx_dtt2_fil_oppo2.csv")
## filter 0
mx_dtt2_fil_oppo2_val0 <- mx_dtt2_fil_oppo2[mx_dtt2_fil_oppo2$value == "0",]
#write.csv(x = mx_dtt2_fil_oppo2_val0, file = "mx_dtt2_fil_oppo2_val0.csv")
# write.table(x = mx_dtt2_fil_oppo2_val0$variable, file = "o1208_mx_dtt2_fil_oppo2_val0_var.txt")
## WC
# install.packages("plyr")
# library(plyr)
mx_dtt2_fil_oppo2_val0_cou <- count(mx_dtt2_fil_oppo2_val0$variable)
mx_dtt2_fil_oppo2_val0_cou <- mx_dtt2_fil_oppo2_val0_cou[mx_dtt2_fil_oppo2_val0_cou$freq == length(mx_dtt2_fil2),]
write.csv(x = mx_dtt2_fil_oppo2_val0_cou, file = paste("tou_proh",file1, mx_dtt2_colvar[j], ".csv", sep = "") )
##
}
return(mx_dtt2_fil_oppo2_val0_cou)
##
}