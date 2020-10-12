# ZipCodeLookup

This module is designed to look up US Zip Codes and get back the corresponding city and state. It serves as an example of how to use a class, and export the class (or more precisely the objects created from the class) outside a module.

In addition to demonstrating the use of a class, it also illustrates how to call a REST API. The USPS (United States Postal Service) has an API which will allow you to retrieve a City and State based on a passed in Zip Code. In this demo you will see how to pass a Zip Code into the USPS website and get back the city and state for that Zip Code.

In order to use it, you will need to first register. It's free, just go to: [USPS Web API Tools](https://www.usps.com/business/web-tools-apis/welcome.htm) and register. They'll send you an email with your user ID.

When you have your user ID, be sure to assign it to the UserID property of the zip code lookup class. For purposes of this example, I'm storing my ID in a file `uid.txt`. I've excluded it from source control so it will not appear on GitHub. Just create your own uid.txt file in the same folder as the ZipCodeLookupUsage*.ps1 files.

Alternatively, you could edit the lines in the two ZipCodeLookupUsage*.ps1 scripts and replace the `$userID = Get-Content ./uid.txt -Raw` with `$userID = 'xxxxxx'` and replace the x's with your unique USPS user ID.

There are two examples of how to use the module, one is in `ZipCodeLookupUsage-ImportModule.ps1`, the second is `ZipCodeLookupUsage-Using.ps1`. Why two? Well it depends on how you want to load the module into your script.

## Import-Module vs Using

Since PowerShell version 5, there have been two ways of importing a module into your PowerShell script. `Import-Module` is well known, and by far the most commonly used. The second is the `using module` statement.

Here is a brief synopsis of their differences.

Item | Import-Module | Using Module
----- | ----- | -----
Where the module can be loaded | Can be anywhere in the script | Must be on the first line(s) before any other code except comments
Exposes classes outside the module | No | Yes
Has access to inline help | Yes | No for classes
Easy for end users | Yes | No
Easy for developers | Yes | Yes
Class can be defined anywhere | Yes | No, for a class to be visible it must be in the PSM1 file

For these reasons, the `using` statement is not widely used. Most developers prefer to generate an object from the class internally in the module, then have a function that will return that object.

While examples of using both methods have been included in this module for completeness, in all my projects I use the Import-Module method. I generate classes within my modules, then use functions to return the objects that were created from the classes. This lets me provide documentation about the object being returned within the function's inline help.

## Other

This module is included in my course, "Everyday PowerShell 7 for Developers on Windows, macOS and Linux" from Pluralsight, due for release in late November 2020. Please see my About Me page (below) for a link to the course once it is published.

---

## Author Information

### Author

Robert C. Cain | [@ArcaneCode](https://twitter.com/arcanecode) | arcanecode@gmail.com

### Websites

About Me: [http://arcanecode.me](http://arcanecode.me)

Blog: [http://arcanecode.com](http://arcanecode.com)

Github: [http://arcanerepo.com](http://arcanerepo.com)

LinkedIn: [http://arcanecode.in](http://arcanecode.in)

### Copyright Notice

This document is Copyright (c) 2015, 2020 Robert C. Cain. All rights reserved.

The code samples herein is for demonstration purposes. No warranty or guarantee is implied or expressly granted.

This document may not be reproduced in whole or in part without the express written consent of the author and/or Pluralsight. Information within can be used within your own projects.
