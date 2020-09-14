## Load packages

library("plyr")
library("lattice")
library("ggplot2")
library("dplyr")
library("readr")
library("rmarkdown")
library("Rmisc")
library("devtools")
library("gghalves")

# width and height variables for saved plots
w = 6
h = 4

# Define limits of y-axis
y_lim_min = 4
y_lim_max = 7.5

# iris dataset
before = iris$Sepal.Length[1:50]
after = iris$Sepal.Length[51:100]
n <- length(before)
d <- data.frame(y = c(before, after),
                x = rep(c(1,2), each=n),
                id = factor(rep(1:n,2)))


# Let's create a first very basic figure only showing the individual datapoints
f1 <- ggplot(data=d, aes(y=y)) +
  
  #Add geom_() objects
  geom_point(aes(x=x), color = "magenta", size = 1.5) +
  
  #Define additional settings
  scale_x_continuous(breaks=c(1,2), labels=c("Before", "After"), limits=c(0, 3)) +
  xlab("Condition") + ylab("Value") +
  ggtitle('Figure 1: Repeated measures individual datapoints') +
  theme_classic() +
  coord_cartesian(ylim=c(y_lim_min, y_lim_max))
f1

# Let's again create a simple figure, but now with the datapoints connected (i.e., intra-individual trends).

f2 <- ggplot(data=d, aes(y=y)) +
  
   #Add geom_() objects
   geom_point(aes(x=x), color = "magenta", size = 1.5) +
   geom_line(aes(x=x, group=id), color = 'lightgray') +
   
   #Define additional settings
   scale_x_continuous(breaks=c(1,2), labels=c("Before", "After"), limits=c(0, 3)) +
   xlab("Condition") + ylab("Value") +
   ggtitle('Figure 2: Repeated measures with connecting lines') +
   theme_classic()+
   coord_cartesian(ylim=c(y_lim_min, y_lim_max))
f2

# Let's add some jitter to avoid that datapoints overlap.
set.seed(321)
d$xj <- jitter(d$x, amount=.09)

# Recreate above plot using jitter
f3 <- ggplot(data=d, aes(y=y)) +
  
  #Add geom_() objects
  geom_point(aes(x=xj), color = "magenta", size = 1.5) +
  geom_line(aes(x=xj, group=id), color = 'lightgray') +
  
  #Define additional settings
  scale_x_continuous(breaks=c(1,2), labels=c("Before", "After"), limits=c(0, 3)) +
  xlab("Condition") + ylab("Value") +
  ggtitle('Figure 3: Repeated measures with jitter and connections') +
  theme_classic()+
  coord_cartesian(ylim=c(y_lim_min, y_lim_max))
f3

# Recreate the above plots with two colors for teo conditions
f4 <- ggplot(data=d, aes(y=y)) +
  
  #Add geom_() objects
  geom_point(data = d %>% filter(x=="1"), aes(x=xj), color = 'dodgerblue', size = 1.5,
             alpha = .6) +
  geom_point(data = d %>% filter(x=="2"), aes(x=xj), color = 'darkorange', size = 1.5, 
             alpha = .6) +
  geom_line(aes(x=xj, group=id), color = 'lightgray', alpha = .3) +
  
  #Define additional settings
  scale_x_continuous(breaks=c(1,2), labels=c("Before", "After"), limits=c(0, 3)) +
  xlab("Condition") + ylab("Value") +
  ggtitle('Figure 4: Repeated measures with jittered datapoints and connections') +
  theme_classic()+
  coord_cartesian(ylim=c(y_lim_min, y_lim_max))
f4

# Let's add box- and violinplots to create `raincloud` like plots
f5 <- ggplot(data = d, aes(y = y)) +
  
  #Add geom_() objects
  geom_point(data = d %>% filter(x =="1"), aes(x = xj), color = 'dodgerblue', size = 1.5, 
             alpha = .6) +
  geom_point(data = d %>% filter(x =="2"), aes(x = xj), color = 'darkorange', size = 1.5, 
             alpha = .6) +
  geom_line(aes(x = xj, group = id), color = 'lightgray', alpha = .3) +
  
  geom_half_boxplot(
    data = d %>% filter(x=="1"), aes(x=x, y = y), position = position_nudge(x = -.25), 
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2, 
    fill = 'dodgerblue') +
  
  geom_half_boxplot(
    data = d %>% filter(x=="2"), aes(x=x, y = y), position = position_nudge(x = .15), 
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2, 
    fill = 'darkorange') +
  
  geom_half_violin(
    data = d %>% filter(x=="1"),aes(x = x, y = y), position = position_nudge(x = -.3), 
    side = "l", fill = 'dodgerblue') +
  
  geom_half_violin(
    data = d %>% filter(x=="2"),aes(x = x, y = y), position = position_nudge(x = .3), 
    side = "r", fill = "darkorange") +
  
  
  #Define additional settings
  scale_x_continuous(breaks=c(1,2), labels=c("Before", "After"), limits=c(0, 3)) +
  xlab("Condition") + ylab("Value") +
  ggtitle('Figure 5: Repeated measures with box- and violin plots') +
  theme_classic()+
  coord_cartesian(ylim=c(y_lim_min, y_lim_max))
