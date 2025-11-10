*Do file to merge our raw data, and explore it

*First run this to change directory, where all of the raw data is
cd "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files"
*run this command to import the first excel data to stata
import excel "excelfile1.xlsx", sheet("Country-Timeseries") firstrow clear
*to save the first data excel file as a dta
save "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries1.dta"
clear

*import excel file 2
import excel "excelfile2.xlsx", sheet("Country-Timeseries") firstrow clear
save "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries2.dta"
clear

*import excel file 3
import excel "excelfile3.xlsx", sheet("Country-Timeseries") firstrow clear
*save as dta
save "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries3.dta"
clear

*import excel file 4
import excel "excelfile4.xlsx", sheet("Country-Timeseries") firstrow clear
*save as dta
save "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries4.dta"
clear

*import excel file 5
import excel "excelfile5.xlsx", sheet("Country-Timeseries") firstrow clear
*save as dta
save "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries5.dta"
clear

*import excel file 6
import excel "excelfile6.xlsx", sheet("Country-Timeseries") firstrow clear
*save as dta
save "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries6.dta"
clear

*import excel file 7
import excel "excelfile7.xlsx", sheet("Country-Timeseries") firstrow clear
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

*reshaping individual indicators as variables 
encode IndicatorName, gen(IndicatorID)
drop IndicatorName
reshape wide value, i(year CountryName) j(IndicatorID)

*renaming value variables
rename value1 TariffPTaxRev
rename value2 ExportPGDP
rename value3 RealGDP
rename value4 ImportPGDP
rename value5 ImportValue
rename value6 DomesticTaxRev
rename value7 InternationalTaxRev

describe
browse
scatter RealGDP ImportValue 


