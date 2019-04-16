# Response Curves

One of our main research questions is "What environmental variables influence the range of the sloths?" To answer that question, we need to look at what environmental variables contribute to our Maxent models and what affect they have on habitat suitability.

As you read along with your partner, incorporate this code into your Maxent script. One partner should be typing for the section **Environmental variables** and the second person should type for the section **Response curves** (remember good pair programming habits!).

## Environmental variables

When you built the models, you provided the model with all 19 of the BioClim variables we got from WorldClim. You can look at a list of those variables and what they mean [here](http://www.worldclim.org/bioclim). Maxent took those 19 variables and built an assortment of models (with different regularization multipliers and feature classes). Not all 19 variables went in to every model, however: Maxent uses machine learning to decide which variables are important to the model.

Our first step is to look at the Maxent model you created for your species and see which variables were selected. We can do that by checking which variables had non-zero coefficients in the model:

```
# Check which variables in the model have non-zero coefficients
your_model$betas
```

By looking at the `betas`, you can see the names of those variables, what feature class was applied (if the variable name is followed by `^2`, it's quadratic; if it starts with `hinge`, it's hinge, etc.), and the value of the coefficient. Don't worry too much about the feature class, we're just concerned with what variables were used.

## Response curves

Now that you know what variables were incorporated into your model, you can see how those variables affect habitat suitability for the sloths. We do this by plotting *response curves*, which show the relationship between the variable and the habitat suitability.

To create response curves, we can use the `response.plot()` function from the `maxnet` package. You need to provide the name of your model, the name of the variable you want to plot (from looking at `betas`), and `type = 'cloglog'`. (You might need to check out the help menu!)

```
# load the package maxnet

# Use the response.plot function to plot response curves

```

## Interpretation

Look back at the [table](http://www.worldclim.org/bioclim) of BioClim variables. How does your sloth species respond to these variables? What values for these variables are favorable for the species? Talk about this with your partner.
