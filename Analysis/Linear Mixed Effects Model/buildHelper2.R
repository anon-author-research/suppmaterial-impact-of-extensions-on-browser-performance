library(Hmisc)
library(dplyr)
library(nlme)                    # Fit Gaussian linear and nonlinear mixed-effects models
library(lme4)                    # Fit linear and generalized linear mixed-effects models
library(lattice)                 # Data visualization system
library(optimx)

Sys.setenv('R_MAX_VSIZE'=32000000000)
ext <- readxl::read_xlsx("/xxxxxx/shapiro.xlsx")
names(ext)[names(ext) == 'pp#'] <- 'pp'

names(ext)[names(ext) == "user activity"] <-"user_activity"
names(ext)[names(ext) == "website content"] <-"website_content"
names(ext)[names(ext) == 'category_Developer Tools'] <- 'category_Developer_Tools'
names(ext)[names(ext) ==  "web history"] <- "web_history"
names(ext)[names(ext) == "personally identifiable information"] <-"personally_identifiable_information"
names(ext)[names(ext) == "authentication information"] <-"authentication_information"
names(ext)[names(ext) == "personal communications"] <-"personal_communications"

names(ext)[names(ext) == "category_Developer Tools"] <-"category_Developer_Tools"
names(ext)[names(ext) == "category_News & Weather"] <-"category_News_Weather"
names(ext)[names(ext) == "category_Search Tools"] <-"category_Search_Tools"
names(ext)[names(ext) == "category_Social & Communication"] <-"category_Social_Communication"

names(ext)[names(ext) == 'login'] <- 'isLogin'
names(ext)[names(ext) == 'grant'] <- 'isGrant'
names(ext)[names(ext) == 'inactive'] <- 'isInactive'
names(ext)[names(ext) == 'fullInactive'] <- 'isFullyInactive'

ext <- transform(ext, size = (size - min(size)) / (max(size) - min(size)))
ext <- transform(ext, users = (users - min(users)) / (max(users) - min(users)))
ext <- transform(ext, rate = (rate - min(rate)) / (max(rate) - min(rate)))

con <- file("/xxxxxxxx/ComboLog.txt")
sink(con, append=TRUE)
sink(con, append=TRUE, type="message")

# -> replace text below from m0 to m10 with the output from helper.ipynb
m0=lmer(data=ext, formula=static~1+(1 + location|base_Apk0), control=lmerControl(optimizer='bobyqa'))
m1=lmer(data=ext, formula=static~1+(1 + user_activity|base_Apk0), control=lmerControl(optimizer='bobyqa'))
m2=lmer(data=ext, formula=static~1+(1 + website_content|base_Apk0), control=lmerControl(optimizer='bobyqa'))
m3=lmer(data=ext, formula=static~1+(1 + web_history|base_Apk0), control=lmerControl(optimizer='bobyqa'))
m4=lmer(data=ext, formula=static~1+(1 + personally_identifiable_information|base_Apk0), control=lmerControl(optimizer='bobyqa'))
m5=lmer(data=ext, formula=static~1+(1 + authentication_information|base_Apk0), control=lmerControl(optimizer='bobyqa'))
m6=lmer(data=ext, formula=static~1+(1 + personal_communications|base_Apk0), control=lmerControl(optimizer='bobyqa'))
m7=lmer(data=ext, formula=static~1+(1 + size|base_Apk0), control=lmerControl(optimizer='bobyqa'))
m8=lmer(data=ext, formula=static~1+(1 + users|base_Apk0), control=lmerControl(optimizer='bobyqa'))
m9=lmer(data=ext, formula=static~1+(1 + rate|base_Apk0), control=lmerControl(optimizer='bobyqa'))
m10=lmer(data=ext, formula=static~1+(1 + isLogin|base_Apk0), control=lmerControl(optimizer='bobyqa'))
#<-

anova(m1)
sink()
sink(type="message")
cat(readLines("/xxxxxxxx/ComboLog.txt"), sep="\n")
# run the command ``source("/xxxxxxxx/builderHelper2.R", echo=TRUE, max.deparse.length=100000)``
# to get the output used for steps 1 and 3 in helper.ipynb