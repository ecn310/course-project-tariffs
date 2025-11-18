*Do file to merge our  data, and analysis
* Run after running TariffTimeseries.do 
*First run this to change directory, where all of the raw data is
cd "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files"
*import ICD-GRD data 
use "UNUWIDERGRD_2023_Central" , clear 
*keep the 8 countries
keep if inlist(country, "Australia" , "France" , "Israel" , "Norway" , "Romania" , "Switzerland" , "United States") | inlist(country, "Korea, Republic of") 
*keeping years 2001-2020
keep if year >= 2001 & year <= 2020 
* keep relevant variables 
keep country year tax_trade tax_income tax_indirect tax_property tax_gs_general tax_gs_excises tax_other 
*create domestic & international tax variables 
gen DomesticTaxGDP = tax_income + tax_indirect
label variable DomesticTaxGDP "Domestic Tax Revenue (% GDP)"
gen InternationalTaxGDP = tax_trade
label variable InternationalTaxGDP "International Tax Revenue (% GDP)" 

*tariff variable 
gen TariffGDP = tax_trade
label variable TariffGDP "Tariff Revenue(% of GDP)"
*make sure names in WITS match 
rename country CountryName 
*keep needed variables 
keep CountryName year DomesticTaxGDP InternationalTaxGDP TariffGDP
*save revamped data 
save "UNUWIDERGRD_2023_Central_new.dta", replace 

*merging
use "TariffTimeseries_new.dta" , clear
*drop problematic variables 
drop InternationalTaxRev DomesticTaxRev TariffPTaxRev 

*merge with ICTD tax data 
merge 1:1 CountryName year using "UNUWIDERGRD_2023_Central_new.dta"
* verify merged results 
tab _merge
list CountryName year _merge if _merge != 3 

*fix Korea Overlapping issue 
replace CountryName = "Korea, Rep." if CountryName == "Korea, Republic of"

*keep successful merged observations 
keep if _merge == 3
drop _merge
* save merged dataset 
save "TariffTimeseries_ICTD.dta" , replace 

*ANALYSIS 
use "TariffTimeSeries_ICTD.dta" , clear 
*percentage variables 
gen ImportGDPRatio = ImportValue/RealGDP *100
label variable ImportGDPRatio "Imports(% GDP)"

gen TradeBalance = ImportPGDP - ExportPGDP
label variable TradeBalance "Trade Balance (% GDP)"