f5

f5b <- ggplot(data = d, aes(y = y)) +
  
  #Add geom_() objects
  geom_point(data = d %>% filter(x =="1"), aes(x = xj), color = 'dodgerblue', size = 1.5, 
             alpha = .5) +
  geom_point(data = d %>% filter(x =="2"), aes(x = xj), color = 'darkorange', size = 1.5, 
             alpha = .5) +
  geom_line(aes(x = xj, group = id), color = 'lightgray', alpha = .5) +
  
  geom_half_boxplot(
    data = d %>% filter(x=="1"), aes(x=x, y = y), position = position_nudge(x = -.25), 
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = TRUE, width = .1, 
    fill = 'dodgerblue', alpha = .5) +
  
  geom_half_boxplot(
    data = d %>% filter(x=="2"), aes(x=x, y = y), position = position_nudge(x = .15), 
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = TRUE, width = .1, 
    fill = 'darkorange', alpha = .5) +
  
  geom_half_violin(
    data = d %>% filter(x=="1"),aes(x = x, y = y), position = position_nudge(x = 1.3), 
    side = "r", fill = 'dodgerblue', alpha = .5, trim = FALSE) +
  
  geom_half_violin(
    data = d %>% filter(x=="2"),aes(x = x, y = y), position = position_nudge(x = .3), 
    side = "r", fill = "darkorange", alpha = .5, trim = FALSE) +
  
  
  #Define additional settings
  scale_x_continuous(breaks=c(1,2), labels=c("Before", "After"), limits=c(0, 3)) +
  xlab("Condition") + ylab("Value") +
  ggtitle('Figure 5b: Repeated measures with box- and violin plots') +
  theme_classic()+
  coord_cartesian(ylim=c(y_lim_min, y_lim_max))
f5b

f5c <- ggplot(data = d, aes(y = y)) +
  
  #Add geom_() objects
  geom_point(data = d %>% filter(x =="1"), aes(x = xj), color = 'dodgerblue', size = 1.5, 
             alpha = .5) +
  geom_point(data = d %>% filter(x =="2"), aes(x = xj), color = 'darkorange', size = 1.5, 
             alpha = .5) +
  geom_line(aes(x = xj, group = id), color = 'lightgray', alpha = .5) +
  
  geom_half_boxplot(
    data = d %>% filter(x=="1"), aes(x=x, y = y), position = position_nudge(x = 1.21), 
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = TRUE, width = .1, 
    fill = 'dodgerblue', alpha = .5) +
  
  geom_half_boxplot(
    data = d %>% filter(x=="2"), aes(x=x, y = y), position = position_nudge(x = .15), 
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = TRUE, width = .1, 
    fill = 'darkorange', alpha = .5) +
  
  geom_half_violin(
    data = d %>% filter(x=="1"),aes(x = x, y = y), position = position_nudge(x = 1.3), 
    side = "r", fill = 'dodgerblue', alpha = .5, trim = FALSE) +
  
  geom_half_violin(
    data = d %>% filter(x=="2"),aes(x = x, y = y), position = position_nudge(x = .3), 
    side = "r", fill = "darkorange", alpha = .5, trim = FALSE) +
  
  
  #Define additional settings
  scale_x_continuous(breaks=c(1,2), labels=c("Before", "After"), limits=c(0, 3)) +
  xlab("Condition") + ylab("Value") +
  ggtitle('Figure 5c: Repeated measures with box- and violin plots') +
  theme_classic()+
  coord_cartesian(ylim=c(y_lim_min, y_lim_max))
f5c

# A potential downside of the current approach is that it uses a lot of filtering and a lot of `geom`s.
# Add descriptive statistics
'''
- Create a dataframe including:
  - Mean
- Median
- Standard deviation
- Standard error
- Confidence interval (95 %)
'''
score_mean_1 <- mean(d$y[1:50])
score_mean_2 <- mean(d$y[51:100])
score_median1 <- median(d$y[1:50])
score_median2 <- median(d$y[51:100])
score_sd_1 <- sd(d$y[1:50])
score_sd_2 <- sd(d$y[51:100])
score_se_1 <- score_sd_1/sqrt(n) #-> adjust your n
score_se_2 <- score_sd_2/sqrt(n) #-> adjust your n
score_ci_1 <- CI(d$y[1:50], ci = 0.95)
score_ci_2 <- CI(d$y[51:100], ci = 0.95)
#Create data frame with 2 rows and 7 columns containing the descriptives
group <- c("x", "z")
N <- c(50, 50)
score_mean <- c(score_mean_1, score_mean_2)
score_median <- c(score_median1, score_median2)
sd <- c(score_sd_1, score_sd_2)
se <- c(score_se_1, score_se_2)
ci <- c((score_ci_1[1] - score_ci_1[3]), (score_ci_2[1] - score_ci_2[3]))
#Create the dataframe
summary_df <- data.frame(group, N, score_mean, score_median, sd, se, ci)

