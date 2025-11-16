gen ImportGDPRatio = ImportValue/RealGDP *100
gen TradeBalance = ImportPGDP-ExportPGDP
gen DomesticTaxP = DomesticTaxRev/RealGDP
gen InternationalTaxP = InternationalTaxRev/RealGDP
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
scatter RealGDP ImportValue if CountryName == "United States", ylabel(10e12 "10" 15e12 "15" 20e12 "20", angle(0)) xlabel(1e12 "1.0" 2e12 "2.0" 3e12 "3.0" 4e12 "4.0", angle(0)) ytitle("RealGDPTrillions") xtitle("ImportValueTrillions")
scatter RealGDP ImportValue if CountryName == "Australia" | CountryName == "France" | CountryName == "Switzerland" | CountryName == "Korea, Rep.", ylabel(5e11 "500" 1e12 "1000" 1.5e12 "1500" 2e12 "2000" 2.5e12 "2500", angle(0)) xlabel(0 "0" 2.5e11 "250" 5e11 "500" 7.5e11 "750" 1e12 "1000", angle(0)) ytitle("RealGDPBillions") xtitle("ImportValueBillions")
scatter RealGDP ImportValue if CountryName == "Norway" | CountryName == "Romania" | CountryName == "Israel", ylabel(1e11 "100" 2e11 "200" 3e11 "300" 4e11 "400" 5e11 "500", angle(0)) xlabel(0 "0" 0.5e11 "50" 1e11 "100" 1.5e11 "150", angle(0)) ytitle("RealGDPBillions") xtitle("ImportValueBillions")
scatter TariffPTaxRev TradeBalance if CountryName == "Switzerland" | CountryName == "Australia", ytitle("TariffPTaxRev")
scatter TariffPTaxRev TradeBalance if CountryName == "Norway" | CountryName == "Korea,Rep.", ytitle("TariffPTaxRev")
scatter TariffPTaxRev DomesticTaxP if CountryName == "Korea, Rep." | CountryName == "Romania" | CountryName == "France" | CountryName == "Switzerland", ytitle("TariffPTaxRev")
scatter TariffPTaxRev DomesticTaxP if CountryName == "Romania" | CountryName == "France" | CountryName == "Switzerland", ytitle("TariffPTaxRev")
scatter TariffPTaxRev DomesticTaxP if CountryName == "United States" |CountryName == "Norway" |CountryName == "Australia" | CountryName == "Israel", ytitle("TariffPTaxRev")
scatter TariffPTaxRev InternationalTaxP if CountryName == "Switzerland" | CountryName == "Norway" | CountryName == "Australia"| CountryName == "Korea,Rep." | CountryName == "United States", ytitle("TariffPTaxRev")
