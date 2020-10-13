# Get-ZipCodeData

## SYNOPSIS

Performs a zip code lookup for one or more zip codes.

## SYNTAX

```powershell
Get-ZipCodeData [-UserID] <String> [-ZipCodes] <String[]> [<CommonParameters>]
```

## DESCRIPTION

This pipeline enabled function can take one or more zip codes, creates a new ZipCodeLookup
object for each one, does the lookup, and returns the new objects.

## EXAMPLES

### EXAMPLE 1

```powershell
$zipArray = '90210', '35051', '84025'
$zipResult = $zipArray | Get-ZipCodeData -UserID $userID
```

Get-ZipCodeData returns data similar to the following example:

Property | Value
| ----- | ------ |
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

## PARAMETERS

### -UserID

The USPS assigned User ID, used in the call to the USPS Web Service.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ZipCodes

One or more zip codes to lookup.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

This cmdlet has these inputs:
Property | Description
| ----- | ------ |
ZipCodes | Used to hold the zip code(s) we want to lookup
UserID | The USPS User ID for you, this is passed to the USPS Web Service

## OUTPUTS

The cmdlet creates an array of one or more objects with the following properties:
Property | Description
| ----- | ------ |
ZipCode | The zip code to lookup
City | The name of the city for this zip code
State | The state for this zip code
UserID | The USPS User ID for you, this is passed to the USPS Web Service

## NOTES

ZipCodeLookup - Get-ZipCodeData.ps1

Author: Robert C Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcane@arcanetc.com

This code is Copyright (c) 2015, 2020 Robert C Cain All rights reserved

This function creates a new instance of zip code lookup, does the lookup, then returns the object created from the class to the caller.

This is implemented as an advanced function.
It accepts input from the pipeline, and sends the generated objects back out the pipeline.

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without the express written consent of the author.

## RELATED LINKS

[Get-ZipCodeData](https://github.com/arcanecode/ZipCodeLookup/blob/master/Documentation/Get-ZipCodeData.md)

[ArcaneCode's Website](http://arcanecode.me)

[ZipCodeLookup on GitHub](https://github.com/arcanecode/ZipCodeLookup)
