# Importing Data
# --------------
code_dir = "C:/Users/Ali_D/Desktop/D_S/my_codes/Practical Machine Learning/course_project"
setwd(code_dir)

# Reading Data
# ------------
train_ds <- read.csv("pml-training.csv")
test_ds <- read.csv("pml-testing.csv")

# Cleaning Data
# -------------
classLabel <- train_ds$classe
train_ds <- train_ds[, 8: (length(names(train_ds))-1)]
test_ds <- test_ds[, 8: (length(names(test_ds))-1)]
names(train_ds) == names(test_ds)
ds = rbind.data.frame(train_ds, test_ds)

is_na_sum = vector()
for (idx in seq_along(names(ds))) {
  is_na_sum = c(is_na_sum, sum(is.na(ds[, idx])) )}
ds <- ds[, which(!as.logical(is_na_sum))]

train_ds <- ds[1 : (nrow(ds) - 20), ]; train_ds <- cbind.data.frame(classLabel, train_ds)
test_ds <-  ds[(nrow(ds) - 20 + 1) : nrow(ds), ]
rm(ds)

sample_train_idx = sample(1: nrow(train_ds), 100)
sample_train_ds <- train_ds[sample_train_idx ,]

# Processing: Machine Learning
# ============================
set.seed(110)
library(randomForest)
system.time({
  RF_base <- tuneRF(x = train_ds[, 2: ncol(train_ds)], y = train_ds[, 1],
                    ntreeTry = 500,
                    trace=TRUE, plot=TRUE, doBest=TRUE)
})

# user  system elapsed 
# 270.81    0.34   271.30 

RF_base
imp_acc = importance(RF_base, 1); imp_acc[, 1] = imp_acc[order(imp_acc[, 1]/max(imp_acc[, 1]), decreasing = T), ]
imp_Gini = importance(RF_base, 2);imp_Gini[, 1] = imp_Gini[order(imp_Gini[, 1]/max(imp_Gini[, 1]), decreasing = T), ]

RF_pred <- predict(RF_base, test_ds) 
