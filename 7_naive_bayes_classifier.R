naivebayesbinary = read.csv("naive_bayes_binary.csv", sep=",", header=TRUE)
probs = matrix(0.0, nrow = 20, ncol = 3)
rows = 20
cols = 3
train = naivebayesbinary[1:2500,]
test = naivebayesbinary[2501:5000,]
class1 = data.matrix(train[train$V11==1,])
class2 = data.matrix(train[train$V11==2,])
class3 = data.matrix(train[train$V11==3,])

pclass1 = nrow(class1)/nrow(train)
pclass2 = nrow(class2)/nrow(train)
pclass3 = nrow(class3)/nrow(train)

k = 1
for(i in seq(1,rows,2)){
    probs[i,1] = sum(class1[,k]==0)/(sum(class1[,k]==1) + sum(class1[,k]==0))
    probs[i+1,1] = sum(class1[,k]==1)/(sum(class1[,k]==1) + sum(class1[,k]==0))
    probs[i,2] = sum(class2[,k]==0)/(sum(class2[,k]==1) + sum(class2[,k]==0))
    probs[i+1,2] = sum(class2[,k]==1)/(sum(class2[,k]==1) + sum(class2[,k]==0))
    probs[i,3] = sum(class3[,k]==0)/(sum(class3[,k]==1) + sum(class3[,k]==0))
    probs[i+1,3] = sum(class3[,k]==1)/(sum(class3[,k]==1) + sum(class3[,k]==0))
    k = k + 1
}

result = rep(0, 2500)
cm =  matrix(0, nrow = 3, ncol = 3)
for(i in 1:nrow(test)) {
  probclass1 = pclass1
  probclass2 = pclass2
  probclass3 = pclass3
  for(j in 1:(ncol(test)-1)) {
    if(test[i,j]==0) {
      probclass1 = probclass1*probs[(j-1)*2+1,1]
      probclass2 = probclass2*probs[(j-1)*2+1,2]
      probclass3 = probclass3*probs[(j-1)*2+1,3]
    } 
    else {
      probclass1 = probclass1*probs[(j-1)*2+2,1]
      probclass2 = probclass2*probs[(j-1)*2+2,2]
      probclass3 = probclass3*probs[(j-1)*2+2,3]
    }
  }
  
  if(probclass1 > probclass2) {
    if(probclass1 > probclass3) {
      result[i] = 1
    }
    else {
      result[i] = 3
    }
  }
  else {
    if(probclass2 > probclass3) {
      result[i] = 2
    }
    else {
      result[i] = 3
    }
  }
  cm[test[i,11], result[i]] = cm[test[i,11], result[i]] + 1
}
print(cm)