# Prediction Assignment for "Practical Machine Learning Course" at Coursera.
## By: Mohammad Ali Dastgheib _ jdastgheib@ gmail.com
### Spring 2018


### Important: Citation issue
### The data for this project come from this source: http://web.archive.org/web/20161224072740/http:/groupware.les.inf.puc-rio.br/har. We use the document for this class, so we have to cite them as they have been very generous in allowing their data to be used for this kind of assignment.
### Velloso, E.; Bulling, A.; Gellersen, H.; Ugulino, W.; Fuks, H. Qualitative Activity Recognition of Weight Lifting Exercises. Proceedings of 4th International Conference in Cooperation with SIGCHI (Augmented Human '13) . Stuttgart, Germany: ACM SIGCHI, 2013.


# Abstract: 
## Weight Lifting Exercises Dataset
This human activity recognition research has traditionally focused on discriminating between different activities, i.e. to predict "which" activity was performed at a specific point in time

The "how (well)" investigation has only received little attention so far, even though it potentially provides useful information for a large variety of applications,such as sports training.

Six young health participants were asked to perform one set of 10 repetitions of the Unilateral Dumbbell Biceps Curl in five different fashions: exactly according to the specification (Class A), throwing the elbows to the front (Class B), lifting the dumbbell only halfway (Class C), lowering the dumbbell only halfway (Class D) and throwing the hips to the front (Class E). Class A corresponds to the specified execution of the exercise, while the other 4 classes correspond to common mistakes. 

### The downloaded dataset:
### . "train set": pml-training.csv
### . "test set": pml-testing.csv


# Feature Selection:
The raw dataset has a lot of columns that (mostly) only contain "NA" entries. In order to attain a tidy data set, these columns 
are removed from the final dataset. There are also some columns that using them for classification is not reasonable.
## for full information refer to the code book (metadata) which is in the same github directory with the name: "meta_data.md".


# Chosen Model:
The chosen model for this machine learning project is "Random Forest". We want to point out some of great features of 
this model that causes this model to be perfect for the classification problem
. Random Forest (Trees in general) have shown to be powerful when there is non-linearity among the data.
. Usually (Random Forest is) one of the two top performing algorithms along with boosting in prediction contests.

## Packages Used:
The only package that must be downloaded (if not yet instaled) is "randomForest" package.

### Summary of this package:
Package "randomForest""
March 25, 2018
Title Breiman and Cutler's Random Forests for Classification and
Regression
Version 4.6-14
Date 2018-03-22
Depends R (>= 3.2.2), stats
Suggests RColorBrewer, MASS
Author Fortran original by Leo Breiman and Adele Cutler, R port by Andy Liaw and Matthew Wiener.
Description Classification and regression based on a forest of trees using random inputs, based on Breiman (2001) <DOI:10.1023/A:1010933404324>.

# Simulation Results: 

Call:
 randomForest(x = x, y = y, mtry = res[which.min(res[, 2]), 1]) 
               Type of random forest: classification.
                     Number of trees: 500.
No. of variables tried at each split: 14.
### OOB estimate of  error rate: 0.3%
		
## Confusion matrix:
###          A-        B-        C-        D-        E-      class.error-

### A     5578        2        0        0        0     0.0003584229
### B       11     3783        3        0        0     0.0036871214
### C        0       10     3406        6        0     0.0046756283
### D        0        0       19     3196        1     0.0062189055
### E        0        0        3        4     3600     0.0019406709


# Discussion on Accuracy of the model 
# (Cross Validation "Dilemma")
There are some notes about the trees that should be pointed out. These notes help us understand the cross validation here. 
for every tree, around 30% of the data is unseen (which is called Out Of Bag "OOB").
There is function in randomForest package that allows you to tune parameters of the randomForest object. This tuning and optimizing is so close and identical to 
cross validation method, since it uses OOB samples to decide which paramters are producing higher accuracy. In the following the function is brefly explained:
 
## "tuneRF": Tune randomForest for the optimal mtry parameter
### Description
Starting with the default value of mtry, search for the optimal value (with respect to Out-of-Bag error estimate) of mtry for randomForest.

### Usage
tuneRF(x, y, mtryStart, ntreeTry=50, stepFactor=2, improve=0.05,
trace=TRUE, plot=TRUE, doBest=FALSE, ...).

### Arguments
x matrix or data frame of predictor variables
y response vector (factor for classification, numeric for regression)
mtryStart starting value of mtry; default is the same as in randomForest
ntreeTry number of trees used at the tuning step
stepFactor at each iteration, mtry is inflated (or deflated) by this value
improve the (relative) improvement in OOB error must be by this much for the search to
continue.