# Let's add the items calculated in `summary_df` to the figure
f6 <- ggplot(data = d, aes(y = y)) +
  
  #Add geom_() objects
  geom_point(data = d %>% filter(x =="1"), aes(x = xj), color = 'dodgerblue', size = 1.5, 
             alpha = .6) +
  geom_point(data = d %>% filter(x =="2"), aes(x = xj), color = 'darkorange', size = 1.5, 
             alpha = .6) +
  geom_line(aes(x = xj, group = id), color = 'lightgray', alpha = .3) +
  
  geom_half_boxplot(
    data = d %>% filter(x=="1"), aes(x=x, y = y), position = position_nudge(x = -.28), 
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2, 
    fill = 'dodgerblue') +
  
  geom_half_boxplot(
    data = d %>% filter(x=="2"), aes(x=x, y = y), position = position_nudge(x = .18), 
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2, 
    fill = 'darkorange') +
  
  geom_half_violin(
    data = d %>% filter(x=="1"),aes(x = x, y = y), position = position_nudge(x = -.3), 
    side = "l", fill = 'dodgerblue') +
  
  geom_half_violin(
    data = d %>% filter(x=="2"),aes(x = x, y = y), position = position_nudge(x = .3), 
    side = "r", fill = "darkorange") +
  
  geom_point(data = d %>% filter(x=="1"), aes(x = x, y = score_mean[1]), 
             position = position_nudge(x = -.13), color = "dodgerblue", alpha = .6, size = 1.5) +
  
  geom_errorbar(data = d %>% filter(x=="1"), aes(x = x, y = score_mean[1], 
                                                 ymin = score_mean[1]-ci[1], ymax = score_mean[1]+ci[1]), 
                position = position_nudge(-.13), 
                color = "dodgerblue", width = 0.05, size = 0.4, alpha = .5) + 
  
  geom_point(data = d %>% filter(x=="2"), aes(x = x, y = score_mean[2]), 
             position = position_nudge(x = .13), color = "darkorange", alpha = .6, size = 1.5)+ 
  
  geom_errorbar(data = d %>% filter(x=="2"), aes(x = x, y = score_mean[2], 
                                                 ymin = score_mean[2]-ci[2], 
                                                 ymax = score_mean[2]+ci[2]), position = position_nudge(.13), color = "darkorange", 
                width = 0.05, size = 0.4, alpha = .5) +
  
  
  #Define additional settings
  scale_x_continuous(breaks=c(1,2), labels=c("Before", "After"), limits=c(0, 3)) +
  xlab("Condition") + ylab("Value") +
  ggtitle('Figure 6: Repeated measures with box- and violin plots') +
  theme_classic()+
  coord_cartesian(ylim=c(y_lim_min, y_lim_max))
f6

'''
Optionally you could add a line between the two means.
Define the x-coordinates where the line needs to be drawn.
Note these coordinates can be calculated as 1 - position_nudge() for the first variable and 2 + position_nudge() for the second variable, which in our case is 1 - .13 = .87  and 2 + .13 = 2.13.
'''
x_tick_means <- c(.87, 2.13)
f7 <- ggplot(data = d, aes(y = y)) +
  
  #Add geom_() objects
  geom_point(data = d %>% filter(x =="1"), aes(x = xj), color = 'dodgerblue', size = 1.5, 
             alpha = .6) +
  geom_point(data = d %>% filter(x =="2"), aes(x = xj), color = 'darkorange', size = 1.5, 
             alpha = .6) +
  geom_line(aes(x = xj, group = id), color = 'lightgray', alpha = .3) +
  
  geom_half_boxplot(
    data = d %>% filter(x=="1"), aes(x=x, y = y), position = position_nudge(x = -.28), 
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2, 
    fill = 'dodgerblue') +
  
  geom_half_boxplot(
    data = d %>% filter(x=="2"), aes(x=x, y = y), position = position_nudge(x = .18), 
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2, 
    fill = 'darkorange') +
  
  geom_half_violin(
    data = d %>% filter(x=="1"),aes(x = x, y = y), position = position_nudge(x = -.3), 
    side = "l", fill = 'dodgerblue') +
  
  geom_half_violin(
    data = d %>% filter(x=="2"),aes(x = x, y = y), position = position_nudge(x = .3), 
    side = "r", fill = "darkorange") +
  
  geom_point(data = d %>% filter(x=="1"), aes(x = x, y = score_mean[1]), 
             position = position_nudge(x = -.13), color = "dodgerblue", alpha = .6, size = 1.5) +
  
  geom_errorbar(data = d %>% filter(x=="1"), aes(x = x, y = score_mean[1], 
                                                 ymin = score_mean[1]-ci[1], ymax = score_mean[1]+ci[1]), 
                position = position_nudge(-.13), 
                color = "dodgerblue", width = 0.05, size = 0.4, alpha = .6) + 
  
  geom_point(data = d %>% filter(x=="2"), aes(x = x, y = score_mean[2]), 
             position = position_nudge(x = .13), color = "darkorange", alpha = .6, size = 1.5)+ 
  
  geom_errorbar(data = d %>% filter(x=="2"), aes(x = x, y = score_mean[2], 
                                                 ymin = score_mean[2]-ci[2], 
                                                 ymax = score_mean[2]+ci[2]), position = position_nudge(.13), color = "darkorange", 
                width = 0.05, size = 0.4, alpha = .6) +
  
  #Add a line connecting the two means
  geom_line(data = summary_df, aes(x = x_tick_means, y = score_mean), color = 'gray', 
            size = 1) +
  
  #Define additional settings
  scale_x_continuous(breaks=c(1,2), labels=c("Before", "After"), limits=c(0, 3)) +
  xlab("Condition") + ylab("Value") +
  ggtitle('Figure 7: Repeated measures with box- and violin plots and means + ci ') +
  theme_classic()+
  coord_cartesian(ylim=c(y_lim_min, y_lim_max))
