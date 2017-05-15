n = 1000;       # number of observations
data = matrix(rnorm(n, mean = 0, sd = 1), nrow = n, ncol=1);  #  the data matrix of predictors
class = rep(1, n)
x = runif(n)
for (i in 1:n) {  # generate the data
  y = 1
  if(abs(data[i]) > 1) {
    y = -1
  }
  if(x[i] <= 0.1) {
    y = y*-1
  }
  class[i] = y
}

loops = 100
ht = matrix(rnorm(loops, mean = 0, sd = 1), nrow = loops, ncol=1)
ht_type = rep(1,loops)

table = matrix(rep(1/n), nrow = n, ncol=1)
for (i in 1:loops) {
  correct_1 = data < ht[i]
  correct_2 = data > ht[i]
  count_1 = 0
  count_2 = 0
  for(j in 1:n) {
    if(correct_1[j] && class[j]==1) {
      count_1 = count_1 + 1
    }
    if((!correct_1[j]) && class[j]==-1) {
      count_1 = count_1 + 1
    }
    
    if(correct_2[j] && class[j]==1) {
      count_2 = count_2 + 1
    }
    if((!correct_2[j]) && class[j]==-1) {
      count_2 = count_2 + 1
    }
  }
  #error = (n-count_1)/n
  if(count_2 > count_1) {
    ht_type[i] = 2
    #error = (n-count_2)/n
  }
  new_class = rep(1,n)
  for(j in 1:n) {
    if(ht_type[i] == 1) {
      if(data[j] >= ht[i]) {
        new_class[j] = -1
      }
    }
    else {
      if(data[j] <= ht[i]) {
        new_class[j] = -1
      }
    }
  }
  table = cbind(table,new_class)
}
row_num = matrix(c(1:1000), nrow = n, ncol=1)
table = cbind(row_num, table)
table = cbind(table, class)
final_ht = matrix(rep(0,loops), nrow = loops, ncol=1)
final_ht_type = matrix(rep(0,loops), nrow = loops, ncol=1)
wt = rep(0, loops)
k = 1
while(ncol(table)>3) {
  errors = matrix(rep(1,ncol(table)-3), nrow = 1, ncol=ncol(table)-3)
  for(i in 3:ncol(table)-1) {
    incorrect_rows = table[(table[,i]!=table[,ncol(table)]),]
    errors[i-2] = sum(incorrect_rows[,2])
  }
  best = which.min(errors)
  final_ht[k] = ht[best]
  final_ht_type[k] = ht_type[best]
  alpha = 0.5*log((1-errors[best])/errors[best])
  wt[k] = alpha
  k = k + 1
  
  for(i in 1:n) {
    table[i,2] = table[i,2]*exp(-alpha*table[i,best+2]*table[i,ncol(table)])
  }
  table[,2] = table[,2]/sum(table[,2])
  table = table[,-(best+2)]
  ht = ht[-best]
  ht_type = ht_type[-best]
}

result = 0
predicted_class = rep(1,n)
for(i in 1:n) {
  sum = 0
  for(j in 1:loops) {
    p_class = 1
    if(final_ht_type[j] == 1) {
      if(data[i] >= final_ht[j]) {
        p_class = -1
      }
    }
    else {
      if(data[i] <= final_ht[j]) {
        p_class = -1
      }
    }
    sum = sum + wt[j]*p_class
  }
  p_class = sign(sum)
  predicted_class[i] = p_class
  if(class[i] == p_class) {
    result = result + 1
  }
}

print("Accuracy")
print(result/n)

plot(data,predicted_class)
stopp
x1 = seq(-2,2,by=.01)
x2 = rep(0, length(x1))
for(i in 1:length(x1)) {
  sum = 0
  for(j in 1:loops) {
    p_class = 1
    if(final_ht_type[j] == 1) {
      if(x1[i] >= final_ht[j]) {
        p_class = -1
      }
    }
    else {
      if(x1[i] <= final_ht[j]) {
        p_class = -1
      }
    }
    sum = sum + wt[j]*p_class
  }
  x2[i] = sign(sum)
}
plot(x1,x2, col = class)