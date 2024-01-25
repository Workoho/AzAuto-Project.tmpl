<#PSScriptInfo
.VERSION 0.0.1-Alpha1
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
#>

[CmdletBinding()]
Param(
    [array]$Addressee = 'world',
    [boolean]$OutJson
)

# if (-Not $PSCommandPath) { Write-Error 'This runbook is used by other runbooks and must not be run directly.' -ErrorAction Stop; exit }     # Use this if you write your own child runbooks and want to prevent them from being run directly in Azure Automation
Write-Verbose "---START of $((Get-Item $PSCommandPath).Name), $((Test-ScriptFileInfo $PSCommandPath | Select-Object -Property Version, Guid | & { process{$_.PSObject.Properties | & { process{$_.Name + ': ' + $_.Value} }} }) -join ', ') ---"
$StartupVariables = (Get-Variable | & { process { $_.Name } })      # Remember existing variables so we can cleanup ours at the end of the script

#region This region could be your code
$returnOutput = [System.Collections.ArrayList]::new()
$returnInformation = [System.Collections.ArrayList]::new()
$returnWarning = [System.Collections.ArrayList]::new()
$returnError = [System.Collections.ArrayList]::new()

if ($PSBoundParameters.ContainsKey('Addressee')) {
    if ($PSBoundParameters.ContainsKey('OutJson')) {
        Write-Verbose 'Finally, -Addressee and -OutJson were used.'
    }
    else {
        $null = $returnWarning.Add(( ./Common_0000__Write-Warning.ps1 @{
                    Message = 'Okay you found the -Addressee parameter, great! How about also pimping the script output by using the -OutJson parameter, he? 🙄'
                }))
    }
}
else {
    $null = $returnError.Add(( ./Common_0000__Write-Error.ps1 @{
                Message     = 'You could have used the -Addressee parameter. What''s wrong with you? 🙃'
                ErrorAction = 'Continue'
            }))
}

$AddresseeList = $Addressee[0..($Addressee.Count - 2)] -join ', '
if ($Addressee.Count -gt 1) {
    $null = $returnInformation.Add(( ./Common_0000__Write-Information.ps1 @{
                Message           = 'Information/Hint: We got multiple addressees, yay. 👏'
                InformationAction = 'Continue'
            }))
    $AddresseeList += ' and ' + $Addressee[-1]
}
else {
    $null = $returnWarning.Add(( ./Common_0000__Write-Warning.ps1 @{
                Message = 'Too bad there is only one addressee 🥺'
            }))
    $AddresseeList = $Addressee[0]
}

$null = $returnOutput.Add(
    "Hello $AddresseeList! If you can read this, this runbook is working as expected."
)

$return = @{
    Output      = $returnOutput
    Information = $returnInformation
    Warning     = $returnWarning
    Error       = $returnError
}
#endregion

Get-Variable | Where-Object { $StartupVariables -notcontains @($_.Name, 'return') } | & { process { Remove-Variable -Scope 0 -Name $_.Name -Force -WarningAction SilentlyContinue -ErrorAction SilentlyContinue -Verbose:$false -Debug:$false } }        # Delete variables created in this script to free up memory for tiny Azure Automation sandbox
Write-Verbose "-----END of $((Get-Item $PSCommandPath).Name) ---"
if ($OutJson) { ./Common_0000__Write-JsonOutput.ps1 -ConvertToParam @{ Compress = $false } $return; return }
return $return.Output