f7


# As a last step, let's create these figures for a 2 x 2 repeated measures study
# Define an additional variable `z` which has two categories `3` and `4` and create a second jittered variable.

before = iris$Sepal.Length[1:50] 
after = iris$Sepal.Length[51:100]
n <- length(before) 
d <- data.frame(y = c(before, after),
x = rep(c(1,2), each=n),
z = rep(c(3,4), each=n), 
id = factor(rep(1:n,2))) 
set.seed(321)
d$xj <- jitter(d$x, amount = .09) 
d$xj_2 <- jitter(d$z, amount = .09)

f8 <- ggplot(data = d, aes(y = y)) +

#Add geom_() objects
geom_point(data = d %>% filter(x =="1"), aes(x = xj), color = 'dodgerblue', size = 1.5, 
alpha = .6) +
geom_point(data = d %>% filter(x =="2"), aes(x = xj), color = 'darkorange', size = 1.5, 
alpha = .6) +
geom_point(data = d %>% filter(z =="3"), aes(x = xj_2), color = 'dodgerblue', size = 1.5, 
alpha = .6) + 
geom_point(data = d %>% filter(z =="4"), aes(x = xj_2), color = 'darkorange', size = 1.5, 
alpha = .6) +
geom_line(aes(x = xj, group = id), color = 'lightgray', alpha = .3) +
geom_line(aes(x = xj_2, group = id), color = 'lightgray', alpha = .3) +

geom_half_boxplot(
data = d %>% filter(x=="1"), aes(x=x, y = y), position = position_nudge(x = -.35), 
side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2, 
fill = 'dodgerblue', alpha = .6) +

geom_half_boxplot(
data = d %>% filter(x=="2"), aes(x=x, y = y), position = position_nudge(x = -1.16), 
side = "l",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2, 
fill = 'darkorange', alpha = .6) +

geom_half_boxplot(
data = d %>% filter(z=="3"), aes(x=z, y = y), position = position_nudge(x = 1.3), 
side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2, 
fill = 'dodgerblue', alpha = .6) +

geom_half_boxplot(
data = d %>% filter(z=="4"), aes(x=z, y = y), position = position_nudge(x = .2), 
side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2, 
fill = 'darkorange', alpha = .6) +

geom_half_violin(
data = d %>% filter(x=="1"),aes(x = x, y = y), position = position_nudge(x = -.40), 
side = "l", fill = 'dodgerblue', alpha = .6) +

geom_half_violin(
data = d %>% filter(x=="2"),aes(x = x, y = y), position = position_nudge(x = -1.40), 
side = "l", fill = "darkorange", alpha = .6) +

geom_half_violin(
data = d %>% filter(z=="3"),aes(x = z, y = y), position = position_nudge(x = 1.45), 
side = "r", fill = 'dodgerblue', alpha = .6) +

geom_half_violin(
data = d %>% filter(z=="4"),aes(x = z, y = y), position = position_nudge(x = .45), 
side = "r", fill = "darkorange", alpha = .6) +

geom_point(data = d %>% filter(x=="1"), aes(x = x, y = score_mean[1]), 
position = position_nudge(x = -.13), color = "dodgerblue", alpha = .6, size = 1.5) +

geom_errorbar(data = d %>% filter(x=="1"), aes(x = x, y = score_mean[1], 
ymin = score_mean[1]-ci[1], ymax = score_mean[1]+ci[1]), 
position = position_nudge(-.13), 
color = "dodgerblue", width = 0.05, size = 0.4, alpha = .6) + 

geom_point(data = d %>% filter(x=="2"), aes(x = x, y = score_mean[2]), 
position = position_nudge(x = -1.1), color = "darkorange", alpha = .6, size = 1.5)+ 

