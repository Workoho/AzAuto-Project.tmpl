<#PSScriptInfo
.VERSION 1.0.0-Alpha1
.GUID 5ad354a5-496c-4785-980a-2523722d52e0
.AUTHOR John Doe
.COMPANYNAME Contoso
.COPYRIGHT (c) 2024 Contoso Inc. All rights reserved.
.TAGS
.LICENSEURI https://github.com/Contoso/MyAzAuto-Project/LICENSE.txt
.PROJECTURI https://github.com/Contoso/MyAzAuto-Project
.ICONURI
.EXTERNALMODULEDEPENDENCIES
.REQUIREDSCRIPTS
.EXTERNALSCRIPTDEPENDENCIES
.RELEASENOTES
    2024-01-01 - Initial release.
#>

<#
.SYNOPSIS
    Simple example runbook that demonstrates using some the common runbooks of the Azure Automation Common Runbook Framework.

.DESCRIPTION
    You may use this runbook as a template for your own runbooks.
    Remember that you SHOULD generate a new GUID for the #PSScriptInfo section above using the `New-Guid` command.

.PARAMETER Addressee
    The name of the person to greet. Defaults to 'world'.

.PARAMETER Webhook
    The webhook URI to return the output to in JSON format.

.PARAMETER OutJson
    Switch to return the output in JSON format so it may be fetched by other systems for further processing.
#>

[CmdletBinding()]
Param(
    [array]$Addressee = 'world',
    [string]$Webhook,
    [boolean]$OutJson
)

#region This region could be your code -----------------------------------------

$returnOutput = [System.Collections.ArrayList]::new()
$returnInformation = [System.Collections.ArrayList]::new()
$returnWarning = [System.Collections.ArrayList]::new()
$returnError = [System.Collections.ArrayList]::new()

if ($PSBoundParameters.ContainsKey('Addressee')) {
    if ($PSBoundParameters.ContainsKey('OutJson')) {
        # This message will be send to the verbose stream and not be visible
        # in the Azure Automation job output stream when using the -OutJson parameter
        Write-Verbose 'Finally, -Addressee and -OutJson were used.'
    }
    else {
        # This warning will be send to the warning stream and will be visible
        # in the Azure Automation job output stream when using the -OutJson parameter
        $null = $returnWarning.Add(( ./Common_0000__Write-Warning.ps1 @{
                    Message = 'Okay you found the -Addressee parameter, great! How about also pimping the script output by using the -OutJson parameter, he? 🙄'
                }))
    }
}
else {
    # This error will be send to the error stream and will be visible
    # in the Azure Automation job output stream when using the -OutJson parameter
    $null = $returnError.Add(( ./Common_0000__Write-Error.ps1 @{
                Message     = 'You could have used the -Addressee parameter. What''s wrong with you? 🙃'
                ErrorAction = 'Continue'
            }))
}

$AddresseeList = $Addressee[0..($Addressee.Count - 2)] -join ', '
if ($Addressee.Count -gt 1) {
    # This information will be send to the information stream and will be visible
    # in the Azure Automation job output stream when using the -OutJson parameter
    $null = $returnInformation.Add(( ./Common_0000__Write-Information.ps1 @{
                Message           = 'Information/Hint: We got multiple addressees, yay. 👏'
                InformationAction = 'Continue'
            }))
    $AddresseeList += ' and ' + $Addressee[-1]
}
else {
    # This warning will be send to the warning stream and will be visible
    # in the Azure Automation job output stream when using the -OutJson parameter
    $null = $returnWarning.Add(( ./Common_0000__Write-Warning.ps1 @{
                Message = 'Too bad there is only one addressee 🥺'
            }))
    $AddresseeList = $Addressee[0]
}

# This output will be send to the output stream at the end and will always be visible
$null = $returnOutput.Add(
    "Hello $AddresseeList! If you can read this, this runbook is working as expected."
)
$null = $returnOutput.Add( (./Example_0000__Hello-World-Child-Runbook.ps1) )

$return = @{
    Output      = $returnOutput
    Information = $returnInformation
    Warning     = $returnWarning
    Error       = $returnError
}

# Submit the output in JSON format to an external URL
if ($Webhook) { ./Common_0000__Submit-Webhook.ps1 -Uri $Webhook -Body $return 1> $null }

# Return the output in JSON format so it may be fetched by other systems for further processing
if ($OutJson) { ./Common_0000__Write-JsonOutput.ps1 -ConvertToParam @{ Compress = $false } $return; return }

return $return.Output

#endregion ---------------------------------------------------------------------
