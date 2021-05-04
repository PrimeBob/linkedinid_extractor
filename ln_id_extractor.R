library("dplyr")
library(sqldf)
library("stringr")
library(openxlsx)
library(readxl)
library(writexl)


setwd("~/Desktop/roughworking")


data=read.csv(paste("~/Desktop/roughworking/input.csv",sep=""), header=T,stringsAsFactors = FALSE, fileEncoding = "latin1")



q2=data.frame(strsplit(sqldf('select replace(group_concat(substr(link, charindex("companyIncluded=",link)+16, "&companyTime")
),"%2520","") 
as compiled_lnid from data 
         ')$compiled_lnid,"%2C",fixed=TRUE), stringsAsFactors =FALSE)


colnames(q2)[1]="company"


q3=sqldf('select distinct substr(company, 0, charindex("%3A",company)) as company, substr(company, charindex("%3A",company)+3)  
         as ln_id from q2')


write.csv(q3, "ln_id_output.csv", row.names = FALSE)


