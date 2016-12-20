# install.packages("reshape2")
# install.packages("compare")
# library(reshape2)
# library(compare)
## https://www.r-bloggers.com/reshape-and-aggregate-data-with-the-r-package-reshape2/
## http://seananderson.ca/2013/10/19/reshape.html
#mx_dtt = read.csv(file1, header = TRUE)
##
demo1220DPTT_v1 <- function(file1){
## e.g. demo1220DPTT_v1("28LPSe_Rev1.0_1.0_Truth_Tables_DPTTn2v2.csv")
## mx_dptt = read.csv(file1, header = TRUE)
mx_dptt = read.csv(file1, header = TRUE)
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
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "NW|0",] # CN -> 1 is open.
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "X3BF|1",] # CP -> 0 is open.
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "X4IN|1",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "X3NV|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "N3|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "IP|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "PV|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "HG|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "ZG|1",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "ZP|1",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "HG|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "ZN|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "HN|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "HP|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "BH|1",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "PH|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "XW|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "LW|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "X9BH|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "X9PH|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "X4BH|1",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "X4PH|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "GN|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "GP|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "XH|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "BH|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "BN|0",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "OP|1",]
	mx_dptt2_fil <- mx_dptt2_fil[ paste( mx_dptt2_fil[[2]], mx_dptt2_fil[[3]], sep = "|") != "TJ|0",]

	write.csv(x = mx_dptt2_fil, file = "o1220_mx_dptt2_fil.csv")
##
mx_dptt2_fil2 <- mx_dptt2_fil

  for( i in 1:length(mx_dptt2_coldev) ){
# length(mx_dptt2_coldev) 140ea
    mx_dptt2_fil3 <- mx_dptt2_fil2[mx_dptt2_fil2[[1]] == mx_dptt2_coldev[i],]
    ## use data.frame will be easy to cbind
    df1 <- data.frame(mx_dptt2_fil3$Device[1])
    df3 <- t(data.frame(mx_dptt2_fil3[[2]]))
    ## / cant be filename. use gsub(x) to replace
    write.csv(x = cbind(df1, df3), file = paste("DPTT_", file1, "_", gsub("\\/",";", mx_dptt2_coldev[i]), ".csv", sep = "") )
  }
  return("done!")
}
##
