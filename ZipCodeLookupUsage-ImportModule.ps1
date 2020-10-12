<#-----------------------------------------------------------------------------------------------
  Everyday PowerShell 7 for Developers on Windows, macOS and Linux
  Using the Zip Code Lookups Module

  Author: Robert C. Cain | @ArcaneCode | arcanecode@gmail.com
          http://arcanecode.com

  This module is Copyright (c) 2015, 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarentee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.

  Notes
  This script demonstrates how to use a module which contains a class, when that module is
  loaded using the Import-Module cmdlet. See the ZipCodeLookupUsage-Using.ps1 for an example
  of loading the module using the Using command.

  See the ReadMe.md for a discussion of the differences.

-----------------------------------------------------------------------------------------------#>

# To use a module, you first need to import it. Just in case it was already
# Since this is a develoment environment we'll include the -Force switch
Remove-Module ZipCodeLookup -ErrorAction SilentlyContinue
Import-Module ./ZipCodeLookup -Force

#------------------------------------------------------------------------------------------------
# In this first section we will create a new instance of the class and
# work with it
#------------------------------------------------------------------------------------------------

# Create a new instance of the Zip Code Lookup
$myZip = New-ZipCodeLookup

$userID = Get-Content ./uid.txt -Raw

$myZip.UserID = $userID

# Set the zip code then call the lookup
$myZip.ZipCode = '35051'
$myZip.Lookup()

# Display the results
$myZip.City
$myZip.State

# Call again, passing in the USPS User ID and zip code into the overload of the lookup function
$myZip.Lookup($userID, '90210')
"$($myZip.ZipCode) is located in $($myZip.City), $($myZip.State)"

# Demonstrate the error when the zip code is not five characters
$myZip.Lookup($userID, '')

# Demonstrate the error when the zip code is not numeric
$myZip.Lookup($userID, 'abcde')

# Show how to trap for the error
try
{
  $myZip.Lookup($userID, 'abcde')
}
catch
{
  Write-Host "Error!" -ForegroundColor Yellow
  Write-Host "Error Message: $($_.Exception.Message)" -ForegroundColor Yellow
}

#------------------------------------------------------------------------------------------------
# In this section, look at how to use the pipeline enabled function to return data
#------------------------------------------------------------------------------------------------

# Use the cmdlet, non pipelined, to call the lookup and return an object
$newZip = Get-ZipCodeData -UserID $userID -ZipCodes '84025'
"$($newZip.ZipCode) is located in $($newZip.City), $($newZip.State)"

# Now call it via pipeline. Note that even though we use the pipeline for the zip codes, we
# still need to pass in the USPS User ID as a named parameter
$zipArray = '90210', '35051', '84025'
$zipResult = $zipArray | Get-ZipCodeData -UserID $userID
$zipResult

# Use a for each to iterate over the result
foreach ($z in $zipResult)
{
  "$($z.ZipCode) is located in $($z.City), $($z.State)"
}

# What about bad data in the pipe?
$zipArray = '90210','1', '35051', 'abcde', '84025', '99999'
$zipResult = $zipArray | Get-ZipCodeData -UserID $userID
$zipResult

# Suppress the red errors by catching but doing nothing
try
{
  $zipArray = '90210','1', '35051', 'abcde', '84025', '99999'
  $zipResult = $zipArray | Get-ZipCodeData -UserID $userID
}
catch
{
  # Do Nothing
}
finally
{
  $zipResult
}
