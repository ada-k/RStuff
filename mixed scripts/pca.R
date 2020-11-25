# load dataset
data = state.x77
data

# standardisation and pca

# standardisation
scaled_data = scale(data, center = TRUE, scale = TRUE)

# pca
pca = prcomp(scaled_data, scale = FALSE) #using pca inbuilt standardisation tool
pca

summary(pca)

pca$scores

# plotting
biplot(pca)
install.packages("ggfortify")
library(ggfortify)
pca_plot <- autoplot(pca, data = scaled_data)
pca_plot
install.packages("factoextra")
library(factoextra)
fviz_eig(pca)

fviz_pca_ind(pca,
             col.ind = "cos2", # Color by the quality of representation
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)

# pca scores
pca$x 

# scores for 1st 2 components
pca$x[,1]
pca$x[,2]

#biplot for the 1st 2 components
biplot(pca, choices = 1:2)

####################################3
# Note: we may interpret the first two PCs as follows: -->
# PC1: a measure of overall rates of serious crimes -->
# PC2: a measure of level of urbanization of state -->
# Get the score matrix -->
  
dim(pca$x)
head(pca$x)

# Check the calculation -->
  
x.std <- apply(scaled_data, 2, function(x){(x-mean(x))/sd(x)})
max(abs(pca$x - (x.std %*% pca$rotation)))

# Check the covariance matrix of the scores -->
  
round(cov(pca$x), 3)

# Display a biplot the results (shows both pc scores and loading vectors) -->
  
pca$rotation
biplot(pca, scale=0)

# Display the biplot after changing the signs of loadings and scores -->

pca$rotation <- -pca$rotation
pca$x <- -pca$x
pca$rotation
biplot(pca, scale=0)

# Compute the proportion of variance explained (PVE) -->
  
pc.var <- pca$sdev^2
pve <- pc.var/sum(pc.var)
pve
cumsum(pve)
```

<!-- # Scree plot  -->
  
  ```{r}
plot(pve, xlab = "Principal Component", ylab = "Proportion of Variance Explained", ylim = c(0,1), type = 'b')
```

<!-- # Plot of cumulative PVE -->
  
  ```{r}
plot(cumsum(pve), xlab = "Principal Component", ylab = "Cumulative Proportion of Variance Explained", ylim = c(0,1), type = 'b')
```


  
