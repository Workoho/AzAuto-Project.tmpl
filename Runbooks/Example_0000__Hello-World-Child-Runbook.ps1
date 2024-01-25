<#PSScriptInfo
.VERSION 1.0.0-Alpha1
.GUID 34d95689-6862-49f3-8f14-0c4a157e96ef
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
    Simple example child runbook that demonstrates how it can only be used by other runbooks.

.DESCRIPTION
    You may use this child runbook as a template for your own child runbooks.
    Remember that you SHOULD generate a new GUID for the #PSScriptInfo section above using the `New-Guid` command.
#>

[CmdletBinding()]
Param()

if (-Not $PSCommandPath) { Write-Error 'This runbook is used by other runbooks and must not be run directly.' -ErrorAction Stop; exit }       # This will only work when starting a job in Azure Automation, not when running the script on your local machine
Write-Verbose "---START of $((Get-Item $PSCommandPath).Name), $((Test-ScriptFileInfo $PSCommandPath | Select-Object -Property Version, Guid | & { process{$_.PSObject.Properties | & { process{$_.Name + ': ' + $_.Value} }} }) -join ', ') ---"
$StartupVariables = (Get-Variable | & { process { $_.Name } })      # Remember existing variables so we can cleanup ours at the end of the script

#region This region could be your code -----------------------------------------
# This variable will not be cleaned from memory after the script has finished
$return = 'Hello from our child runbook! 👶'

$runtimeVariable = 'This variable WILL be cleaned from memory after the script has finished'
Write-Verbose "runtimeVariable will be gone so I am telling you: $runtimeVariable"
#endregion ----------------------------------------------------------------------

Get-Variable | Where-Object { $StartupVariables -notcontains @($_.Name, 'return') } | & { process { Remove-Variable -Scope 0 -Name $_.Name -Force -WarningAction SilentlyContinue -ErrorAction SilentlyContinue -Verbose:$false -Debug:$false } }        # Delete variables created in this script to free up memory for tiny Azure Automation sandbox
Write-Verbose "-----END of $((Get-Item $PSCommandPath).Name) ---"
return $return
