import matplotlib
matplotlib.use('GTKAgg')
 
import matplotlib.pyplot as plt
import numpy as np
from sklearn import datasets, linear_model
import pandas as pd
 
# Load CSV and columns
df = pd.read_csv("moby.csv")
 
Y = df['commits']
X = df['additions']
 
X=X.reshape(len(X),1)
Y=Y.reshape(len(Y),1)
 
# Split the data into training/testing sets
X_train = X[:-25]
X_test = X[-50:]
 
# Split the targets into training/testing sets
Y_train = Y[:-50]
Y_test = Y[-50:]
 
# Plot outputs
plt.scatter(X_test, Y_test,  color='red')
plt.title('Test Data')
plt.xlabel('Size')
plt.ylabel('Price')
plt.xticks(())
plt.yticks(())
 
plt.show()