# USRefugees2025
## Introduction
Under the Trump Administration, immigration enforcement has been significantly scaled up. Immigration & Customs Enforcement (ICE) raids are common and widespread, and raids have even occurred at courthouses as immigrants were navigating the legal system. Similar tactics were instituted under Trump’s first administration in 2016-2020. Furthermore, refugee admissions have been frozen indefinitely, leaving an extremely vulnerable group of people with even less safety and security.
<br>

Inspired by these current events, this research aims to assess the treatment of refugees in the US by federal agencies across presidential administrations. To accomplish this, data from the Department of State on refugee admissions is compared with data from the Department of Homeland Security on refugee resettlements. Comparisons are then further drawn between all presidential administrations for which data is available, ranging from President Carter to President Biden.


## Scripts

### Primary Script - prm_analysis
This is the primary script from which all analysis is conducted. Cleaned data from the 2024 Refugee Admissions Report from the Refugee Processing Center (located within the Bureau of Population, Refugees, and Migration) and from the 2023 Immigration Yearbook from the Office of Homeland Security Statistics (under the Department of Homeland Security). Refugee ceiling data and a secondary source for refugee admissions comes from the Migration Policy Institute (MPI). Data was cleaned first in excel, converted from xlsx to csv, and then imported into R for analysis. This script does some additional data cleaning and formating before creating several data visualizations. Analysis is primarily using the PRM data, but data on asylees from OHSS is used at the end of the script for a final comparison.
<br>
<br>

#### RPC
Link to RPC website: https://www.wrapsnet.org/admissions-and-arrivals/
<br>

Link to download refugee admissions data: https://view.officeapps.live.com/op/view.aspx?src=https%3A%2F%2Fwww.wrapsnet.org%2Fdocuments%2FPRM%2520Refugee%2520Admissions%2520Report%2520as%2520of%252031%2520Dec%25202024.xlsx&wdOrigin=BROWSELINK
<br>

The excel download link should also be located on the RPC website in the event that the url becomes outdated with a future update. Under "Refugee Admissions Report" select "Refugee Admissions Report as of December 31, 2024."
<br>
<br>

#### OHSS
Link to OHSS: https://ohss.dhs.gov/topics/immigration/yearbook
<br>

Link to download refugee arrivals data: https://view.officeapps.live.com/op/view.aspx?src=https%3A%2F%2Fohss.dhs.gov%2Fsites%2Fdefault%2Ffiles%2F2024-11%2F2024_1108_ohss_yearbook_refugees_fy2023.xlsx&wdOrigin=BROWSELINK
<br>

Link to download data on asylum grants: https://view.officeapps.live.com/op/view.aspx?src=https%3A%2F%2Fohss.dhs.gov%2Fsites%2Fdefault%2Ffiles%2F2024-10%2F2024_1002_ohss_yearbook_asylees_fy2023.xlsx&wdOrigin=BROWSELINK 
<br>

These datasets and others can be navigated from the OHSS link provided, especially as future annual yearbook reports are added.
<br>
<br>

#### MPI
Link to MPI: https://www.migrationpolicy.org/programs/migration-data-hub
<br>

Link to obtain refugee ceiling numbers: https://view.officeapps.live.com/op/view.aspx?src=https%3A%2F%2Fwww.migrationpolicy.org%2Fsites%2Fdefault%2Ffiles%2Fdatahub%2FMPI-Data-Hub_Refugee-Admissions_1980-2025Q1.xlsx&wdOrigin=BROWSELINK
<br>
<br>
<br>
<br>

### Supplementary Script 1 - xlsx_to_csv
This script converts all excel spreadsheets downloaded from various data sources into csvs. Cleaning and analysis for each dataset occurs in a separate script.
<br>
<br>
<br>
<br>

### Supplementary Script 2 - dhs_refugee_asylees
This script was used to evaluate if DHS refugee arrival numbers differed significantly from PRM refugee admissions numbers. No major discrepancies were found, so any further analysis was continued in the main script, prm_analysis.
