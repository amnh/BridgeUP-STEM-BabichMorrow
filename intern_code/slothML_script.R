#Script for machine learning with sloth skull data


# SUPERVISED LEARNING -----------------------------------------------------

# Load the caret package

# Import the dataset sloth_landmarks.csv (in the lesson_plans/machine_learning folder)
# Make sure to import "From Text (base)"


# View the data


# Exploratory data analysis -----------------------------------------------

# Refer to your code from intro_machinelearning_supervised.Rmd
# There are A LOT of variables in this dataset, so feel free to explore whatever you think looks most interesting
# Spend a little time on this looking at variables you think might be interesting later


# Use the featurePlot() function to look at the variables (you won't be able to see them all at once)
# You can color the plots based on species or genus to compare Choloepus to Bradypus


# Validation & training sets ----------------------------------------------

# Refer to your previous code to split your dataset into validation and training sets


# Run algorithms -----------------------------------------------------

# Set up the variables "control" and "metric" in order to run the models


# Build five types of supervised learning models (following the code for the iris data)


# Compare the results of the models
# Which model(s) have high accuracy?



# Make predictions --------------------------------------------------------

# Run all five models on the validation data using the predict() function


# View the confusion matrices for the models


# Interpret your results: which models were most accurate?
# Was it easier to classify some species than others?



# Other approaches --------------------------------------------------------

# Now it's time to explore!

# Try adapting your machine learning script above to addreeess a different classification question
# For example: classifying based on genus only (Bradypus vs. Choloepus)
# Picking a genus and jsut running the models within that genus
# Picking only species with a certain amount of data points





# UNSUPERVISED LEARNING ---------------------------------------------------

# Load the cluster package


# K-means clustering ------------------------------------------------------

# Use your code from intro_machinelearning_unsupervised.Rmd

# Perform k-means clustering - think about how many clusters you want
# Are you trying to cluster specimens into species or genuses?


# Check how the clusters compare to the specimen identities (either genus or species)



# Hierarchical clustering -------------------------------------------------

# Scale the landmark variables you plan to use in your analyses

# Use hclust() to perform agglomerative hierarchical clustering
# Visualize the results


# Use diana() to perform divisive hierarchical clustering
# Visualize the results



# Bonus hierarchical clustering -------------------------------------------

# As a bonus, you can compare the agglomerative and divisive results

# Install and load the dendextend package


# Use the function tanglegram() to compare the two dendrograms you made with hclust() and diana()
# If you get stumped, use the help menu
# You can also look on this website: https://uc-r.github.io/hc_clustering#dendro





