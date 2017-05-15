library("mlbench")
data("Ionosphere")
INS = Ionosphere

good = INS[INS$Class=="good",]
bad = INS[INS$Class=="bad",]

grows = nrow(good)
brows = nrow(bad)

good = scale(good[,3:34])
bad = scale(bad[,3:34])

cov_good = t(good) %*% good / (grows - 1)
cov_bad = t(bad) %*% bad / (brows - 1)

maha_good = rep(0,length = grows)
maha_bad = rep(0,length = brows)

for (i in 1:grows) {
  maha_good[i] = t(good[i,]) %*% solve(cov_good)  %*% good[i,];
}

for (i in 1:brows) {
  maha_bad[i] = t(bad[i,]) %*% solve(cov_bad)  %*% bad[i,];
}

plot(maha_good, pch="+", col=3, ylab = "Mahalanobis dist.");
points(maha_bad, pch="*", col=2);

confusion_matrix = matrix(0, nrow=2, ncol=2)
confusion_matrix[1,1] = length(maha_good[maha_good < 55])
confusion_matrix[1,2] = length(maha_good[maha_good >= 55])
confusion_matrix[2,1] = length(maha_bad[maha_bad <= 40])
confusion_matrix[2,2] = length(maha_bad[maha_bad > 40])

confusion_matrix