geom_errorbar(data = d %>% filter(x=="2"), aes(x = x, y = score_mean[2], 
ymin = score_mean[2]-ci[2], 
ymax = score_mean[2]+ci[2]), position = position_nudge(x = -1.1), color = "darkorange", 
width = 0.05, size = 0.4, alpha = .6) +
geom_point(data = d %>% filter(z=="3"), aes(x = z, y = score_mean[1]), 
position = position_nudge(x = 1.15), color = "dodgerblue", alpha = .5) +

geom_errorbar(data = d %>% filter(z=="3"), aes(x = z, y = score_mean[1], 
ymin = score_mean[1]-ci[1], 
ymax = score_mean[1]+ci[1]), position = position_nudge(1.15), 
color = "dodgerblue", width = 0.05, size = 0.4, alpha = .5)+ 
geom_point(data = d %>% filter(z=="4"), aes(x = z, y = score_mean[2]), 
position = position_nudge(x = .15), color = "darkorange", alpha = .5)+
geom_errorbar(data = d %>% filter(z=="4"), aes(x = z, y = score_mean[2], 
ymin = score_mean[2]-ci[2], ymax = score_mean[2]+ci[2]), position = position_nudge(.15), 
color = "darkorange", width = 0.05, size = 0.4, alpha = .5)+


#Define additional settings
scale_x_continuous(breaks=c(1,2,3,4), labels=c("Before", "After","Before", "After"), 
limits=c(0, 5))+
xlab("Condition") + ylab("Value") +
ggtitle('Figure 8: 2 x 2 Repeated measures with box- and violin plots') +
theme_classic()+
coord_cartesian(ylim=c(y_lim_min, y_lim_max))
f8

# Finally, let's add lines that connect the means of each group.
#First we must again define the x-coordinates of the means.
x_tick_means_x <- c(.87, 2.13) #same as above
x_tick_means_z <- c(2.87, 4.13) #just add 2 for each tick

f9 <- ggplot(data = d, aes(y = y)) +
  
  #Add geom_() objects
  geom_point(data = d %>% filter(x =="1"), aes(x = xj), color = 'dodgerblue', size = 1.5, 
             alpha = .6) +
  geom_point(data = d %>% filter(x =="2"), aes(x = xj), color = 'darkorange', size = 1.5, 
             alpha = .6) +
  geom_point(data = d %>% filter(z =="3"), aes(x = xj_2), color = 'dodgerblue', size = 1.5, 
             alpha = .6) + 
  geom_point(data = d %>% filter(z =="4"), aes(x = xj_2), color = 'darkorange', size = 1.5, 
             alpha = .6) +
  geom_line(aes(x = xj, group = id), color = 'lightgray', alpha = .3) +
  geom_line(aes(x = xj_2, group = id), color = 'lightgray', alpha = .3) +
  
  geom_half_boxplot(
    data = d %>% filter(x=="1"), aes(x=x, y = y), position = position_nudge(x = -.35), 
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2, 
    fill = 'dodgerblue', alpha = .6) +
  
  geom_half_boxplot(
    data = d %>% filter(x=="2"), aes(x=x, y = y), position = position_nudge(x = -1.16), 
    side = "l",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2, 
    fill = 'darkorange', alpha = .6) +
  
  geom_half_boxplot(
    data = d %>% filter(z=="3"), aes(x=z, y = y), position = position_nudge(x = 1.3), 
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2, 
    fill = 'dodgerblue', alpha = .6) +
  
  geom_half_boxplot(
    data = d %>% filter(z=="4"), aes(x=z, y = y), position = position_nudge(x = .2), 
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2, 
    fill = 'darkorange', alpha = .6) +
  
  geom_half_violin(
    data = d %>% filter(x=="1"),aes(x = x, y = y), position = position_nudge(x = -.40), 
    side = "l", fill = 'dodgerblue', alpha = .6) +
  
  geom_half_violin(
    data = d %>% filter(x=="2"),aes(x = x, y = y), position = position_nudge(x = -1.40), 
    side = "l", fill = "darkorange", alpha = .6) +
  
  geom_half_violin(
    data = d %>% filter(z=="3"),aes(x = z, y = y), position = position_nudge(x = 1.45), 
    side = "r", fill = 'dodgerblue', alpha = .6) +
  
  geom_half_violin(
    data = d %>% filter(z=="4"),aes(x = z, y = y), position = position_nudge(x = .45), 
    side = "r", fill = "darkorange", alpha = .6) +
  
  geom_point(data = d %>% filter(x=="1"), aes(x = x, y = score_mean[1]), 
             position = position_nudge(x = -.13), color = "dodgerblue", alpha = .6, size = 1.5) +
  
  geom_errorbar(data = d %>% filter(x=="1"), aes(x = x, y = score_mean[1], 
                                                 ymin = score_mean[1]-ci[1], ymax = score_mean[1]+ci[1]), 
                position = position_nudge(-.13), 
                color = "dodgerblue", width = 0.05, size = 0.4, alpha = .6) + 
  
  geom_point(data = d %>% filter(x=="2"), aes(x = x, y = score_mean[2]), 
             position = position_nudge(x = .13), color = "darkorange", alpha = .6, size = 1.5)+ 
  
  geom_errorbar(data = d %>% filter(x=="2"), aes(x = x, y = score_mean[2], 
                                                 ymin = score_mean[2]-ci[2], 
                                                 ymax = score_mean[2]+ci[2]), position = position_nudge(x = .13), color = "darkorange", 
                width = 0.05, size = 0.4, alpha = .6) +
  geom_point(data = d %>% filter(z=="3"), aes(x = z, y = score_mean[1]), 
             position = position_nudge(x = -.13), color = "dodgerblue", alpha = .5) +
  
  geom_errorbar(data = d %>% filter(z=="3"), aes(x = z, y = score_mean[1], 
                                                 ymin = score_mean[1]-ci[1], 
                                                 ymax = score_mean[1]+ci[1]), position = position_nudge(-.13), 
                color = "dodgerblue", width = 0.05, size = 0.4, alpha = .5)+ 
  geom_point(data = d %>% filter(z=="4"), aes(x = z, y = score_mean[2]), 
             position = position_nudge(x = .13), color = "darkorange", alpha = .5)+
  geom_errorbar(data = d %>% filter(z=="4"), aes(x = z, y = score_mean[2], 
                                                 ymin = score_mean[2]-ci[2], ymax = score_mean[2]+ci[2]), 
                position = position_nudge(.13), 
                color = "darkorange", width = 0.05, size = 0.4, alpha = .5)+
  
  #Add lines connecting the two means
  geom_line(data = summary_df, aes(x = x_tick_means_x, y = score_mean), 
            color = 'gray', size = 1) +
  geom_line(data = summary_df, aes(x = x_tick_means_z, y = score_mean), 
            color = 'gray', size = 1) +
  
  #Define additional settings
  scale_x_continuous(breaks=c(1,2,3,4), labels=c("Before", "After","Before", "After"), 
                     limits=c(0, 5))+
  xlab("Condition") + ylab("Value") +
  ggtitle('Figure 9: 2 x 2 Repeated measures with box- and violin plots') +
  theme_classic()+
  coord_cartesian(ylim=c(y_lim_min, y_lim_max))
