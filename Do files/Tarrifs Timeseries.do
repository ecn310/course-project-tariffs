*Do file to open our data and summarize it
*First run this to change directory
cd "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files"
* run this command to import the first excel data to stata
import delimited "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\WITS-Country-Timeseries-Data.csv", varnames(1)
*to save the first data as a dta
save "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries.dta"
clear

*import excel file 2
*CHANGE THIS here the command to import
*save as dta
*CHANGE THIS command to save as dta
clear

*import excel file 3
*CHANGE THIS here the command to import
*save as dta
*CHANGE THIS command to save as dta
clear

*import excel file 4
*CHANGE THIS here the command to import
*save as dta
*CHANGE THIS command to save as dta
clear

*import excel file 5
*CHANGE THIS here the command to import
*save as dta
*CHANGE THIS command to save as dta
clear

*import excel file 6
*CHANGE THIS here the command to import
*save as dta
*CHANGE THIS command to save as dta
clear

*import excel file 7
*CHANGE THIS here the command to import
*save as dta
*CHANGE THIS command to save as dta
clear

*now we use the one of the dta files we just created
*use "NAMEofFILE.dta"
*append using pathfile???
*append using pathfile???
*append using pathfile???
*append using pathfile???
*append using pathfile???
*append using pathfile???
*append using pathfile???

*RESHAPE command
*gen new variable= exports - imports

describe
list countryname indicatorname
browse
