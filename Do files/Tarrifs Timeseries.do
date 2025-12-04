*Do file to merge our raw data, and explore it
* Install outreg2 
ssc install outreg2
*First run this to change directory, where all of the raw data is
cd "C:\Users\kfrocha\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files"  

*run this command to import the first excel data to stata
import excel "TariffPTaxRev.xlsx", sheet("Country-Timeseries") firstrow clear
*to save the first data excel file as a dta
save "TariffsTimeseries1.dta",replace
clear

*import excel file 2
import excel "ExportPGDP.xlsx", sheet("Country-Timeseries") firstrow clear
save "TariffsTimeseries2.dta",replace
clear

*import excel file 3
import excel "ImportPGDP.xlsx", sheet("Country-Timeseries") firstrow clear
*save as dta
save "TariffsTimeseries3.dta",replace
clear

*import excel file 4
import excel "ImportValue.xlsx", sheet("Country-Timeseries") firstrow clear
*save as dta
save "TariffsTimeseries4.dta",replace
clear

*import excel file 5
import excel "DomesticTaxRev.xlsx", sheet("Country-Timeseries") firstrow clear
*save as dta
save "TariffsTimeseries5.dta",replace
clear

*import excel file 6
import excel "InternationalTaxRev.xlsx", sheet("Country-Timeseries") firstrow clear
*save as dta
save "TariffsTimeseries6.dta",replace
clear
*import excel file 7
import excel "GDP(Current USD).xlsx" , sheet("Country-Timeseries") firstrow clear
*save as dta 
save "TariffsTimeseries7.dta",replace

*we just finished saving the files as dta so now we can begin merging them
*now we use the one of the dta files we just created
use "TariffsTimeseries1.dta"
append using "TariffsTimeseries2.dta"
append using "TariffsTimeseries3.dta"
append using "TariffsTimeseries4.dta"
append using "TariffsTimeseries5.dta"
append using "TariffsTimeseries6.dta"
append using "TariffsTimeseries7.dta"

*we just finished merging all the excel files into the same dta file.
save "TariffsTimeseries.dta", replace

*now use the file we just created
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
keep if CountryName == "United States" | CountryName == "Australia" | CountryName == "France" | CountryName == "Israel" | CountryName == "Korea, Rep." | CountryName == "Norway" | CountryName == "Switzerland" | CountryName =="Ireland" | CountryName == "Canada" | CountryName == "New Zealand" | CountryName == "Belgium"

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
rename value3 GDPCurrent
rename value4 ImportPGDP
rename value5 ImportValue
rename value6 DomesticTaxRev
rename value7 InternationalTaxRev

*save new changes (needed for merging)
save "TariffTimeseries_new.dta", replace 




