#regionModule

#Install & Import Reporting Services Module - Check if it exists first
Write-Output "Check for ReportingTools module"

Start-Sleep -Seconds 1

if(Get-Module -ListAvailable -Name ReportingServicesTools) 
    {write-Output "SSRS Module Exists, bypass installing module"}

else{ Write-Output "Installing and Importing modules, you may be prompted to install PowerShell Get if not installed"
      Install-Module -Name ReportingServicesTools -AllowClobber -Force
      Import-Module -Name ReportingServicesTools
}

#endregionModule

#regionVariables
#variables for Script Path & SSRS
$projectRoot = Resolve-Path $PSScriptRoot 
$rdlfolder = Join-Path  $projectRoot "RDL"
$rdlFiles = Get-Item $rdlfolder
$drillDownFolder = Join-Path $projectRoot "Drilldown Reports" 
$drillDownFiles = Get-Item $drillDownFolder
$configFolder = Join-Path $projectRoot "Config"
$configFiles = Get-Item $configFolder

#variables for Changing file content
$rdlChange = Get-Item "$rdlfolder\*.rdl"
$drillDownChange = Get-Item "$drillDownFolder\*.rdl"
$configChange = Get-Item "$configFolder\*.rdl"

#endregionVariables

#regionVariablePrompts
#Prompt for SSRS Values
Write-Output "Enter SSRS configuration values"

Start-Sleep -Seconds 1

$reportServer = Read-Host 'Please Enter Your Report Server address, which is called Web Service URL in Reporting Service Configuration Manager'
$ssrsServer = Read-host "Please Enter SSRS server name.  If database is in named instance enter as: server\instance"
$dbname = Read-Host "Please Enter IGEL Database name"

#endregionVariablePrompts

#regionDoWork

#Create SSRS Folders

New-RsFolder -ReportServerUri $reportServer -RsFolder '/' -FolderName 'IGEL Reporting'-Verbose
New-RsFolder -ReportServerUri $reportServer -RsFolder '/IGEL Reporting' -FolderName 'RDL' -Verbose
New-RsFolder -ReportServerUri $reportServer -RsFolder '/IGEL Reporting' -FolderName 'Drilldown Reports' -Verbose
New-RsFolder -ReportServerUri $reportServer -RsFolder '/IGEL Reporting' -FolderName 'Datasource' -Verbose
New-RsFolder -ReportServerUri $reportServer -RsFolder '/IGEL Reporting' -FolderName 'Config' -Verbose

#Update .rdl file content to reflect Database and SSRS Server Name
$rdlChange | ForEach-Object{

    (Get-Content -Path $_.FullName).Replace('umswindows\IGEL605',"$ssrsServer") | Set-Content -Path $_.FullName
    (Get-Content -Path $_.FullName).Replace('rmdb',"$dbname") | Set-Content -Path $_.FullName
    
}

#Update Drilldown file content to reflect Database and SSRS Server Name
$drillDownChange | ForEach-Object{

    (Get-Content -Path $_.FullName).Replace('umswindows\IGEL605',$ssrsServer) | Set-Content -Path $_.FullName
    (Get-Content -Path $_.FullName).Replace('rmdb',$dbname) | Set-Content -Path $_.FullName 
}

#Update Config file content to reflect Database and SSRS Server Name
$configChange | ForEach-Object{

    (Get-Content -Path $_.FullName).Replace('umswindows\IGEL605',$ssrsServer) | Set-Content -Path $_.FullName
    (Get-Content -Path $_.FullName).Replace('rmdb',$dbname) | Set-Content -Path $_.FullName 
}

#Write RDL Files to RDL folder
Write-RsFolderContent -ReportServerUri $reportServer -Path $rdlFiles -RsFolder '/IGEL Reporting/RDL' -Verbose

#Write Drilldown Reports to Drilldown folder
Write-RsFolderContent -ReportServerUri $reportServer -Path $drillDownfiles -RsFolder '/IGEL Reporting/Drilldown Reports' -Verbose

#Write Config Reports to Config folder
Write-RsFolderContent -ReportServerUri $reportServer -Path $configFiles -RsFolder '/IGEL Reporting/Config' -Verbose

#Create data source
New-RsDataSource -RsFolder '/IGEL Reporting/Datasource' -Name 'IGELDB' -Extension 'SQL' -ConnectionString "Data Source=$ssrsServer;Initial Catalog=$dbname" -CredentialRetrieval 'None' -Overwrite

#endregionDoWork

Write-Output "IGEL Reporting Configured.  Please open your browser to access reports"

Start-Sleep -Seconds 5