f9

before = iris$Sepal.Length[1:50]
during = iris$Sepal.Length[51:100]
after = iris$Sepal.Length[1:50]
n <- length(before) 
d <- data.frame(y = c(before, during, after),
                x = rep(c(1,2,3), each=n),
                id = factor(rep(1:n,3)))
set.seed(321)
d$xj <- jitter(d$x, amount = .09) 

f10 <- ggplot(data=d, aes(y=y)) +
  
  #Add geom_() objects
  geom_point(data = d %>% filter(x=="1"), aes(x=xj), color = 'dodgerblue', size = 1.5,
             alpha = .6) +
  geom_point(data = d %>% filter(x=="2"), aes(x=xj), color = 'darkgreen', size = 1.5,
             alpha = .6) +
  geom_point(data = d %>% filter(x=="3"), aes(x=xj), color = 'darkorange', size = 1.5, 
             alpha = .6) +
  
  geom_line(aes(x=xj, group=id), color = 'lightgray', alpha = .3) +
  
  #Define additional settings
  scale_x_continuous(breaks=c(1,2,3), labels=c("Before", "During", "After"), limits=c(0.5, 3.5)) +
  xlab("Condition") + ylab("Value") +
  ggtitle('Figure 10: Repeated measures with jittered datapoints and connections') +
  theme_classic()+
  coord_cartesian(ylim=c(3.5, 7.5))
f10

# Three conditions
before = iris$Sepal.Width[1:50]
during = iris$Sepal.Length[51:100]
after = iris$Sepal.Length[1:50]
n <- length(before) 
d <- data.frame(y = c(before, during, after),
                x = rep(c(1,2,3), each=n),
                id = factor(rep(1:n,3)))
set.seed(321)
d$xj <- jitter(d$x, amount = .09) 
f11 <- ggplot(data=d, aes(y=y)) +
  
  #Add geom_() objects
  geom_point(data = d %>% filter(x=="1"), aes(x=xj), color = 'dodgerblue', size = 1.5,
             alpha = .6) +
  geom_point(data = d %>% filter(x=="2"), aes(x=xj), color = 'darkgreen', size = 1.5,
             alpha = .6) +
  geom_point(data = d %>% filter(x=="3"), aes(x=xj), color = 'darkorange', size = 1.5, 
             alpha = .6) +
  
  geom_line(aes(x=xj, group=id), color = 'lightgray', alpha = .3) +
  
  geom_half_violin(
    data = d %>% filter(x=="1"),aes(x = x, y = y), position = position_nudge(x = 2.2), 
    side = "r", fill = 'dodgerblue', alpha = .5, color = "dodgerblue", trim = TRUE) +
  
  geom_half_violin(
    data = d %>% filter(x=="2"),aes(x = x, y = y), position = position_nudge(x = 1.2), 
    side = "r", fill = "darkgreen", alpha = .5, color = "darkgreen", trim = TRUE) +
  
  geom_half_violin(
    data = d %>% filter(x=="3"),aes(x = x, y = y), position = position_nudge(x = 0.2), 
    side = "r", fill = "darkorange", alpha = .5, color = "darkorange", trim = TRUE) +
  
  #Define additional settings
  scale_x_continuous(breaks=c(1,2,3), labels=c("Before", "During", "After"), limits=c(0.5, 4)) +
  xlab("Condition") + ylab("Value") +
  ggtitle('Figure 11: Repeated measures with jittered datapoints and connections') +
  theme_classic()+
  coord_cartesian(ylim=c(2.3, 7.2))
