*Do file to merge our raw data, and explore it

*First run this to change directory, where all of the raw data is
cd "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files"
*run this command to import the first excel data to stata
import delimited "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\excelfile1.xlsx", varnames(1)
*to save the first data excel file as a dta
save "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries1.dta"
clear

*import excel file 2
import delimited "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\excelfile2.xlsx", varnames(1)
*save as dta
save "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries2.dta"
clear

*import excel file 3
import delimited "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\excelfile3", varnames(1)
*save as dta
save "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries3.dta"
clear

*import excel file 4
import delimited "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\excelfile4", varnames(1)
*save as dta
save "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries4.dta"
clear

*import excel file 5
import delimited "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\excelfile5", varnames(1)
*save as dta
save "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries5.dta"
clear

*import excel file 6
import delimited "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\excelfile6", varnames(1)
*save as dta
save "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries6.dta"
clear

*import excel file 7
import delimited "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\exelfile7", varnames(1)
*save as dta
save "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries7.dta"
clear

*we just finished saving the files as dta so now we can begin merging them
*now we use the one of the dta files we just created
use "TariffsTimeseries1.dta"
append using "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries2.dta"
append using "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries3.dta"
append using "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries4.dta"
append using "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries5.dta"
append using "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries6.dta"
append using "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries7.dta"
*we just finished merging all the excel files into the same dta file.
save "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries.dta"

*now use the file we just created
use "TariffsTimeseries.dta"
*Removing the years not included in 2001-2020
drop C
drop D
drop E
drop F
drop G
drop H
drop I
drop J
drop K
drop L
drop M
drop N
drop O
drop AJ
drop AK

*get rid of the countries we dont need 
keep if CountryName == "United States" | CountryName == "Australia" | CountryName == "France" | CountryName == "Israel" | CountryName == "Korea, Rep." | CountryName == "Norway" | CountryName == "Romania" | CountryName == "Switzerland"

* Remaning letter variables to years (yr)
rename P yr01
rename Q yr02
rename R yr03
rename S yr04
rename T yr05
rename U yr06
rename V yr07
rename W yr08
rename X yr09
rename Y yr010
rename Z yr011
rename AA yr012
rename AB yr013
rename AC yr014
rename AD yr015
rename AE yr016
rename AF yr017
rename AG yr018
rename AH yr019
rename AI yr020

*transforming "year" into a singular variable observing the years 2001-2020
reshape long yr0, i(CountryName IndicatorName) j(year)
rename yr0 value
replace year = year + 2000
reshape wide value i(IndicatorName year) j(CountryName) string
rename value 

*reshaping individual indicators as variables 
encode IndicatorName, gen(IndicatorID)
drop IndicatorName
reshape wide value, i(year CountryName) j(IndicatorID)

*renaming value variables
rename value1 Australia
rename value2 France
rename value3 Israel
rename value4 Korea, Rep.
rename value5 Norway
rename value6 Romania
rename value7 Switzerland
rename value8 USA

describe
browse
scatter RealGDP ImportValue 


