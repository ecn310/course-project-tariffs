## Tariffs Reproducibility Package
### Steps Taken to Produce Tariffs Results

#### Data Sources
1. Go on the [WITS International Trade Indicators website](https://wits.worldbank.org/CountryProfile/en/Country/USA/Year/2023#section3)
2. After accesing The International Trade Indicators interface all the indicators can be viewed individually through the website's integrated "Search For Indicator" search bar.
3. Data files to download: download as excel files by clicking the gray download button with an arrow pointing downwards in the top right corner of the online table from the WITS website.
  - [Customs and other import duties (% of tax revenue)](https://github.com/ecn310/course-project-tariffs/blob/main/Data%20files/TariffPTaxRev.xlsx): measures the percentage of revenue generated from tariffs imposed in Import Duties
   - [Exports of goods and services (% of GDP)](https://github.com/ecn310/course-project-tariffs/blob/main/Data%20files/ExportPGDP.xlsx): measures the percentage of total production of goods and services that is provided to the rest of the world (exports).
  - [GDP (constant 2010 US$)](https://github.com/ecn310/course-project-tariffs/blob/main/Data%20files/RealGDP.xlsx): measures countries GDP in constant 2010 US dollars.
  - [Imports of goods and services (% of GDP)](https://github.com/ecn310/course-project-tariffs/blob/main/Data%20files/ImportPGDP.xlsx): measures the percentage of total production of goods and services that the rest of the world provides (imports) in percentage of GDP. 
  - [Imports of goods and services (BoP, current US$)](https://github.com/ecn310/course-project-tariffs/blob/main/Data%20files/ImportValue.xlsx): measures the Balance of Payments (BOP) reflected in the economic transactions between a country and the rest of the world. It includes the net flow of goods and services, as well as income and expenditures resulting from international transactions
- [Taxes on goods and services (current LCU)](https://github.com/ecn310/course-project-tariffs/blob/main/Data%20files/DomesticTaxRev.xlsx): measures the total amount of taxes paid by individuals, businesses, and other entities on the purchase and consumption of goods and services within a country. LCU means it's in the local currency of the Country. 
- [Taxes on international trade (current LCU)](https://github.com/ecn310/course-project-tariffs/blob/main/Data%20files/InternationalTaxRev.xlsx): measures the taxes imposed on international trade transactions expresed in the local currency.
- [GDP (Current USD)](https://github.com/ecn310/course-project-tariffs/blob/main/Data%20files/GDP(Current%20USD).xlsx): measures the total monetary value of all finished goods and services produced within a country over a specific period of time.
- [ICTD-GRD](https://github.com/ecn310/course-project-tariffs/blob/main/Data%20files/UNUWIDERGRD_2023_Central.dta): 
4. Data Coverage: 193 countries from 2001-2020
5. Go to [ICTD-GRD UNU WIDER Government Revenue Dataset](https://www2.wider.unu.edu/content/grd-data-download) website, create an account, then choose to download the Stata file [**UNUWIDERGRD 2023 Central Government.dta_.zip (2.44 MB)**](https://github.com/ecn310/course-project-tariffs/blob/main/Data%20files/UNUWIDERGRD_2023_Central.dta) 

 #### Working with the Data  
1. Clone or download this repository to your personal computer. All of our files are in GitHub.
2. Stata version used: Stata 18.0
3. Open this [do file](https://github.com/ecn310/course-project-tariffs/blob/main/Do%20files/Tarrifs%20Timeseries.do)
4. Before running any code, the file paths need to be changed specifically for your computer.
   - Locate the cd command at the top of the do file and change it to match your local repository.
     cd "change.this.link.to.your.own.path"
   - Run the do file in order (Cr+D or click execute)
   - The purpose of this first do file is to import all WITS Excel files (DomesticTaxRev.xlsx, ExportPGDP.xlsx, GDP(Current USD).xlsx, ImportPGDP.xlsx, ImportValue.xlsx, InternationalTaxRev.xlsx, RealGDP.xlsx, TariffPTaxRev.xlsx), merges them into a single dataset, filter for years 2001-2020 and the countries of interest (United States, Australia, France, Israel, Korea (Rep.), Norway, Romania, and Switzerland), reshapes the data and saves it as [TariffTimeseries_new.dta](https://github.com/ecn310/course-project-tariffs/blob/main/Data%20files/TariffsTimeseries.dta).
   - It should produce something that looks like this [log](https://github.com/ecn310/course-project-tariffs/blob/main/Do%20files/TariffsTimeserieslog.smcl)
5.  Open this [do file](https://github.com/ecn310/course-project-tariffs/blob/main/Do%20files/ICTD-GRD%20data%20do%20file.do)
   - Locate the cd command at the top of the do file and change it to match your local repository.
   - the purpose of this do file is to merge the prepared WITS dataset with ICTD-GRD data, filtering for 11 countries (Australia, Belgium, Canada, France, Ireland, Israel, Korea Rep., New Zealand, Norway, Switzerland, United States) during the same years (2001-2020)
   - Generates Summary Statistics and exports it to LaTeX, [summary statistics](https://github.com/ecn310/course-project-tariffs/blob/main/Outputs/Import_GDP_by_Country.tex)
   - Calculates country by country correlations between interntional and domestic tax.
   - Produces three scatter plots showing the relationship between tariff revenue and domestic tax revenue.
      - [Hight Import countries (>40%)](https://github.com/ecn310/course-project-tariffs/blob/main/Outputs/high_import_countries.pdf)
      - [Medium Import countries (26-40%)](https://github.com/ecn310/course-project-tariffs/blob/main/Outputs/medium_import_countries.pdf)
      - [Low Import countries (<26%)](https://github.com/ecn310/course-project-tariffs/blob/main/Outputs/low_import_countries.pdf)
  - This do file's [log](https://github.com/ecn310/course-project-tariffs/blob/main/Do%20files/ICTD_GRD_log.smcl).

### Repository Structure
- Data files: contains the following
  - All the raw excel files downloaded from the WITS
  - All the intermediate dta files produced from the excel files
  - The combined WITS dataset
  - The ICTD-GRD raw dta file
  - The processed final dataset with both the WITS and ICTD-GRD data
  - Summary stats base.tex
  - Summary stats base.txt
- Do files contains the following:
  - TarrifsTimeseries.do
  - TarrifsTimeseries log of do file
  - ICTD-GRD data do file
  - ICTD-GRD log
- Outputs
  - Import GDP by Country
  - Hight import Countries scatter plots
  - Medium import Countries scatter plots
  - Low import Countries scatter plots
- Report
  - README.md - REPRODUCIBILITY PACKAGE
  - data.tex
  - project template.tex
  - tarrifs report.tex
- README.md - Master Documentation File



  


