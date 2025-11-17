gen ImportGDPRatio = ImportValue/RealGDP *100
gen TradeBalance = ImportPGDP-ExportPGDP
gen DomesticTaxP = DomesticTaxRev/RealGDP *100
gen InternationalTaxP = InternationalTaxRev/RealGDP *100
sum RealGDP, detail
sum ImportValue, detail
sum ImportGDPRatio if CountryName == "Switzerland"
sum ImportGDPRatio if CountryName == "Romania"
sum ImportGDPRatio if CountryName == "Korea, Rep."
sum ImportGDPRatio if CountryName == "France"
sum ImportGDPRatio if CountryName == "Norway"
sum ImportGDPRatio if CountryName == "Israel"
sum ImportGDPRatio if CountryName == "Australia"
sum ImportGDPRatio if CountryName == "United States"
scatter RealGDP ImportValue if CountryName == "United States", mcolor(navy) msymbol(O) ylabel(10e12 "10" 15e12 "15" 20e12 "20", angle(0)) xlabel(1e12 "1.0" 2e12 "2.0" 3e12 "3.0" 4e12 "4.0", angle(0)) ytitle("RealGDPTrillions") xtitle("ImportValueTrillions")

scatter RealGDP ImportValue if CountryName == "Australia", mcolor(green) msymbol(T) msize(small) || scatter RealGDP ImportValue if CountryName == "France", mcolor(purple) msymbol(T) msize(small) || scatter RealGDP ImportValue if CountryName == "Switzerland", mcolor(orange) msymbol(S) msize(small) || scatter RealGDP ImportValue if CountryName == "Korea, Rep.", mcolor(red) msymbol(O) msize(small) legend(order(1 "Australia" 2 "France" 3 "Switzerland" 4 "Korea") position(3)) ylabel(5e11 "500" 1e12 "1000" 1.5e12 "1500" 2e12 "2000" 2.5e12 "2500", angle(0)) xlabel(0 "0" 2.5e11 "250" 5e11 "500" 7.5e11 "750" 1e12 "1000", angle(0)) ytitle("RealGDPBillions") xtitle("ImportValueBillions")

scatter RealGDP ImportValue if CountryName == "Norway", mcolor(maroon) msymbol(D) msize(small) || scatter RealGDP ImportValue if CountryName == "Romania", mcolor(blue) msymbol(D) msize(small) || scatter RealGDP ImportValue if CountryName == "Israel", mcolor(purple) msymbol(S) msize(small) legend(order(1 "Norway" 2 "Romania" 3 "Israel") position(3)) ylabel(1e11 "100" 2e11 "200" 3e11 "300" 4e11 "400" 5e11 "500", angle(0)) xlabel(0 "0" 0.5e11 "50" 1e11 "100" 1.5e11 "150", angle(0)) ytitle("RealGDPBillions") xtitle("ImportValueBillions")
scatter TariffPTaxRev TradeBalance if CountryName == "Switzerland", mcolor(orange) msymbol(S) msize(small) || scatter TariffPTaxRev TradeBalance if CountryName == "Australia", mcolor(green) msymbol(T) msize(small) legend(order(1 "Switzerland" 2 "Australia") position(3)) ytitle("TariffPTaxRev")

scatter TariffPTaxRev TradeBalance if CountryName == "Norway", mcolor(maroon) msymbol(D) msize(small) || scatter TariffPTaxRev TradeBalance if CountryName == "Korea, Rep.", mcolor(red) msymbol(O) msize(small) legend(order(1 "Norway" 2 "Korea") position(3)) ytitle("TariffPTaxRev")

scatter TariffPTaxRev DomesticTaxP if CountryName == "Korea, Rep.", mcolor(red) msymbol(O) msize(small) || scatter TariffPTaxRev DomesticTaxP if CountryName == "Romania", mcolor(blue) msymbol(D) msize(small) || scatter TariffPTaxRev DomesticTaxP if CountryName == "France", mcolor(purple) msymbol(T) msize(small) || scatter TariffPTaxRev DomesticTaxP if CountryName == "Switzerland", mcolor(orange) msymbol(S) msize(small) legend(order(1 "Korea" 2 "Romania" 3 "France" 4 "Switzerland") position(3)) ytitle("TariffPTaxRev")

scatter TariffPTaxRev DomesticTaxP if CountryName == "Romania", mcolor(blue) msymbol(D) msize(small) || scatter TariffPTaxRev DomesticTaxP if CountryName == "France", mcolor(purple) msymbol(T) msize(small) || scatter TariffPTaxRev DomesticTaxP if CountryName == "Switzerland", mcolor(orange) msymbol(S) msize(small) legend(order(1 "Romania" 2 "France" 3 "Switzerland") position(3)) ytitle("TariffPTaxRev")

scatter TariffPTaxRev DomesticTaxP if CountryName == "United States", mcolor(navy) msymbol(O) msize(small) || scatter TariffPTaxRev DomesticTaxP if CountryName == "Norway", mcolor(maroon) msymbol(D) msize(small) || scatter TariffPTaxRev DomesticTaxP if CountryName == "Australia", mcolor(green) msymbol(T) msize(small) || scatter TariffPTaxRev DomesticTaxP if CountryName == "Israel", mcolor(purple) msymbol(S) msize(small) legend(order(1 "United States" 2 "Norway" 3 "Australia" 4 "Israel") position(3)) ytitle("TariffPTaxRev")

scatter TariffPTaxRev InternationalTaxP if CountryName == "Switzerland", mcolor(orange) msymbol(S) msize(small) || scatter TariffPTaxRev InternationalTaxP if CountryName == "Norway", mcolor(maroon) msymbol(D) msize(small) || scatter TariffPTaxRev InternationalTaxP if CountryName == "Australia", mcolor(green) msymbol(T) msize(small) || scatter TariffPTaxRev InternationalTaxP if CountryName == "Korea, Rep.", mcolor(red) msymbol(O) msize(small) || scatter TariffPTaxRev InternationalTaxP if CountryName == "United States", mcolor(navy) msymbol(X) msize(small) legend(order(1 "Switzerland" 2 "Norway" 3 "Australia" 4 "Korea" 5 "United States") position(3)) ytitle("TariffPTaxRev")
