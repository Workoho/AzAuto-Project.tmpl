<#PSScriptInfo
.VERSION 1.0.0
.GUID b5e78940-5e2f-427d-87a1-c1630ed8c3da
.AUTHOR Julian Pawlowski
.COMPANYNAME Workoho GmbH
.COPYRIGHT (c) 2024 Workoho GmbH. All rights reserved.
.TAGS
.LICENSEURI https://github.com/Workoho/AzAuto-Project.tmpl/LICENSE.txt
.PROJECTURI https://github.com/Workoho/AzAuto-Project.tmpl
.ICONURI
.EXTERNALMODULEDEPENDENCIES
.REQUIREDSCRIPTS
.EXTERNALSCRIPTDEPENDENCIES
.RELEASENOTES
    2024-01-16 - Initial release.
#>

<#
.SYNOPSIS
    Clone the Azure Automation Common Runbook Framework repository and invoke its setup scripts.

.DESCRIPTION
    Make sure that a clone of the Azure Automation Common Runbook Framework repository
    exists in parallel to this project repository. For example:

        C:\Developer\AzAuto-Project.tmpl
        C:\Developer\AzAuto-Common-Runbook-FW

    After this, invoke this script from the setup folder of the parent repository:

        C:\Developer\AzAuto-Common-Runbook-FW\setup\AzAutoFWProject\Update-AzAutoFWProject.ps1

    You may run this script at any time to update the project setup.
    When opening the project in Visual Studio Code, a task to run this script is already
    configured in .vscode\tasks.json.

.EXAMPLE
    Update-AzAutoFWProject.ps1
#>

[CmdletBinding()]
param()

Write-Verbose "---START of $((Get-Item $PSCommandPath).Name), $((Test-ScriptFileInfo $PSCommandPath | Select-Object -Property Version, Guid | & { process{$_.PSObject.Properties | & { process{$_.Name + ': ' + $_.Value} }} }) -join ', ') ---"

#region Read configuration
$ProjectDir = (Get-Item $PSScriptRoot).Parent.Parent.FullName
$ConfigDir = Join-Path $ProjectDir 'config' 'AzAutoFWProject'
$Config = Import-PowerShellDataFile -Path (Join-Path $ConfigDir AzAutoFWProject.psd1) -ErrorAction Stop | & {
    process {
        $_.Keys | Where-Object { $_ -notin ('ModuleVersion', 'Author', 'Description', 'PrivateData') } | & {
            process {
                $_.Remove($_)
            }
        }
        $_.PrivateData.Remove('PSData')
        $local:ConfigData = $_
        $_.PrivateData.GetEnumerator() | & {
            process {
                $ConfigData.Add($_.Key, $_.Value)
            }
        }
        $_.Remove('PrivateData')
        $_    
    }
}
#endregion

#region Clone repository if not exists
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Git is not installed on this system."
    return
}

$AzAutoFWDir = Join-Path (Get-Item $PSScriptRoot).Parent.Parent.Parent.FullName (
    Split-Path (Split-Path $Config.GitRepositoryUrl -Leaf) -LeafBase
).TrimEnd('.git')

if (-Not (Test-Path (Join-Path $AzAutoFWDir '.git') -PathType Container)) {
    try {
        Write-Output "Cloning $Config.GitRepositoryUrl to $AzAutoFWDir"
        $output = git clone --quiet $Config.GitRepositoryUrl $AzAutoFWDir 2>&1
        if ($LASTEXITCODE -ne 0) { Throw "Failed to clone repository: $output" }
    }
    catch {
        Write-Error $_
        exit
    }
}
#endregion

#region Invoke setup scripts from parent repository
try {
    Join-Path $AzAutoFWDir 'setup' 'AzAutoFWProject' (Split-Path $PSCommandPath -Leaf) | & {
        process {
            if (Test-Path $_ -PathType Leaf) {
                & $_ -ChildProjectDir $ProjectDir -ChildProjectConfigDir $ConfigDir -ChildProjectConfig $Config
            }
            else {
                Throw "Could not find $_"
            }
        }
    }    
}
catch {
    Write-Error $_
    exit
}
#endregion

Write-Verbose "-----END of $((Get-Item $PSCommandPath).Name) ---"
