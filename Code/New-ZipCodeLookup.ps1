<#
.SYNOPSIS
Creates and returns a new instance of the ZipCodeLookup class.

.DESCRIPTION
Creates a new variable based on the ZipCodeLookup class and returns it.

.INPUTS
This cmdlet has these inputs:

ZipCode | Used to hold the zip code we want to lookup
UserID | The USPS User ID for you, this is passed to the USPS Web Service
Lookup | The method which executes the call to the USPS Web Service based on the value in the Zip Code property, for which you need your UserID. Loads the state and city properties with the results of the call.

.OUTPUTS
The cmdlet returns an object with the following properties and methods:

City | The name of the city for this zip code
State | The state for this zip code

.EXAMPLE
$myZip = New-ZipCodeLookup
$myZip.UserID = 'xxxxxxx'  # Your USPS User ID here
$myZip.ZipCode = '35051'
$myZip.Lookup()

This returns data similar to the following example:

City | Columbiana
State | Alabama

.NOTES
ZipCodeLookup - New-ZipCodeLookup.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

If you load a module using the Import-Module cmdlet, then any classes in the module are not visible outside the module.

Thus, in order to generate a new instance of the class it is necessary to have a function in the module which simply generates a new instance of the class and returns it.

This code is Copyright (c) 2015, 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes. No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without the express written consent of the author.

.LINK
https://github.com/arcanecode/ZipCodeLookup/blob/master/Documentation/New-ZipCodeLookup.md

.LINK
http://arcanecode.me

.LINK
https://github.com/arcanecode/ZipCodeLookup
#>
function New-ZipCodeLookup()
{
  # Simply return a new instance of our ZipCodeLookup class.
  return [ZipCodeLookup]::new()
}