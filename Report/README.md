## Tariffs Reproducibility Package
### Steps Taken to Produce TAriffs Results

#### Accesing the Raw data
1. Go on the [WITS website](https://wits.worldbank.org/CountryProfile/en/Country/USA/Year/2023#section3): After accesing The International Trade Indicators interface all the indicators can be viewed individually through the website's integrated "Search For Indicator" search bar. The Indicators selected are  Customs and other import duties (% of tax revenue),Exports as a percent of GDP, Gross Domestic Product at constant 2010 prices,  Imports as a percent of GDP,  Imports of Goods and Services (BoP current USD), Taxes on goods and services (current LCU), and Taxes on international trade (current LCU). The Country Timeseries datasets were downloaded as excel files by clicking the gray download button with an arrow pointing downwards in the top right corner of the online table from the WITS website. The excel files listing the complete WITS indicator observations are recorded for 193 countries across 1988-2022.
2. Go to [ICTD-GRD UNU WIDER](https://www.wider.unu.edu/about/government-revenue-dataset-grd) website, then press data download, create an account, then choose to download the Stata file** UNUWIDERGRD 2023 Central Government.dta_.zip (2.44 MB)**
3. Open this [do file](https://github.com/ecn310/course-project-tariffs/blob/main/Do%20files/Tarrifs%20Timeseries.do)
   This do-file imports all the Excel files, converts them into Stata (.dta) format, and then merges them into a single dataset using Stata’s append command. After constructing the combined database, it filters the observations to keep only the years 2001–2020 and retains only the countries relevant to our analysis: the United States, Australia, France, Israel, Korea (Rep.), Norway, Romania, and Switzerland.
   Because the data are not initially structured in the format required for analysis, the code reshapes the dataset by renaming the year variables to more meaningful labels and converting the year information into a single variable covering 2001–2020. It then restructures the different indicators into separate variables, renames them for clarity, and finally saves the cleaned and reshaped dataset.
      
5. Open this [do file](https://github.com/ecn310/course-project-tariffs/blob/main/Do%20files/ICTD-GRD%20data%20do%20file.do) to merge the data that we got from ICTD-GRD. First, it standarizes country names to ensure consistency with WITS and saves the cleaned data set. he code then loads a prepared tariff time series dataset, removes overlapping variables, and merges it with the cleaned GRD tax data by country and year, retaining only successfully matched observations. After saving the merged dataset, the code performs descriptive analysis by labeling variables, generating [summary statistics](https://github.com/ecn310/course-project-tariffs/blob/main/Outputs/Summary_Stats_base.tex), and exporting them to LaTeX. Additional variables such as the [import-to-GDP ratio](https://github.com/ecn310/course-project-tariffs/blob/main/Outputs/Import_GDP_by_Country.tex) and trade balance are created, and country-level summary tables for import dependence are produced. The code also computes correlations between tariff revenue and domestic tax revenue overall and within high- and low-import/GDP country groups. Finally, it generates scatter plots visualizing these relationships for both groups and exports the figures as PDF files ([here](https://github.com/ecn310/course-project-tariffs/blob/main/Outputs/fig1_high_import.pdf) and [here](https://github.com/ecn310/course-project-tariffs/blob/main/Outputs/fig2_low_import.pdf)).

6. Codebook of all the variables:
--------------------------------------------------------------------------------
ExportPGDP                                                       Exports (% GDP)
--------------------------------------------------------------------------------

                  Type: Numeric (double)

                 Range: [9.0356587,72.068214]         Units: 1.000e-09
         Unique values: 160                       Missing .: 0/160

                  Mean: 33.6849
             Std. dev.: 14.7614

           Percentiles:     10%       25%       50%       75%       90%
                        13.0035   24.0107   31.8198   41.3183   53.9741
--------------------------------------------------------------------------------
RealGDP                                                                 Real GDP
--------------------------------------------------------------------------------

                  Type: Numeric (double)

                 Range: [1.079e+11,1.993e+13]         Units: 100
         Unique values: 160                       Missing .: 0/160

                  Mean: 2.9e+12
             Std. dev.: 5.4e+12

           Percentiles:     10%       25%       50%       75%       90%
                        1.8e+11   3.3e+11   7.9e+11   1.9e+12   1.5e+13

--------------------------------------------------------------------------------
ImportPGDP                                                       Imports (% GDP)
--------------------------------------------------------------------------------

                  Type: Numeric (double)

                 Range: [13.154993,61.625495]         Units: 1.000e-08
         Unique values: 160                       Missing .: 0/160

                  Mean: 32.1837
             Std. dev.: 11.6049

           Percentiles:     10%       25%       50%       75%       90%
                        16.5001   22.9704   30.4675   39.2376   50.5001

--------------------------------------------------------------------------------
ImportValue                                                         Import Value
--------------------------------------------------------------------------------

                  Type: Numeric (double)

                 Range: [1.616e+10,3.121e+12]         Units: 100
         Unique values: 160                       Missing .: 0/160

                  Mean: 5.5e+11
             Std. dev.: 7.7e+11

           Percentiles:     10%       25%       50%       75%       90%
                        6.3e+10   9.5e+10   2.5e+11   6.2e+11   1.9e+12
--------------------------------------------------------------------------------
DomesticTaxGDP                                      Domestic Tax Revenue (% GDP)
--------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [7.7611651,28.362261]         Units: 1.000e-07
         Unique values: 160                       Missing .: 0/160

                  Mean: 16.7649
             Std. dev.: 5.82276

           Percentiles:     10%       25%       50%       75%       90%
                        9.45138   11.7398   15.2362   22.0655   24.9981
--------------------------------------------------------------------------------
InternationalTaxGDP                            International Tax Revenue (% GDP)
--------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [-.01298281,.97928578]        Units: 1.000e-11
         Unique values: 160                       Missing .: 0/160

                  Mean: .288872
             Std. dev.: .275852

           Percentiles:     10%       25%       50%       75%       90%
                        .000235   .096186   .198458   .485141   .765218
---------------------------------------------------------------------------------
TariffGDP                                                Tariff Revenue(% of GDP)
---------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [-.01298281,.97928578]        Units: 1.000e-11
         Unique values: 160                       Missing .: 0/160

                  Mean: .288872
             Std. dev.: .275852

           Percentiles:     10%       25%       50%       75%       90%
                        .000235   .096186   .198458   .485141   .765218
---------------------------------------------------------------------------------
ImportGDPRatio                                                     Imports(% GDP)
---------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [8.9189663,65.41481]          Units: 1.000e-07
         Unique values: 160                       Missing .: 0/160

                  Mean: 30.8371
             Std. dev.:  12.911

           Percentiles:     10%       25%       50%       75%       90%
                         14.905   20.3151   30.6434   37.6481   49.4526
---------------------------------------------------------------------------------
TradeBalance                                                Trade Balance (% GDP)
---------------------------------------------------------------------------------

                  Type: Numeric (float)

                 Range: [-17.650923,14.083499]        Units: 1.000e-09
         Unique values: 160                       Missing .: 0/160

                  Mean: -1.50123
             Std. dev.:  6.02617

           Percentiles:      10%       25%       50%       75%       90%
                        -10.4519  -4.55002  -.085703   2.40484   5.02615


