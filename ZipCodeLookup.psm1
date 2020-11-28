<#-------------------------------------------------------------------------------------------------
  Everyday PowerShell 7 for Developers

  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2015, 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.

  This contains the class definition, as well as references to the supporting functions.
-----------------------------------------------------------------------------------------------#>



#------------------------------------------------------------------------------------------------
# In order for a class (or enum) to be visible when you use USING MODULE, the class / enum
# must be defined here in the PSM1.
#
# If you are only going to use Import-Module, then you could copy the class definition into
# a PS1 file and call it from here, as we've done with the Get-ZipCodeData and New-ZipCodeLookup
# functions.
#------------------------------------------------------------------------------------------------

# ZipCodeLookup Class Definition
class ZipCodeLookup
{
  # Properties
  [string] $ZipCode
  [string] $City
  [string] $State
  [string] $UserID

  # Default Constructor
  ZipCodeLookup()
  {
  }

  # Constructor passing in Zip Code
  ZipCodeLookup($userID, $zip)
  {
    $this.UserID = $userID
    $this.ZipCode = $zip
  }

  # Set zip code property then call the lookup
  [void] Lookup($userID, $zip)
  {
    $this.UserID = $userID
    $this.ZipCode = $zip
    $this.Lookup()
  }

  # Lookup based on zip code in $ZipCode property
  [void] Lookup()
  {
    # Validate our zip code is correct length
    if ($this.ZipCode.Length -ne 5)
    {
      $this.City = 'Invalid Zip - Zip Code must be five numbers'
      $this.State = 'N/A'
      throw 'Invalid Zip Code - Zip Code must be exactly five numbers'
      return
    }

    # Validate it is five numbers using a regular expression
    if ($($this.ZipCode -match "[0-9]{5}") -ne $true)
    {
      $this.City = 'Invalid Zip - Zip Code may only have numbers'
      $this.State = 'N/A'
      throw 'Invalid Zip Code - Zip Code may only contain numbers'
      return
    }

    # Format the base for our API call
    $urlBase = 'http://production.shippingapis.com/ShippingAPI.dll?API=CityStateLookup&XML='

    # Format the data we need to pass into the API
    $urlXML = @"
    <CityStateLookupRequest%20USERID="$($this.UserID)">
      <ZipCode ID= "0">
      <Zip5>$($this.ZipCode)</Zip5>
      </ZipCode>
    </CityStateLookupRequest>
"@

    # Combine into the URL we will call
    $url = $urlBase + $urlXML

    # Call the rest api
    [xml]$response = Invoke-RestMethod $url

     <#
       Note: This is what the response XML looks like

       <?xml version="1.0"?>
         <CityStateLookupResponse>
           <ZipCode ID="0">
             <Zip5>90210</Zip5>
             <City>BEVERLY HILLS</City>
             <State>CA</State>
           </ZipCode>
         </CityStateLookupResponse>

     #>

    # If the API doesn't find the passed in zips, it returns
    # empty values. Validate good data came back and if so copy
    # into the class properties, otherwise flag as invalid
    if ($response.CityStateLookupResponse.ZipCode.City.Length -eq 0)
    {
      $this.City = 'Invalid Zip Code'
    }
    else
    {
      $this.City = $response.CityStateLookupResponse.ZipCode.City
    }

    if ($response.CityStateLookupResponse.ZipCode.State.Length -eq 0)
    {
      $this.State = 'Invalid Zip Code'
    }
    else
    {
      $this.State = $response.CityStateLookupResponse.ZipCode.State
    }
  }

}


#------------------------------------------------------------------------------------------------
# Call the other scripts to create the functions
#------------------------------------------------------------------------------------------------
. ./Code/Get-ZipCodeData.ps1
. ./Code/New-ZipCodeLookup.ps1

#------------------------------------------------------------------------------------------------
# Export our functions. (Note, we don't explictly export classes, all classes are exported
# by default.)
#------------------------------------------------------------------------------------------------

Export-ModuleMember New-ZipCodeLookup
Export-ModuleMember Get-ZipCodeData
