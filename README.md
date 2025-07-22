# USRefugees2025
## Introduction
Under the Trump Administration, immigration enforcement has been significantly scaled up. Immigration & Customs Enforcement (ICE) raids are common and widespread, and raids have even occurred at courthouses as immigrants were navigating the legal system. Similar tactics were instituted under Trump’s first administration in 2016-2020. Furthermore, refugee admissions have been frozen indefinitely, leaving an extremely vulnerable group of people with even less safety and security.

Inspired by these current events, this research aims to assess the treatment of refugees in the US by federal agencies across presidential administrations. To accomplish this, data from the Department of State on refugee admissions is compared with data from the Department of Homeland Security on refugee resettlements. Comparisons are then further drawn between all presidential administrations for which data is available, ranging from President Carter to President Biden.


## Scripts
### Script 1 - xlsx_to_csv
This script converts all excel spreadsheets downloaded from various data sources into csvs. Cleaning and analysis for each dataset occurs in a separate script.


### Script 2 - prm_analysis
This script reads in and analyzes the 2024 Refugee Admissions Report from the Refugee Processing Center (located within the Bureau of Population, Refugees, and Migration).

Link to RPC website: https://www.wrapsnet.org/admissions-and-arrivals/

Link to download the excel: https://view.officeapps.live.com/op/view.aspx?src=https%3A%2F%2Fwww.wrapsnet.org%2Fdocuments%2FPRM%2520Refugee%2520Admissions%2520Report%2520as%2520of%252031%2520Dec%25202024.xlsx&wdOrigin=BROWSELINK

The excel download link should also be located on the RPC website in the event that the url becomes outdated with a future update. Under "Refugee Admissions Report" select "Refugee Admissions Report as of December 31, 2024."
The script begins with copied code from xlsx_to_csv, followed by dataset cleaning and visual data analysis. Two line plots and one bar plot are included.


### Script 3 - dhs_refugee_asylees

Link: https://ohss.dhs.gov/topics/immigration/yearbook