f11

# Butterfly three groups
f12 <- ggplot(data=d, aes(y=y)) +
  
  #Add geom_() objects
  geom_point(data = d %>% filter(x=="1"), aes(x=xj), color = 'dodgerblue', size = 1.5,
             alpha = .8) +
  geom_point(data = d %>% filter(x=="2"), aes(x=xj), color = 'darkgreen', size = 1.5,
             alpha = .8) +
  geom_point(data = d %>% filter(x=="3"), aes(x=xj), color = 'darkorange', size = 1.5, 
             alpha = .8) +
  
  geom_line(aes(x=xj, group=id), color = 'lightgray', alpha = .3) +
  
  geom_violin(
    data = d %>% filter(x=="1"),aes(x = x, y = y), position = position_nudge(x = 0),
    fill = 'dodgerblue', alpha = .1, color = "white", trim = TRUE) +
  
  geom_violin(
    data = d %>% filter(x=="2"),aes(x = x, y = y), position = position_nudge(x = 0),
    fill = "darkgreen", alpha = .1, color = "white", trim = FALSE) +
  
  geom_violin(
    data = d %>% filter(x=="3"),aes(x = x, y = y), position = position_nudge(x = 0),
    fill = "darkorange", alpha = .1, color = "white", trim = TRUE) +
  
  #Define additional settings
  scale_x_continuous(breaks=c(1,2,3), labels=c("Before", "During", "After"), limits=c(0.5, 4)) +
  xlab("Condition") + ylab("Value") +
  ggtitle('Figure 12: Repeated measures with jittered datapoints and connections') +
  theme_classic()+
  coord_cartesian(ylim=c(2.3, 7.2))
f12

# Distribution 3 conditions 2 groups
before = iris$Sepal.Width[1:50]
during = iris$Sepal.Length[51:100]
after = iris$Sepal.Length[1:50]
n <- length(before) 
d <- data.frame(y = c(before, during, after),
                x = rep(c(1,2,3), each=n),
                z = rep(c(4,5,6), each=n), 
                id = factor(rep(1:n,3)))
set.seed(321)
d$xj <- jitter(d$x, amount = .09) 
d$xj_2 <- jitter(d$z, amount = .09)
#d$xj_3 <- jitter(d$a, amount = .09)
f13 <- ggplot(data=d, aes(y=y)) +
  
  #Add geom_() objects
  geom_point(data = d %>% filter(x=="1"), aes(x=xj), color = 'dodgerblue', size = 1.5,
             alpha = .6) +
  geom_point(data = d %>% filter(x=="2"), aes(x=xj), color = 'darkgreen', size = 1.5,
             alpha = .6) +
  geom_point(data = d %>% filter(x=="3"), aes(x=xj), color = 'darkorange', size = 1.5, 
             alpha = .6) +
  
  #Add geom_() objects
  geom_point(data = d %>% filter(z=="4"), aes(x=xj_2), color = 'dodgerblue', size = 1.5,
             alpha = .6) +
  geom_point(data = d %>% filter(z=="5"), aes(x=xj_2), color = 'darkgreen', size = 1.5,
             alpha = .6) +
  geom_point(data = d %>% filter(z=="6"), aes(x=xj_2), color = 'darkorange', size = 1.5, 
             alpha = .6) +
  
  geom_line(aes(x=xj, group=id), color = 'lightgray', alpha = .3) +
  geom_line(aes(x=xj_2, group=id), color = 'lightgray', alpha = .3) +
  
  geom_half_violin(
    data = d %>% filter(x=="1"),aes(x = x, y = y), position = position_nudge(x = -0.2), 
    side = "l", fill = 'dodgerblue', alpha = .5, color = "dodgerblue", trim = TRUE) +
  
  geom_half_violin(
    data = d %>% filter(x=="2"),aes(x = x, y = y), position = position_nudge(x = -1.2), 
    side = "l", fill = "darkgreen", alpha = .5, color = "darkgreen", trim = TRUE) +
  
  geom_half_violin(
    data = d %>% filter(x=="3"),aes(x = x, y = y), position = position_nudge(x = -2.2), 
    side = "l", fill = "darkorange", alpha = .5, color = "darkorange", trim = TRUE) +
  
  geom_half_violin(
    data = d %>% filter(z=="4"),aes(x = x, y = y), position = position_nudge(x = 5.2), 
    side = "r", fill = 'dodgerblue', alpha = .5, color = "dodgerblue", trim = TRUE) +
  
  geom_half_violin(
    data = d %>% filter(z=="5"),aes(x = x, y = y), position = position_nudge(x = 4.2), 
    side = "r", fill = "darkgreen", alpha = .5, color = "darkgreen", trim = TRUE) +
  
  geom_half_violin(
    data = d %>% filter(z=="6"),aes(x = x, y = y), position = position_nudge(x = 3.2), 
    side = "r", fill = "darkorange", alpha = .5, color = "darkorange", trim = TRUE) +
  
  #Define additional settings
  scale_x_continuous(breaks=c(1,2,3,4,5,6), labels=c("Before", "During", "After", "Before", "During", "After"), limits=c(0, 7)) +
  xlab("Condition") + ylab("Value") +
  ggtitle('Figure 13: Repeated measures with jittered datapoints and connections') +
  theme_classic()+
  coord_cartesian(ylim=c(2.3, 7.2))
