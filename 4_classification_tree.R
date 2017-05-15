# discussed with Srijita Das regarding the logic and she said the logic looks good
n = 1000;
x = rep(0,n);
s = c(1,5,4,2,3);
k = length(s);
for (i in (k+1):n) {
  j = s[(i %% k) + 1]; # i %% k is i mod k
  x[i] = 1 - x[i-j];
}

dm = matrix(c(rep(0,n-6)), nrow = n-6, ncol=6, byrow = TRUE);

for (i in 6:n){
  dm[i - 6, 1] = x[i-5];
  dm[i - 6, 2] = x[i-4];
  dm[i - 6, 3] = x[i-3];
  dm[i - 6, 4] = x[i-2];
  dm[i - 6, 5] = x[i-1];
  dm[i - 6, 6] = x[i];
}

dm = data.frame(dm);
library(rpart)
dt = rpart(X6~ ., dm, method ='class');
plot(dt);
text(dt);

prd = predict(dt, dm);
prd = as.data.frame(prd[,1])

sum(round(prd, digits = 0) != dm[,6])
accuracy = sum(round(prd, digits = 0) != dm[,6])/nrow(dm)
print (accuracy)