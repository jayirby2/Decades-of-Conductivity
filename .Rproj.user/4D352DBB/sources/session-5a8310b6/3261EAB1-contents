library(tidyverse)
library(caret)

# Perform cross-validation to determine best span values for LOESS models
control_sc <- trainControl(method = "repeatedcv", number = 10, repeats = 5)
grid_sc <- expand.grid(span = seq(0.3, 0.7, len = 5), degree = 1)

validation_model_sc <- train(`Specific Conductivity` ~ Year, data = umr_data, 
                             method = "gamLoess", tuneGrid = grid_sc, 
                             trControl = control_sc)

optimal_span_sc <- validation_model_sc$bestTune$span

# For pH model
# Identify most optimal span value, testing between 0.3 and 0.7 
control_pH <- trainControl(method = "repeatedcv", number = 10, repeats = 5)
grid_pH <- expand.grid(span = seq(0.3, 0.7, len = 5), degree = 1)

# Perform cross-validation
validation_model_pH <- train(pH ~ Year, data = umr_data, method = "gamLoess", 
                             tuneGrid = grid_pH, trControl = control_pH)

optimal_span_pH <- validation_model_pH$bestTune$span
# Build LOESS models

# For conductivity

loess_model_sc <- loess(`Specific Conductivity` ~ Year, data = umr_data, 
                        span = 0.5, family = "symmetric")
# For pH

loess_model_pH <- loess(pH ~ Year, data = umr_data, 
                        span = optimal_span_pH, family = "symmetric")

# Predicting missing values for interpolation
# Setting se = TRUE for errorbars

conductivity_1986_1989 <- predict(loess_model_sc, 
                                 newdata = data.frame(Year = 1986:1989),
                                 se = TRUE)

conductivity_1990_1994 <- predict(loess_model_sc, 
                                 newdata = data.frame(Year = 1990:1994),
                                 se = TRUE)

pH_1986_1989 <- predict(loess_model_pH, newdata = data.frame(Year = 1986:1989))

pH_1990_1994 <- predict(loess_model_pH, newdata = data.frame(Year = 1990:1994))



