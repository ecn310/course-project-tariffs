*Stata Version: Stata 18
*Do file to merge our  data, and analysis
* Run after running TariffTimeseries.do and has created TariffTimeseries_new.dta
*open a log file
log using ICTD-GRD.log, replace
*First run this to change directory to your path, where all of the raw data is 
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
label variable DomesticTaxGDP "Domestic Consumption Tax Revenue (% GDP)"
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
use "TariffTimeseries_ICTD.dta" , clear 
*Drop the problematic WITS tax variables 
drop DomesticTaxRev InternationalTaxRev TariffPTaxRev
*Label variables 
label variable ExportPGDP "Exports (% GDP)"
label variable GDPCurrent "GDP (Current USD)"
label variable ImportPGDP "Imports (% GDP)"
label variable ImportValue "Import Value"
*percentage variables 
gen ImportGDPRatio = ImportValue/GDPCurrent *100
label variable ImportGDPRatio "Import-GDP-Ratio"

gen TradeBalance = ImportPGDP - ExportPGDP
label variable TradeBalance "Trade Balance (% GDP)"

gen TariffGDP = InternationalTaxGDP
label variable TariffGDP "Tariff Revenue (% GDP)"

*Save with new variables
save "TariffsTimeseries_ICTD.dta", replace
 
*change GDP and ImportValue to billions 
gen GDPCurrent_Billions = GDPCurrent / 1000000000
label variable GDPCurrent_Billions "GDP(Current USD, Billions)"
gen ImportValue_Billions = ImportValue / 1000000000
label variable ImportValue_Billions "Import Value(Billions USD)"
*drop the old GDP & ImportValue 
drop GDPCurrent ImportValue 
summarize DomesticTaxGDP InternationalTaxGDP ImportPGDP ExportPGDP GDPCurrent_Billions ImportValue_Billions
* export to Latex 
*change directory to outputs folder
cd "C:\Users\kfrocha\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Outputs"
outreg2 using "Summary_Stats_final.tex", sum(log) replace tex title("Summary Statistics") label 
*change it back to data folder
cd "C:\Users\kfrocha\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files"

*Summary table for importGDP ratio variable by country
preserve
collapse (mean) mean=ImportGDPRatio (sd) sd=ImportGDPRatio (min) min=ImportGDPRatio (max) max=ImportGDPRatio, by(CountryName)
gsort -mean
format mean sd min max %9.2f
list

restore

*Correlations (Individual) 
use "TariffsTimeseries_ICTD.dta", clear 
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
*raw scatter of all data points for internationaltaxgdp & DomesticTaxGDP   
twoway (scatter International~P1 DomesticTaxGDP, mcolor(orange) msize(small)) (scatter International~P2 DomesticTaxGDP, mcolor(purple) msize(small)) (scatter International~P3 DomesticTaxGDP, mcolor(teal) msize(small)) (scatter International~P4 DomesticTaxGDP, mcolor(navy) msize(small)) (scatter International~P5 DomesticTaxGDP, mcolor(red) msize(small)) (scatter International~P6 DomesticTaxGDP, mcolor(green) msize(small)) (scatter International~P7 DomesticTaxGDP, mcolor(blue) msize(small)) (scatter International~P8 DomesticTaxGDP, mcolor(maroon) msize(small)) (scatter International~P9 DomesticTaxGDP, mcolor(magenta) msize(small)) (scatter International~P10 DomesticTaxGDP, mcolor(brown) msize(small)) (scatter International~P11 DomesticTaxGDP, mcolor(olive) msize(small)), ytitle("International Tax Revenue (% GDP)") xtitle("Domestic Consumption Tax Revenue (% GDP)") title("International Tax vs Domestic Consumption Tax Revenue: All Countries") legend(order(1 "Australia" 2 "Belgium" 3 "Canada" 4 "France" 5 "Ireland" 6 "Israel" 7 "Korea, Rep." 8 "New Zealand" 9 "Norway" 10 "Switzerland" 11 "United States") size(vsmall) cols(3) position(3)) graphregion(color(white)) bgcolor(white)

*change directory to outputs
cd "C:\Users\kfrocha\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Outputs"
graph export "scatter_raw_tax_relationship_final.pdf", replace
*change directory back to data file
cd "C:\Users\kfrocha\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files"



*graph of correlation vs import intensity 
clear 
input str20 CountryName double correlation double mean_import

"Korea, Rep." 0.769 38.82
"Switzerland" 0.740 53.06
"Israel" 0.432 32.59
"France" 0.268 29.57
"Belgium" 0.261 76.64
"Norway" 0.187 29.38
"Canada" 0.127 32.95
"Ireland" 0.088 84.61
"New Zealand" -0.182 27.76
"Australia" -0.319 21.76
"United States" -0.397 15.14
end
gen country_label = CountryName
replace country_label = "Korea" if CountryName == "Korea, Rep."
scatter correlation mean_import, mcolor(navy%70) msize(large) mlabel(country_label) mlabsize(small) mlabposition(3) mlabcolor(black) ytitle("Correlation (International & Domestic Tax Revenue)") xtitle("Average Import-to-GDP Ratio (%)") title("Import Intensity and Tax Revenue Correlation Patterns") subtitle("Developed Countries, 2001-2020", size(small)) yline(0, lcolor(black) lpattern(dash) lwidth(medium)) legend(off) ylabel(-0.4(0.2)0.8, angle(0) format(%3.1f)) xlabel(10(10)90, format(%2.0f)) graphregion(color(white)) bgcolor(white)

*change the directory to save outputs in a different folder
cd "C:\Users\kfrocha\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files"
graph export "scatter_correlation_import.pdf", replace
*change directory back to data file
cd "C:\Users\kfrocha\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files"

*close log
log close
