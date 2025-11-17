## Tariffs Reproducibility Package
### Steps Taken to Produce TAriffs Results

#### Accesing the Raw data
1. Go on the [WITS website](https://wits.worldbank.org/):
 The International Trade Indicators interface available on the database was accessed. Upon loading, the Trade Indicators  were accessed individually through the website's integrated "Search For Indicator" search bar. The selected indicators were Exports of goods and services (\% of GDP), Imports of goods and services (\% of GDP), GDP (constant 2010 USD), Taxes on goods and services (current LCU), Taxes on international trade (current LCU), Customs and other import duties (\% of tax revenue) and Imports of Goods and Services (BoP current USD). The Country Timeseries datasets were downloaded as excel files by click the gray download button with an arrow pointing downwards in the top right corner of the online table from the WITS website. The excel files listing the complete WITS indicator observations are recorded for 193 countries across 1988-2022. 
3. Open this [do file](https://github.com/ecn310/course-project-tariffs/blob/main/Do%20files/Tarrifs%20Timeseries.do)
   This do file imports all the excel files and saves them as dta files. Once we have transformed all of them, then we merged all data files using Stata's append command and combined into one dataset.
   After we have a combined databse, we drops all the years not included in 2001-2020 interval; after since we are only interested in a few countries, we use a command to drop all the other countries that are not United States, Australia, France, Israel, Korea, Rep., Norway, Romania, Switzerland.


   Since our data is not in the rightformat we need it to be in, we use some Stata commands to reshape the database.
      
