library(Hmisc)
library(dplyr)
library(nlme)                    # Fit Gaussian linear and nonlinear mixed-effects models
library(lme4)                    # Fit linear and generalized linear mixed-effects models
library(lattice)                 # Data visualization system
library(optimx)
library(car)

ext <- readxl::read_xlsx("/xxxxxxxx/shapiro.xlsx")

ext <- transform(ext, size = (size - min(size)) / (max(size) - min(size)))
ext <- transform(ext, users = (users - min(users)) / (max(users) - min(users)))
ext <- transform(ext, rate = (rate - min(rate)) / (max(rate) - min(rate)))

f_all <- select(ext, -contains("base_"))
f_all$time <- NULL
f_all$loading <- NULL
f_all$static <- NULL

names(f_all)[names(f_all) == 'pp'] <- '# of pravicy practies'
names(f_all)[names(f_all) == 'login'] <- 'isLogin'
names(f_all)[names(f_all) == 'grant'] <- 'isGrant'
names(f_all)[names(f_all) == 'inactive'] <- 'isInactive'
names(f_all)[names(f_all) == 'fullInactive'] <- 'isFullyInactive'
names(f_all)[names(f_all) == 'size'] <- 'entension size'
names(f_all)[names(f_all) == 'users'] <- '# of users'
names(f_all)[names(f_all) == 'rate'] <- 'rating score'
names(f_all)[names(f_all) == 'rateCount'] <- '# of raters'

f_all <- f_all[!duplicated(f_all), ]
f_all <- f_all[vapply(f_all, function(x) length(unique(x)) > 1, logical(1L))]

# Spearman Correlation Test
M_all <- varclus(as.matrix(f_all),similarity="spearman")
plot(M_all)
abline(h = 0.3, col = "darkred", lwd = 2, lty = 3)

# Redundancy Test
# removed from the correlation analysis
f_all$cluster <- NULL
f_all$rateCount <- NULL

red <- redun(~.,data=f_all, r2=0.9,nk=0)
print(red)