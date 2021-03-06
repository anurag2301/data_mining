stud_mat = read.table("student-mat.csv", sep=";", header=TRUE)

# http://stackoverflow.com/questions/34617883/how-to-remove-multiple-columns-in-r-dataframe
stud_mat$G1 = NULL
stud_mat$G2 = NULL
#stud_mat$G3 = NULL

#stud_mat = data.frame(stud_mat, c)

# http://stackoverflow.com/questions/31153186/r-split-data-into-2-parts-randomly
# http://stackoverflow.com/questions/8810338/same-random-numbers-every-time
set.seed(15)  # seed is not mandatory but to get same results on each run I used it
train_or_test = sample(c(TRUE, FALSE),nrow(stud_mat), replace=TRUE, prob=c(0.75,0.25))
train_data = stud_mat[train_or_test,] 
test_data = stud_mat[!train_or_test,]

library(rpart)
dt = rpart(G3~.,method="anova", train_data)

# http://stackoverflow.com/questions/29572906/data-prediction-using-decision-tree-of-rpart
dt_pred = predict(dt, test_data, type="vector")
sum(round(dt_pred, digits = 0) != test_data[,31])
sum(round(dt_pred, digits = 0) == test_data[,31])
# plot(dt_prune, uniform=TRUE, main="Tree 2b")
# text(dt_prune, use.n=TRUE, all=TRUE, cex=.8)

dt_prune= prune(dt, cp = 0.040)
dt_pred = predict(dt_prune, test_data, type="vector")
sum(round(dt_pred, digits = 0) != test_data[,31])
sum(round(dt_pred, digits = 0) == test_data[,31])

# http://www.statmethods.net/advstats/cart.html
plot(dt_prune, uniform=TRUE, main="Tree 2b")
text(dt_prune, use.n=TRUE, all=TRUE, cex=.8)