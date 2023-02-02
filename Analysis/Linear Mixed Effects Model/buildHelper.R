library(lme4)

con <- file("/xxxxxxxx/ComboLog2.txt")
sink(con, append=TRUE)
sink(con, append=TRUE, type="message")

anova(m105, m147, m155, m161, m182, m202, m208) # replace the outputs obtained from helper.ipynb

sink()
sink(type="message")
cat(readLines("/xxxxxxxx/ComboLog2.txt"), sep="\n")

# run command ``source("/xxxxxxxx/buildHelper.R", echo=TRUE, max.deparse.length=100000)``on your R console
