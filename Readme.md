 # IGEL Reporting

- Disclaimer 
- Introduction
- Configuration
- How to Run
---
## Disclaimer
 
### IGEL Reporting is without any warranty or support by IGEL Technology
---
## Introduction
IGEL Reporting are reports created using SQL Reporting Services (SSRS).  These reports are pulling data direct from the IGEL database. 

## Configuration

### Prerequisites:
Prior to running any reports, the following will need to be installed:
  1.  SQL Reporting Services 
  2.  Post installation configuration for SQL Reporting Services
  3.  Report Server configured
  4.  Reporting Services web service running and validated a connection can be made to the ReportServer site
   
  #### Note: Please see the Word document provided as a guide for a basic SSRS installation.


### Scripts
When IGEL Reporting has been downloaded, there are two PowerShell configuration scripts to be run:
1.  replaceSchemaName.ps1 - This  will rename the schema referenced in each SQL Query.  The script will prompt and validate if the schema name is igelums. If it's not, enter the schema name and it will rename the schema reference in each SQL query in the .rdl files.
   
2.  IGEL_Reporting_Configuration.ps1 - This will create the SSRS folders, upload the reports, as well create and configure the datasource referenced in the reports.

3.  Once installation is complete, go to the Datasource folder and select the credentials to use for the datasource (i.e. the account that will query the IGEL Database).  By default, the configuration script sets it to run without credentials. 
#### Note:  This scrript needs to be run with elevated credentials, as there is a module being installed.

## How to Run
Once the configuration scripts have been run browse to the SSRS server name and open the ReportServer page (e.g. http: //igelserver/reportserver).  From there drill into IGEL Reporting > RDL and choose Home Page

#### Note: It's recommended to Bookmark the Home Page for future use.