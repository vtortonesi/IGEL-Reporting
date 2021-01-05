<#
.SYNOPSIS
	This script changes the schema name refernce in the SQL portion of every .rdl file in the RDL folder
.DESCRIPTION
    IGEL SQL databases are usually created using a different schema other than the default dbo schema.  
    Because of variances in schema names it's not possible to write a SQL query knowing what the schema
    name will be. Therefore each SQL script uses a default schema name called igelums.  If the schema name
    is different than igelums the user will need to enter it when prompted.
.EXAMPLE
.NOTES
.LINK
#>
#region declareVariables

$scriptRoot = $PSScriptRoot
$files = Get-Item  "$scriptRoot\RDL\*.rdl"
$drillDown = Get-Item "$scriptRoot\Drilldown Reports\*.rdl"
$execPolicy = Get-ExecutionPolicy

#endregion

#Check & Change PowerShell Execution policy if needed
    if($execPolicy -ne 'Bypass'){
           Set-ExecutionPolicy -ExecutionPolicy Bypass -Force -Scope CurrentUser
    }

#Prompt user for schema name and validate if schema name needs to be changed

$isSchema = Read-Host " Is the IGEL database schema named igelums: Enter (Y) or (N)"
    if($isSchema -eq 'Y') {
            Write-Output "No additional changes are needed, exiting script"
            Start-Sleep -Seconds 2
            Exit
    }

    else{
        Write-Output "The schema name will need to be updated"
    }

    $schemaName = Read-Host "Please enter your schema name"

#Change database schema name in each .rdl file
$files | ForEach-Object{

    (Get-Content -Path $_.FullName).Replace('igelums',$schemaName) | Set-Content -Path $_.FullName
}

Write-Output "Schema name changed in Report .rdl files"
start-sleep -Seconds 1

#Change database schema name in drill down reports for each .rdl file
$drillDown | ForEach-Object{

    (Get-Content -Path $_.FullName).Replace('igelums',$schemaName) | Set-Content -Path $_.FullName
}

Write-Output "Schema name changed in drill down .rdl files"
start-sleep -Seconds 1

#TO DO - Check the file was modified by looking at lastWriteTime

#Change Execution Policy back to original state
Set-ExecutionPolicy $execPolicy -Force -Scope CurrentUser
