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
*fix Korea Overlapping issue 
replace CountryName = "Korea, Rep." if CountryName == "Korea, Republic of" | CountryName == "Korea"
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



*keep successful merged observations 
keep if _merge == 3
drop _merge
* save merged dataset 
save "TariffTimeseries_ICTD.dta" , replace 

*ANALYSIS 
use "TariffTimeSeries_ICTD.dta" , clear 

*Label variables 
label variable ExportPGDP "Exports (% GDP)"
label variable RealGDP "Real GDP"
label variable ImportPGDP "Imports (% GDP)"
label variable ImportValue "Import Value"
*summary statistics of key variables 
sum TariffGDP DomesticTaxGDP InternationalTaxGDP ImportPGDP ExportPGDP RealGDP ImportValue 
* export to Latex 
outreg2 using "Summary_Stats_base.tex" , sum(log) replace tex title("Summary Statistics") label 
*percentage variables 
gen ImportGDPRatio = ImportValue/RealGDP *100
label variable ImportGDPRatio "Imports(% GDP)"

gen TradeBalance = ImportPGDP - ExportPGDP
label variable TradeBalance "Trade Balance (% GDP)"

*Summary table for importGDP ratio variable by country
preserve
collapse (mean) mean=ImportGDPRatio (sd) sd=ImportGDPRatio (min) min=ImportGDPRatio (max) max=ImportGDPRatio, by(CountryName)
gsort -mean
format mean sd min max %9.2f
list

outreg2 using "ImportGDP_by_country.tex", replace tex label
restore

*Correlations 
* create high/low Import- GDP ratio groups from table 
*High: Switzerland, Romania, Korea, France 
*Low: Norway, Israel, Australia, United States 
