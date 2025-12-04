*Do file to merge our  data, and analysis
* Run after running TariffTimeseries.do and has created TariffTimeseries_new.dta
*First run this to change directory, where all of the raw data is
cd "C:\Users\kfrocha\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files"
*import ICD-GRD data 
use "UNUWIDERGRD_2023_Central" , clear 
*keep the 11 countries
keep if country == "Australia" | country == "France" | country == "Israel" | country == "Norway" | country == "Switzerland" | country == "United States" | country == "Ireland" | country == "Canada" | country == "New Zealand" | country == "Belgium" | country == "Korea, Republic of"
*keeping years 2001-2020
keep if year >= 2001 & year <= 2020 
*keep relevant variables 
keep country year tax_trade tax_income tax_indirect tax_property tax_gs_general tax_g_s tax_gs_excises tax_other 
*create domestic & international tax variables 
gen DomesticTaxGDP = tax_g_s
label variable DomesticTaxGDP "Domestic Tax Revenue (% GDP)"
gen InternationalTaxGDP = tax_trade
label variable InternationalTaxGDP "International Tax Revenue (% GDP)" 


*make sure names in WITS match 
rename country CountryName 
*fix Korea Overlapping issue 
replace CountryName = "Korea, Rep." if CountryName == "Korea, Republic of" | CountryName == "Korea"
*keep needed variables 
keep CountryName year DomesticTaxGDP InternationalTaxGDP
*save revamped data 
save "UNUWIDERGRD_2023_Central_new.dta", replace 
*summary check 
summarize DomesticTaxGDP InternationalTaxGDP, detail
tab CountryName


*merging
use "TariffTimeseries_new.dta" , clear

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
*Drop the problematic WITS tax variables 
drop DomesticTaxRev InternationalTaxRev TariffPTaxRev
*Label variables 
label variable ExportPGDP "Exports (% GDP)"
label variable GDPCurrent "GDP (Current USD)"
label variable ImportPGDP "Imports (% GDP)"
label variable ImportValue "Import Value"
*percentage variables 
gen ImportGDPRatio = ImportValue/GDPCurrent *100
label variable ImportGDPRatio "Imports(% GDP)"

gen TradeBalance = ImportPGDP - ExportPGDP
label variable TradeBalance "Trade Balance (% GDP)"

*Save with new variables
save "TariffsTimeseries_ICTD.dta", replace

*summary statistics of key variables 
sum DomesticTaxGDP InternationalTaxGDP ImportPGDP ExportPGDP GDPCurrent ImportValue 
* export to Latex 
outreg2 using "Summary_Stats_base.tex" , sum(log) replace tex title("Summary Statistics") label 

*Summary table for importGDP ratio variable by country
preserve
collapse (mean) mean=ImportGDPRatio (sd) sd=ImportGDPRatio (min) min=ImportGDPRatio (max) max=ImportGDPRatio, by(CountryName)
gsort -mean
format mean sd min max %9.2f
list

outreg2 using "ImportGDP_by_country.tex", replace tex label
restore

*Correlations (Individual) 

* Australia
display " "
display "AUSTRALIA:"
pwcorr InternationalTaxGDP DomesticTaxGDP if CountryName == "Australia", sig star(0.05)

* Belgium
display " "
display "BELGIUM:"
pwcorr InternationalTaxGDP DomesticTaxGDP if CountryName == "Belgium", sig star(0.05)

* Canada
display " "
display "CANADA:"
pwcorr InternationalTaxGDP DomesticTaxGDP if CountryName == "Canada", sig star(0.05)

* France
display " "
display "FRANCE:"
pwcorr InternationalTaxGDP DomesticTaxGDP if CountryName == "France", sig star(0.05)

* Ireland
display " "
display "IRELAND:"
pwcorr InternationalTaxGDP DomesticTaxGDP if CountryName == "Ireland", sig star(0.05)

* Israel
display " "
display "ISRAEL:"
pwcorr InternationalTaxGDP DomesticTaxGDP if CountryName == "Israel", sig star(0.05)

* Korea
display " "
display "KOREA:"
pwcorr InternationalTaxGDP DomesticTaxGDP if CountryName == "Korea, Rep.", sig star(0.05)

* New Zealand
display " "
display "NEW ZEALAND:"
pwcorr InternationalTaxGDP DomesticTaxGDP if CountryName == "New Zealand", sig star(0.05)

* Norway
display " "
display "NORWAY:"
pwcorr InternationalTaxGDP DomesticTaxGDP if CountryName == "Norway", sig star(0.05)

* Switzerland
display " "
display "SWITZERLAND:"
pwcorr InternationalTaxGDP DomesticTaxGDP if CountryName == "Switzerland", sig star(0.05)

* United States
display " "
display "UNITED STATES:"
pwcorr InternationalTaxGDP DomesticTaxGDP if CountryName == "United States", sig star(0.05)
*display correlation at once 

foreach country in "Australia" "Belgium" "Canada" "France" "Ireland" "Israel" "Korea, Rep." "New Zealand" "Norway" "Switzerland" "United States" {
    
    display " "
    display "`country':"
    pwcorr InternationalTaxGDP DomesticTaxGDP if CountryName == "`country'", sig star(0.05)
}

*scatter plots 
*High Import Countries (Ireland, Belgium, Switzerland)
scatter TariffGDP DomesticTaxGDP if CountryName == "Ireland", mcolor(orange) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "Belgium", mcolor(blue) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "Switzerland", mcolor(red) msize(small) legend(order(1 "Ireland" 2 "Belgium" 3 "Switzerland") position(3)) ytitle("Tariff Revenue (% GDP)") xtitle("Domestic Tax Revenue (% GDP)") title("High Import-GDP Countries (>40%)")
graph export "high_import_countries.pdf", replace

*medium import countries 
scatter TariffGDP DomesticTaxGDP if CountryName == "Romania", mcolor(maroon) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "Korea, Rep.", mcolor(purple) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "Canada", mcolor(green) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "France", mcolor(navy) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "Norway", mcolor(teal) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "Israel", mcolor(brown) msize(small) legend(order(1 "Romania" 2 "Korea" 3 "Canada" 4 "France" 5 "Norway" 6 "Israel") position(3) cols(2)) ytitle("Tariff Revenue (% GDP)") xtitle("Domestic Tax Revenue (% GDP)") title("Medium Import-GDP Countries (26-40%)")
graph export "medium_import_countries.pdf" , replace 

*high import countries 
scatter TariffGDP DomesticTaxGDP if CountryName == "New Zealand", mcolor(orange) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "Australia", mcolor(green) msize(small) || scatter TariffGDP DomesticTaxGDP if CountryName == "United States", mcolor(navy) msize(small) legend(order(1 "New Zealand" 2 "Australia" 3 "United States") position(3)) ytitle("Tariff Revenue (% GDP)") xtitle("Domestic Tax Revenue (% GDP)") title("Low Import-GDP Countries (<26%)")
graph export "low_import_countries.pdf" , replace 








