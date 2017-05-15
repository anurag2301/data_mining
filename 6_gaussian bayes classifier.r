# example of a Gaussian classifer on the famous Iris data.  For each class we 
# compute the mean and covariance matrix, as well as the determinant
# of the covariace matrix (this appears in the denominator of
# the multivariate Gaussian density.  In implementing the
# Bayes classifier we take the three classes as having
# equal probability.  Thus we can ignore the "prior"
# contribution and classify according to the class
# that gives each data vector the greatest Gaussian
# probability density.  

data = read.csv("glass_identification.csv", sep=",", header=FALSE);  # include the famous iris data

data = data[data$V11<3 | data$V11>6,]

#xyz = .01*rnorm(1)
xyz = 0.001*rnorm(1)
for(i in 1:nrow(data)) {
  for(j in 1:(ncol(data)-1)) {
    data[i,j] = data[i,j]+xyz
  }
}

train_or_test = sample(0:1,nrow(data), replace=TRUE, prob=c(0.5,0.5))
train_data = data[train_or_test==0,]
#train_data = data
test_data = data[train_or_test==1,]

n = nrow(train_data);
type = rep(0,n);

type = rep(0,nrow(train_data))
type[train_data$V11 == 1] = 1
type[train_data$V11 == 2] = 2
type[train_data$V11 == 7] = 3

# there may be a slicker way to do the following calculations
# but this is straightforward

X1 = train_data[type==1,2:10];
X2 = train_data[type==2,2:10];
X3 = train_data[type==3,2:10];

p1 = nrow(X1)/n
p2 = nrow(X2)/n
p3 = nrow(X3)/n

m1 = colMeans(X1);
m2 = colMeans(X2);
m3 = colMeans(X3);

#S1 = solve(cov(X1));		# inverse of class covariance for class 1
#S2 = solve(cov(X2));
#S3 = solve(cov(X3));

S1 = solve(cov(X1));		# inverse of class covariance for class 1
S2 = solve(cov(X2));
S3 = solve(cov(X3));


#det1 = 1/det(S1);
#det2 = 1/det(S2);
#det3 = 1/det(S3);

det1 = 1/det(S1);
det2 = 1/det(S2);
det3 = 1/det(S3);

d = rep(0,3);
c = rep(0,n)

for (i in 1:n) {
    x = train_data[i,2:10];
    d[1] = 0.5*(log(det1) + sum(((x-m1) * S1 %*% t(x-m1)))) - log(p1)
    d[2] = 0.5*(log(det2) + sum(((x-m2) * S2 %*% t(x-m2)))) - log(p2)
    d[3] = 0.5*(log(det3) + sum(((x-m3) * S3 %*% t(x-m3)))) - log(p3)
    c[i] = which.min(d);
    
}

error_rate_train = sum(c != type)/n

n = nrow(test_data);
type = rep(0,nrow(test_data))
type[test_data$V11 == 1] = 1
type[test_data$V11 == 2] = 2
type[test_data$V11 == 7] = 3

c = rep(0,n)

for (i in 1:n) {
  x = test_data[i,2:10];
  
  d[1] = log(det1) + sum(((x-m1) * S1 %*% t(x-m1))) - log(p1)
  d[2] = log(det2) + sum(((x-m2) * S2 %*% t(x-m2))) - log(p2)
  d[3] = log(det3) + sum(((x-m3) * S3 %*% t(x-m3))) - log(p3)
  c[i] = which.min(d);
  
}
error_rate_test = sum(c != type)/n

print(error_rate_train)
print(error_rate_test)