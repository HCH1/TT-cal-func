# install.packages("reshape2")
# install.packages("compare")
# library(reshape2)
# library(compare)
## https://www.r-bloggers.com/reshape-and-aggregate-data-with-the-r-package-reshape2/
## http://seananderson.ca/2013/10/19/reshape.html
#mx_dtt = read.csv(file1, header = TRUE)
##
#demo1220DPTT_v1 <- function(file1){
## e.g. demo1209DTT_lay_can_useV1("28LPSe_Rev1.0_1.0_Truth_Tables_DPTTn2v2.csv")
   
mx_dptt = read.csv("28LPSe_Rev1.0_1.0_Truth_Tables_DPTTn2v2.csv", header = TRUE)
# unpivot by library(reshape2)
mx_dptt2 <- melt(mx_dptt, id = "Device", na.rm = TRUE)
write.csv(x = mx_dptt2, file = "o1220_mx_dptt2.csv")
# length(mx_dptt2[[1]]) 3920ea
# mx_dptt2[ paste(mx_dptt2$variable, mx_dptt2$value, sep = " | ") ]
## de-couple = unique; paste = merge columns
# length(mx_dptt2_coldev) 140ea
mx_dptt2_coldev <- unique(mx_dptt2$Device) 
write.csv(x = mx_dptt2_coldev, file = "o1220_mx_dptt2_coldev.csv")
# length(mx_dptt2_colvar) 28ea
mx_dptt2_colvar <- unique(mx_dptt2$variable) 
write.csv(x = mx_dptt2_colvar, file = "o1220_mx_dptt2_colvar.csv")
# pivot
mx_dptt3 <- dcast(mx_dptt2, Device ~ variable)
write.csv(x = mx_dptt3, file = "o1220_mx_dptt3.csv")
##
#for(i in 1:2){ # rows 55ea
#for( i in 1:length(mx_dtt2_coldev) ){ # rows 55ea
## if want to filter multi cols -> use paste(a, b) =="?"
	mx_dptt2_fil <- mx_dptt2
	mx_dptt2_fil <- mx_dptt2_fil[ mx_dptt2_fil[[3]] != "x",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "NW|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "X3BF|1",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "X4IN|1",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "X3NV|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "N3|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "IP|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "PV|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "HG|0",]

	write.csv(x = mx_dptt2_fil, file = "o1220_mx_dptt2_fil.csv")
##
  
    mx_dtt2_val1 <- mx_dtt2[mx_dtt2$value == "1",]
    mx_dtt2_val2 <- mx_dtt2_val1[mx_dtt2_val1$Device == mx_dtt2_coldev[i],]
    ## use data.frame will be easy to cbind
    df1 <- data.frame(mx_dtt2_val2$Device[1])
    df2 <- data.frame(mx_dtt2_val2$SPICE[1])
    df3 <- t(data.frame(mx_dtt2_val2$variable))
    ## / cant be filename. use gsub(x) to replace
    write.csv(x = cbind(df1, df2, df3), file = paste("can_use", file1, "_", gsub("\\/",";", mx_dtt2_coldev[i]), ".csv", sep = "") )
#  }
#  return( cbind(df1, df2, df3) )
#}
##