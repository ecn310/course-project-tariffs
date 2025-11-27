*Do file to merge our  data, and analysis
* Run after running TariffTimeseries.do and has created TariffTimeseries_new.dta
*First run this to change directory, where all of the raw data is
cd "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files"
*import ICD-GRD data 
use "UNUWIDERGRD_2023_Central" , clear 
*keep the 12 countries
keep if country == "Australia" | country == "France" | country == "Israel" | country == "Norway" | country == "Romania" | country == "Switzerland" | country == "United States" | country == "Ireland" | country == "Canada" | country == "New Zealand" | country == "Belgium" | country == "Korea, Republic of"
*keeping years 2001-2020
keep if year >= 2001 & year <= 2020 
*keep relevant variables 
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

* calculate country average import ratios 
egen country_avg_import = mean(ImportGDPRatio), by(CountryName)

*determine cutoff
*high >40% (Ireland, Belgium, Switzerland)
*medium >26% (Romania, Korea,Canada, France, Norway, Israel)
*low <26%(New Zealand, Australia, United States)
gen import_group = 1 if country_avg_import < 26
replace import_group = 2 if country_avg_import >= 26 & country_avg_import < 40
replace import_group = 3 if country_avg_import >= 40

capture label drop group_lbl 
label define group_lbl 1 "Low Import-GDP" 2 "Medium Import-GDP" 3 "High Import-GDP"
label values import_group group_lbl 

*Display by group 
display " "
display "======="
display "High Import-GDP Countries"
display "(Ireland, Belgium, Switzerland)"
display "======="
pwcorr TariffGDP DomesticTaxGDP if inlist(CountryName, "Ireland", "Belgium", "Switzerland"), sig star(0.05)

display " "
display "======="
display "Medium Import-GDP Countries"
display "(Romania, Korea, Rep. , Canada, France, Norway, Israel)"
display "======= "
pwcorr TariffGDP DomesticTaxGDP if inlist(CountryName, "Romania", "Korea, Rep.", "Canada", "France", "Norway" , "Israel"), sig star(0.05)

display " "
display "======="
display "Low Import-GDP Countries"
display "(New Zealand, Australia, United States)"
display "======="
pwcorr TariffGDP DomesticTaxGDP if inlist(CountryName, "New Zealand", "Australia", "United States"), sig star(0.05)


*scatter plots 
* High Import-GDP countries (Switzerland, Romania, Korea, France)
scatter TariffGDP DomesticTaxGDP if CountryName == "Switzerland", mcolor(orange) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "Romania", mcolor(blue) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "Korea, Rep.", mcolor(red) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "France", mcolor(purple) msize(small) legend(order(1 "Switzerland" 2 "Romania" 3 "Korea" 4 "France") position(3)) ytitle("Tariff Revenue (% GDP)") xtitle("Domestic Tax Revenue (% GDP)") title("High Import-GDP Countries")
graph export "fig1_high_import.pdf", replace

* Low Import-GDP countries (Norway, Israel, Australia, United States)
scatter TariffGDP DomesticTaxGDP if CountryName == "Norway", mcolor(maroon) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "Israel", mcolor(purple) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "Australia", mcolor(green) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "United States", mcolor(navy) msize(small) legend(order(1 "Norway" 2 "Israel" 3 "Australia" 4 "United States") position(3)) ytitle("Tariff Revenue (% GDP)") xtitle("Domestic Tax Revenue (% GDP)") title("Low Import-GDP Countries")
graph export "fig2_low_import.pdf", replace