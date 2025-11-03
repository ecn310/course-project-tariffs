*Do file to open our data and summarize it
*First run this to change directory
cd "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files"
* run this command to import the csv data to stata
import delimited "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\WITS-Country-Timeseries-Data.csv", varnames(1)
*to save the data as a dta
save "C:\Users\giova\OneDrive - Syracuse University\Documents\GitHub\course-project-tariffs\Data files\TariffsTimeseries.dta"
*now we use the dta file we just created
use "TariffsTimeseries.dta"
describe
list countryname indicatorname
browse
