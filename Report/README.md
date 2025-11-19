## Tariffs Reproducibility Package
### Steps Taken to Produce TAriffs Results

#### Accesing the Raw data
1. Go on the [WITS website]([https://wits.worldbank.org/](https://wits.worldbank.org/CountryProfile/en/Country/USA/Year/2023#section3)):
   All the trade indicators for the United States will be generated on the page. The Indicators selected are  Customs and other import duties (% of tax revenue),Exports as a percent of GDP, Gross Domestic Product at constant 2010 prices,  Imports as a percent of GDP,  Imports of Goods and Services (BoP current USD), Taxes on goods and services (current LCU), and Taxes on international trade (current LCU). The Country Timeseries datasets were downloaded as excel files by clicking the gray download button with an arrow pointing downwards in the top right corner of the online table from the WITS website. The excel files listing the complete WITS indicator observations are recorded for 193 countries across 1988-2022.
2. Go to [ICTD-GRD UNU WIDER](https://www.wider.unu.edu/about/government-revenue-dataset-grd) website, then press data download, create an account, then choose to download the Stata file** UNUWIDERGRD 2023 Central Government.dta_.zip (2.44 MB)**
3. Open this [do file](https://github.com/ecn310/course-project-tariffs/blob/main/Do%20files/Tarrifs%20Timeseries.do)
   This do file imports all the excel files and saves them as dta files. Once we have transformed all of them, then we merged all data files using Stata's append command and combined into one dataset.
   After we have a combined databse, we drops all the years not included in 2001-2020 interval; after since we are only interested in a few countries, we use a command to drop all the other countries that are not United States, Australia, France, Israel, Korea, Rep., Norway, Romania, Switzerland.


   Since our data is not in the rightformat we need it to be in, we use some Stata commands to reshape the database.
      
4. Open this [do file](https://github.com/ecn310/course-project-tariffs/blob/main/Do%20files/ICTD-GRD%20data%20do%20file.do) to merge the data that we got from ICTD-GRD
      
