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
  loaded using the USING MODULE cmdlet. See the ZipCodeLookupUsage-Import-Module.ps1 for
  an example of loading the module using the Import-Module cmdlet.

  See the ReadMe.md for a discussion of the differences.

-----------------------------------------------------------------------------------------------#>
using module "./ZipCodeLookup.psd1"

#------------------------------------------------------------------------------------------------
# Note that the using statement(s) must be the very first thing in our script, with the
# exception of comments. Also, if you are loading a module that you've defined here, and is
# not in your default PowerShell Modules folder, then you have to include the psd1 extension.
#------------------------------------------------------------------------------------------------

# With using, the class is available directly
$myZipCode = [ZipCodeLookup]::new()

# Get our user ID
$userID = Get-Content ./uid.txt -Raw
$myZipCode.UserID = $userID

# Set the zip code then call the lookup
$myZipCode.ZipCode = '35051'
$myZipCode.Lookup()

# Display the results
$myZipCode.City
$myZipCode.State

# Call again, passing in the zip code into the overload of the lookup function
$myZipCode.Lookup($userID, '90210')
"$($myZipCode.ZipCode) is located in $($myZipCode.City), $($myZipCode.State)"

# As you can see, execept for the way we create the zip code object from the ZipCodeLookup
# class, calling it's methods and properties are the same whether the module was loaded
# using Import-Module or the USING MODULE statement.

# The big difference is pipelining. The class is not pipeline enabled, so you'd have to
# author a function to handle pipelining, or use the Get-ZipCodeData built into the module.
