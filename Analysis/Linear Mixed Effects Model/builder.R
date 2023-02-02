# after you determine the random effects, you can now use the buildmer function to get the optimal model
ext <- readxl::read_xlsx("/xxxxxx/shapiro.xlsx")
names(ext)[names(ext) == 'pp#'] <- 'pp'

# removed from the correlation and redundancy analysis
ext$cluster <- NULL
ext$rateCount <- NULL
ext$pp <- NULL

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


# formula to evaluate
# only replace the random effects with the results obtained in steps 2 and 4 in helper.ipynb
# f <- loading ~ location+user_activity+website_content+web_history+personally_identifiable_information+authentication_information+personal_communications+size+users+rate+isLogin+isGrant+isInactive+isFullyInactive+(1|base_Generic4)+(1|base_Generic7)+(1+isFullyInactive|base_Apk7)+(1+personally_identifiable_information|base_Ereality8)+(1+users|base_Ereality8)+(1+isGrant|base_Ereality8)+(1+website_content|base_Ereality9)+(1+isFullyInactive|base_GitHub1)+(1+isFullyInactive|base_GitHub3)+(1+isFullyInactive|base_GitHub8)+(1+isFullyInactive|base_GitHub9)+(1+user_activity|base_Jobsalert9)+(1+user_activity|base_Lichess3)+(1+user_activity|base_Tricky0)+(1+isFullyInactive|base_Tricky3)+(1+user_activity|base_Tricky9)+(1+isFullyInactive|base_Video_twitch4)+(1+users|base_Video_youtube6)
f <- time ~ location+user_activity+website_content+web_history+personally_identifiable_information+authentication_information+personal_communications+size+users+rate+isLogin+isGrant+isInactive+isFullyInactive+(1|base_Generic7)+(1|base_Video_youtube1)+(1+isFullyInactive|base_Draftkings8)+(1+isFullyInactive|base_GitHub7)+(1+isFullyInactive|base_Lichess0)+(1+isFullyInactive|base_Lichess9)+(1+isFullyInactive|base_Shadowpay9)+(1+personally_identifiable_information|base_Video_youtube6)+(1+isFullyInactive|base_Video_youtube8)
# f <- static ~ location+user_activity+website_content+web_history+personally_identifiable_information+authentication_information+personal_communications+size+users+rate+isLogin+isGrant+isInactive+isFullyInactive+(1|base_Espn8)+(1|base_Generic5)+(1|base_Generic7)+(1+size|base_Apk7)+(1+size|base_Draftkings5)+(1+size|base_Draftkings8)+(1+website_content|base_Shoppingjp2)

library(buildmer)
system.time(
  best <- buildmer(f,data=ext,buildmerControl=buildmerControl(include = ~location+user_activity+website_content+web_history+personally_identifiable_information+authentication_information+personal_communications+size+users+rate+isLogin+isGrant+isInactive+isFullyInactive, direction='order', calc.anova = TRUE, ddf = "Kenward-Roger", args=list(control=lme4::lmerControl(optimizer='bobyqa'))))
)

# you will see the best formula, like
# Linear mixed model fit by REML ['lmerMod']
# Formula: loading ~ location + user_activity + website_content + web_history +  
#   personally_identifiable_information + authentication_information +  
#   personal_communications + size + users + rate + isLogin +  
#   isGrant + isInactive + isFullyInactive + (1 | base_Generic7) +  
#   (1 | base_Generic4) + (1 | base_Video_youtube6) + (1 | base_Tricky3) +  
#   (1 + user_activity | base_Tricky0) + (1 + user_activity |base_Tricky9) + (1 + user_activity | base_Lichess3)
summary(best)
# use that formula to run
result <- lmer(data=ext, formula=xxxxxxxx, control=lmerControl(optimizer='bobyqa'))
library(car)
Anova(result)