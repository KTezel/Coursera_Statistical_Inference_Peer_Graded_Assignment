

## PART 1: SIMULATION EXERCISE
## In this part, we are investigating a randomly generated exponential distribution and compare it with the central Limit Theory(CLT). The process requires 1000 repeats and, in each repeat, we take the mean of the 40 numbers and put that into an array of numbers. If our assumptions about the CLT is true, then this distribution should show some normal distribution properties.

## Create An Exponential Distribution
### Set the seed
set.seed(1)

### Create variables necessary for the distribution sampling
## The means of exponential distributions with sample size 40 and 1000 repeats will be appended to a vector.

sample_size <- 40
num_of_simulations <- 1000
lambda = 0.2
exp_dist <- NULL

for(i in 1:num_of_simulations) {
        exp_dist <- c(exp_dist, mean(rexp(sample_size, lambda)))
}
exp_dist <- data.frame("Means" = c(exp_dist))
sample_data_mean <- 1/lambda
sample_data_var <- ((1/lambda)/sqrt(sample_size))^2


### 1. Show sample mean and compare it to the theoretical mean of the distribution
## Theoretical mean and the mean of the exponential distribution vector should be pretty close.

sprintf("Theoretical mean is %d", 1/lambda)
sprintf("Mean based on the simulation distribution is %f", mean(exp_dist$Means))

### 2. Show how variable the sample is (via variance) and compare it to the theoretical variance of the distribution.
## Theoretical variance and the variance of the exponential distribution vector should be pretty close.
sprintf("Theoretical variance is %f", ((1/lambda)/sqrt(sample_size))^2)
sprintf(" Variance based on the simulation distribution is %f", var(exp_dist$Means))


### 3. Show that distribution is approximately normal
## The histogram of the means under exponential distribution sample should look like a normal distribution as it can be seen in the graph below.
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")

## Red line is showing the mean of the exponential distribution. Green line is showing the theoretical mean. As you can see, they are pretty close.

ggplot(exp_dist, aes(x = Means)) +
        geom_histogram(aes(y=..density..), color = "black", fill="white", binwidth = .2) +
        stat_function(fun=dnorm, args=list(mean=1/lambda), sd=sd(exp_dist$Means), color="blue", size=1)+
        geom_vline(aes(xintercept = mean(Means)), color = "red", linetype="dashed", size=1) +
        geom_vline(aes(xintercept = mean(1/lambda)), color = 'green', linetype = "dashed", size=1) +
        labs(x = 'Means', title = 'Histogram of 1000 Exponential Mean Distributions')+
        geom_density(alpha = .2) +
        xlab("Averages of Each Sampling") + ylab("Density") + 
        theme(plot.title = element_text(hjust = 0.5)) 


## There are multiple ways to check whether the exponential distribution sample is normally distributed or not. One of the most common ways is to use a quantile-quantile plotting. If the quantiles from the data set matches the quantiles from a normal distibution, then it is safe to assume that the data is normally distributed.
## As it can be seen from the Q-Q Plot graph, the quantiles align linearly; however, it is common to see that the outer quantiles doesn't match perfectly. 

qqnorm(exp_dist$Means)
qqline(exp_dist$Means, col = "blue")