f13

# 2 groups 3 conditions half violin
f14 <- ggplot(data=d, aes(y=y)) +
  
  #Add geom_() objects
  geom_point(data = d %>% filter(x=="1"), aes(x=xj), color = 'dodgerblue', size = 1.5,
             alpha = .8) +
  geom_point(data = d %>% filter(x=="2"), aes(x=xj), color = 'darkgreen', size = 1.5,
             alpha = .8) +
  geom_point(data = d %>% filter(x=="3"), aes(x=xj), color = 'darkorange', size = 1.5, 
             alpha = .8) +
  
  #Add geom_() objects
  geom_point(data = d %>% filter(z=="4"), aes(x=xj_2), color = 'dodgerblue', size = 1.5,
             alpha = .8) +
  geom_point(data = d %>% filter(z=="5"), aes(x=xj_2), color = 'darkgreen', size = 1.5,
             alpha = .8) +
  geom_point(data = d %>% filter(z=="6"), aes(x=xj_2), color = 'darkorange', size = 1.5, 
             alpha = .8) +
  
  geom_line(aes(x=xj, group=id), color = 'lightgray', alpha = .3) +
  geom_line(aes(x=xj_2, group=id), color = 'lightgray', alpha = .3) +
  
  geom_half_violin(
    data = d %>% filter(x=="1"),aes(x = x, y = y), position = position_nudge(x = 0), 
    side = "r", fill = 'dodgerblue', alpha = .15, color = "lightgray", trim = TRUE) +
  
  geom_half_violin(
    data = d %>% filter(x=="2"),aes(x = x, y = y), position = position_nudge(x = 0), 
    side = "r", fill = "darkgreen", alpha = .15, color = "lightgray", trim = TRUE) +
  
  geom_half_violin(
    data = d %>% filter(x=="3"),aes(x = x, y = y), position = position_nudge(x = 0), 
    side = "r", fill = "darkorange", alpha = .15, color = "lightgray", trim = TRUE) +
  
  geom_half_violin(
    data = d %>% filter(z=="4"),aes(x = x, y = y), position = position_nudge(x = 3), 
    side = "r", fill = 'dodgerblue', alpha = .15, color = "lightgray", trim = TRUE) +
  
  geom_half_violin(
    data = d %>% filter(z=="5"),aes(x = x, y = y), position = position_nudge(x = 3), 
    side = "r", fill = "darkgreen", alpha = .15, color = "lightgray", trim = TRUE) +
  
  geom_half_violin(
    data = d %>% filter(z=="6"),aes(x = x, y = y), position = position_nudge(x = 3), 
    side = "r", fill = "darkorange", alpha = .15, color = "lightgray", trim = TRUE) +
  
  #Define additional settings
  scale_x_continuous(breaks=c(1,2,3,4,5,6), labels=c("Before", "During", "After", "Before", "During", "After"), limits=c(0, 7)) +
  xlab("Condition") + ylab("Value") +
  ggtitle('Figure 14: Repeated measures with jittered datapoints and connections') +
  theme_classic()+
  coord_cartesian(ylim=c(2.3, 7.2))
f14

## General remarks / tips
'''
- To be more flexible in assigning labels to your figures, the **`ggtext`** package by [Wilke, 2020](https://github.com/wilkelab/ggtext) might be worthwile .
- If you would like to be flexible in plotting multiple figures next to each other, check-out the **`patchwork`** package by [Pedersen, 2020](https://cran.r-project.org/web/packages/patchwork/index.html).
- If you want to save your figures in a high-quality manner (> GB) for e.g., publications, you could save your figure with a `.tiff` extension and add `dpi=` as used in the following line of code:
'''
# High quality saves
ggsave("figure.tiff", height=h, width=w, units='in', dpi=600)
# Use patchwork to stitch images