<#
.SYNOPSIS
Performs a zip code lookup for one or more zip codes.

.DESCRIPTION
This pipeline enabled function can take one or more zip codes, creates a new ZipCodeLookup
object for each one, does the lookup, and returns the new objects.

.PARAMETER UserID
The USPS assigned User ID, used in the call to the USPS Web Service.

.PARAMETER ZipCodes
One or more zip codes to lookup.

.INPUTS
This cmdlet has these inputs:

ZipCodes | Used to hold the zip code(s) we want to lookup
UserID | The USPS User ID for you, this is passed to the USPS Web Service

.OUTPUTS
The cmdlet creates an array of one or more objects with the following properties:

ZipCode | The zip code to lookup
City | The name of the city for this zip code
State | The state for this zip code
UserID | The USPS User ID for you, this is passed to the USPS Web Service

.EXAMPLE
$zipArray = '90210', '35051', '84025'
$zipResult = $zipArray | Get-ZipCodeData -UserID $userID

Get-ZipCodeData returns data similar to the following example:

ZipCode | 90210
City    | BEVERLY HILLS
State   | CA
UserID  | (Redacted, your ID would be here)
ZipCode | 35051
City    | COLUMBIANA
State   | AL
UserID  | (Redacted, your ID would be here)
ZipCode | 84025
City    | FARMINGTON
State   | UT
UserID  | (Redacted, your ID would be here)

.NOTES
ZipCodeLookup - Get-ZipCodeData.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2015, 2020 Robert C Cain All rights reserved

This function creates a new instance of zip code lookup, does the lookup, then returns the object created from the class to the caller.

This is implemented as an advanced function. It accepts input from the pipeline, and sends the generated objects back out the pipeline.

The code herein is for demonstration purposes. No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without the express written consent of the author.

.LINK
https://github.com/arcanecode/ZipCodeLookup/blob/master/Documentation/Get-ZipCodeData.md

.LINK
http://arcanecode.me

.LINK
https://github.com/arcanecode/ZipCodeLookup
#>
function Get-ZipCodeData()
{
  # Needed to indicate this is the parameter block for an advanced function
  [CmdletBinding()]
  param (
         [Parameter( Mandatory = $true,
                     ValueFromPipeline = $false,
                     HelpMessage = 'Please enter the USPS User ID.'
                     )]
         [string] $UserID
        ,[Parameter( Mandatory = $true,
                     ValueFromPipeline = $true,
                     ValueFromPipelineByPropertyName = $true,
                     HelpMessage = 'Please enter the zip.'
                     )]
         [string[]] $ZipCodes
        )  # End the parameter block

  process
  {
    foreach($zip in $ZipCodes)
    {
      try
      {
        $zcl = [ZipCodeLookup]::new($UserID, $zip)
        $zcl.Lookup()
      }
      catch
      {
        # Do Nothing, the object will set the city and state to indicate
        # an error occurred
      }

      return $zcl

    }
  }
}