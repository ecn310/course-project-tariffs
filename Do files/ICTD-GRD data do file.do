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
* correlation between tariffs and domestic taxes 
pwcorr TariffGDP DomesticTaxGDP ImportGDPRatio, sig star(0.05)

* create high/low Import- GDP ratio groups from table 
*High: Switzerland, Romania, Korea, France (mean > 31%)
*Low: Norway, Israel, Australia, United States (mean < 31%)
gen high_import = 0 
replace high_import = 1 if inlist(CountryName, "Switzerland" , "Romania" , "Korea, Rep" , "France")
label define import_lbl 0 "Low Import/GDP" 1 "High Import/GDP"
label values high_import import_lbl
* high import countries 
display " "
display "=========================================="
display "HIGH IMPORT-GDP COUNTRIES"
display "(Switzerland, Romania, Korea, France)"
display "=========================================="
pwcorr TariffGDP DomesticTaxGDP if high_import == 1, sig star(0.05)

*low import countries 
display " "
display "=========================================="
display "LOW IMPORT-GDP COUNTRIES"
display "(Norway, Israel, Australia, United States)"
display "=========================================="
pwcorr TariffGDP DomesticTaxGDP if high_import == 0, sig star(0.05)

*scatter plots 
* High Import-GDP countries (Switzerland, Romania, Korea, France)
scatter TariffGDP DomesticTaxGDP if CountryName == "Switzerland", mcolor(orange) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "Romania", mcolor(blue) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "Korea, Rep.", mcolor(red) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "France", mcolor(purple) msize(small) legend(order(1 "Switzerland" 2 "Romania" 3 "Korea" 4 "France") position(3)) ytitle("Tariff Revenue (% GDP)") xtitle("Domestic Tax Revenue (% GDP)") title("High Import-GDP Countries")
graph export "fig1_high_import.pdf", replace

* Low Import-GDP countries (Norway, Israel, Australia, United States)
scatter TariffGDP DomesticTaxGDP if CountryName == "Norway", mcolor(maroon) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "Israel", mcolor(purple) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "Australia", mcolor(green) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "United States", mcolor(navy) msize(small) legend(order(1 "Norway" 2 "Israel" 3 "Australia" 4 "United States") position(3)) ytitle("Tariff Revenue (% GDP)") xtitle("Domestic Tax Revenue (% GDP)") title("Low Import-GDP Countries")
graph export "fig2_low_import.pdf", replace