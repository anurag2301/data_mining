stg_bin = read.csv("strange_binary_with_added_feature.csv")

library(rpart)
dt = rpart(c~.,stg_bin,method="class",maxdepth=3)
plot(dt)
text(dt)
printcp(dt)

prd = predict(dt, stg_bin)
c = ifelse(stg_bin$c == 'good' , 0 , 1)

prd = as.data.frame(prd[,1])
sum(round(prd, digits = 0) == c)