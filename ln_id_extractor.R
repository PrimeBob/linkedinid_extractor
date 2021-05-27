library("dplyr")
library(sqldf)
library("stringr")
library(openxlsx)
library(readxl)
library(writexl)


setwd("~/Desktop/roughworking")


data = read.csv(
  paste("~/Desktop/roughworking/input.csv", sep = ""),
  header = T,
  stringsAsFactors = FALSE,
  fileEncoding = "latin1"
)




#i swear someone out there has wrote a package for this but I just cant find it to save my life
#anyways
#translating the url code into puncuations
#concatentating the company/id url parses 
q2 = data.frame(strsplit(
  sqldf(
    'select

replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
group_concat(substring(link, charindex("companyIncluded=",link)+16, charindex("&companyTime", link)-62),"%2C")
,"%2520"," ")
,"%2525","%")
,"%255C","\")
,"%257C","|")
,"%2526","&")
,"%253A","/")
,"%2523","#")
,"%252C",",")

as compiled_lnid from data
         '
  )$compiled_lnid,
  "%2C",
  fixed = TRUE), stringsAsFactors = FALSE)






colnames(q2)[1] = "company"

#seperating the company parse into name and id
q3 = sqldf(
  'select distinct substr(company, 0, charindex("%3A",company)) as company, substr(company, charindex("%3A",company)+3)
         as ln_id from q2'
)


write.csv(q3, "ln_id_output.csv", row.names = FALSE)




