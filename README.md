Problem Statements
1. Mahalanobis

The \mlbench" R package contains a number of datasets used for Machine Learning benchmarking. Install
this package with
> install.packages("mlbench")
When you want to access one of these datasets in your R source file, you need the command
> library("mlbench")
If you wanted to load, for instance, the \Ionosphere" datset, you would also need the command
> data("ionosphere")
as we have done before. You can see that the 35th attribute of this dataset gives a classification of "good" or
"bad," thus dividing the dataset into two classes. For each of these classes compute the empirical covariance
matrix, and use these to compute the Mahalanobis distance from each point to the two class means. A simple-
minded classifier might associate each point with the class having the smaller Mahalanobis distance. Classify
each point according to this rule, and tabulate the "confusion matrix." That is, create a 2x2 matrix where the
i; j entry is the number of examples from class i (good or bad), which were classified as type j (good or bad).

2. Decision Tree

Download the Student Performance Data Set at the UCI Machine Learning Repository,
https://archive.ics.uci.edu/ml/datasets/Student+Performance
We will use the math data.
(a) Create a class variable for each student by testing if the final score "G3" is greater than 10. Create a
decision tree predicting this class using all other variables (except "G1" and "G2" which are other scores,
thus strongly correlated with "G3"). Prune the tree to remove variables that do not show statistically
significant improvement. Submit a plot of your tree. What is the estimated generalization error? What
is the most important variable? How many splits does your tree use?
(b) You can also use rpart to predict the score of a continuous value. That is, we can treat the problem as
regression rather than classification. To do this with rpart just change the method to "anova" and use the
original "G3" variable. Plot the tree and answer the same questions as in the first part.

3. Decision Tree

Using the data in "strange binary.csv," build a classification tree that distinguishes the "good" examples from
the "bad" ones using no more than 3 splits.
(a) Report the classification error rate on this training set. Is it reasonable to assume that your classification
accuracy would be similar on test data from the same model?
(b) Introduce an additional feature that allows you to significantly decrease the error rate, still using only 3
splits. Report the training error rate for this new classifier. It should be possible to get about 80% correct
on the training.


4. Classification Tree

Consider the following code fragment which produces a sequence of numbers:
1
> n = 1000;
> x = rep(0,n);
> s = c(1,5,4,2,3);
> k = length(s);
> for (i in (k+1):n) {
> j = s[(i %% k) + 1]; # i %% k is i mod k
> x[i] = 1 - x[i-j];
> }
Create a classification tree that predicts xi as a function of the past m values, xi,....., xi-m+1, giving nearly
perfect predictions on these data. What is the minimal value for m and the minimal depth of the tree needed
to get nearly perfect accuracy?

5. Conditional Probability

Consider the state graph in 5_state_graph.jpg that describes the following random sequence of states. We begin in A. If
a state has a single successor we move to that successor deterministically. If there are several successors we
choose randomly among these with equal probability for all possible choices. We will generate N random states
in this manner, which we will call X1,...,XN.

Suppose we know that x10 = A. Write a program to compute p(x10 = A|xn) for n = 9,8,....,1.

6. Gaussian Bayes Classifier

Download the Glass dataset from the UCI machine learning repository:
https://archive.ics.uci.edu/ml/datasets/Glass+Identification
With these data we wish to classify the type of glass among the 7 possible types given. To do this divide the
data set randomly into a training and test set.
(a) Using the training data build a Bayes classifier where you model the class-conditional distributions as
multivariate Gaussian on the 9 predictive variables.
(b) Test the classifier on the test set and compute the error rate.
(c) Test the classifier on the training set as well and compute the error rate.

7. Naivee Bayes Classifier

Download the "naive bayes binary.csv" data from the course web site. These data are for a 3-class classification
problem with 10 binary variables. The true class is the 11th column of the data file.
(a) Using the first half of the data set, train a naive Bayes classifier.
(b) Using the 2nd half of the data set, classify each vector and construct the confusion matrix.

8. Adaboost

Suppose we have a binary classification problem where the data (x1, y1) ..., (xn, yn) have xiblongs to real number, yi is +1 or -1
with n = 1000. More specifically the {xi} are independent with xi ~ N(0, 1) with the {yi} generated as
P(yi = +1| |xi| < 1) = 0.9
P(yi = -1| |xi| > 1) = 0.9
(a) Implement the AdaBoost algorithm where your \weak" learners classify by simply thresholding x. That
is
ht(x) = +1 x < ct
	    -1 x > ct
or
ht(x) = +1 x > ct
		-1 x < ct
At each iteration t, you should choose the weak learner that gives optimal performance given the current
distribution on your samples.
(b) After 100 iterations of your algorithm plot your classifier as a function of x.