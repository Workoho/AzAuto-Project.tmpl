# Ensure the required assembly is loaded
if (-not ('Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord' -as [type])) {
    Import-Module PSScriptAnalyzer
}

# Custom rule to check for usage of Join-Path
function PSScriptAnalyzer_CustomRule_JoinPath {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.Language.ScriptBlockAst] $Ast
    )

    # Check for usage of Join-Path
    $findings = $Ast.FindAll({
            param($node)

            # Check for usage of Join-Path with more than two arguments
            if (
                $node -is [System.Management.Automation.Language.CommandAst] -and
                $node.CommandElements[0].Value -eq 'Join-Path' -and
                $node.CommandElements.Count -gt 2
            ) {
                return [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord]::new(
                    'Join-Path in PowerShell 5.1 can only handle two paths.', # Descriptive message about the issue
                    $node.Extent, # The extent (range) in the script file where the issue was found
                    'PSScriptAnalyzer_CustomRule_JoinPath', # Unique identifier for your custom rule
                    'Warning', # Severity of the issue (e.g., Warning, Error)
                    $null, # Name of the script file where the issue was found
                    'Workoho.Az.Automation.PS/.vscode/PSScriptAnalyzerCustomRules.ps1m' # Source of the rule (e.g., your custom rule module name)
                )
            }
            return $null
        }, $true)

    return $findings
}

# Custom rule to check for usage of Split-Path
function PSScriptAnalyzer_CustomRule_SplitPath {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.Language.ScriptBlockAst] $Ast
    )

    # Check for usage of Split-Path
    $findings = $Ast.FindAll({
            param($node)

            # Check for usage of Split-Path with -LeafBase parameter
            if (
                $node -is [System.Management.Automation.Language.CommandAst] -and
                $node.CommandElements[0].Value -eq 'Split-Path' -and
                $node.CommandElements.Value -contains '-LeafBase'
            ) {
                return [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord]::new(
                    'Split-Path in PowerShell 5.1 does not support the -LeafBase parameter.', # Descriptive message about the issue
                    $node.Extent, # The extent (range) in the script file where the issue was found
                    'PSScriptAnalyzer_CustomRule_SplitPath', # Unique identifier for your custom rule
                    'Warning', # Severity of the issue (e.g., Warning, Error)
                    $null, # Name of the script file where the issue was found
                    'Workoho.Az.Automation.PS/.vscode/PSScriptAnalyzerCustomRules.ps1m' # Source of the rule (e.g., your custom rule module name)
                )
            }
            return $null
        }, $true)

    return $findings
}

# Custom rule to check for usage of Get-ChildItem
function PSScriptAnalyzer_CustomRule_GetChildItem {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.Language.ScriptBlockAst] $Ast
    )

    # Check for usage of Get-ChildItem
    $findings = $Ast.FindAll({
            param($node)

            # Check for usage of Get-ChildItem with -Depth parameter
            if (
                $node -is [System.Management.Automation.Language.CommandAst] -and
                $node.CommandElements[0].Value -eq 'Get-ChildItem' -and
                $node.CommandElements.Value -contains '-Depth'
            ) {
                return [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord]::new(
                    'Get-ChildItem in PowerShell 5.1 does not support the -Depth parameter.', # Descriptive message about the issue
                    $node.Extent, # The extent (range) in the script file where the issue was found
                    'PSScriptAnalyzer_CustomRule_GetChildItem', # Unique identifier for your custom rule
                    'Warning', # Severity of the issue (e.g., Warning, Error)
                    $null, # Name of the script file where the issue was found
                    'Workoho.Az.Automation.PS/.vscode/PSScriptAnalyzerCustomRules.ps1m' # Source of the rule (e.g., your custom rule module name)
                )
            }
            return $null
        }, $true)

    return $findings
}

# Custom rule to check for usage of ConvertTo-Json
function PSScriptAnalyzer_CustomRule_ConvertToJson {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.Language.ScriptBlockAst] $Ast
    )

    # Check for usage of ConvertTo-Json
    $findings = $Ast.FindAll({
            param($node)

            # Check for usage of ConvertTo-Json with -AsHashtable parameter
            if (
                $node -is [System.Management.Automation.Language.CommandAst] -and
                $node.CommandElements[0].Value -eq 'ConvertTo-Json' -and
                $node.CommandElements.Value -contains '-AsHashtable'
            ) {
                return [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord]::new(
                    'ConvertTo-Json in PowerShell 5.1 does not support the -AsHashtable parameter.', # Descriptive message about the issue
                    $node.Extent, # The extent (range) in the script file where the issue was found
                    'PSScriptAnalyzer_CustomRule_ConvertToJson', # Unique identifier for your custom rule
                    'Warning', # Severity of the issue (e.g., Warning, Error)
                    $null, # Name of the script file where the issue was found
                    'Workoho.Az.Automation.PS/.vscode/PSScriptAnalyzerCustomRules.ps1m' # Source of the rule (e.g., your custom rule module name)
                )
            }
            return $null
        }, $true)

    return $findings
}

# Custom rule to check for usage of Invoke-RestMethod
function PSScriptAnalyzer_CustomRule_InvokeRestMethod {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.Language.ScriptBlockAst] $Ast
    )

    # Check for usage of Invoke-RestMethod
    $findings = $Ast.FindAll({
            param($node)

            # Check for usage of Invoke-RestMethod with -SkipCertificateCheck parameter
            if (
                $node -is [System.Management.Automation.Language.CommandAst] -and
                $node.CommandElements[0].Value -eq 'Invoke-RestMethod' -and
                $node.CommandElements.Value -contains '-SkipCertificateCheck'
            ) {
                return [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord]::new(
                    'Invoke-RestMethod in PowerShell 5.1 does not support the -SkipCertificateCheck parameter.', # Descriptive message about the issue
                    $node.Extent, # The extent (range) in the script file where the issue was found
                    'PSScriptAnalyzer_CustomRule_InvokeRestMethod', # Unique identifier for your custom rule
                    'Warning', # Severity of the issue (e.g., Warning, Error)
                    $null, # Name of the script file where the issue was found
                    'Workoho.Az.Automation.PS/.vscode/PSScriptAnalyzerCustomRules.ps1m' # Source of the rule (e.g., your custom rule module name)
                )
            }

            # Check for usage of Invoke-RestMethod without -UseBasicParsing parameter
            if (
                $node -is [System.Management.Automation.Language.CommandAst] -and
                $node.CommandElements[0].Value -eq 'Invoke-RestMethod' -and
                $node.CommandElements.Value -notContains '-UseBasicParsing'
            ) {
                return [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord]::new(
                    'Invoke-RestMethod in PowerShell 5.1 should be used with the -UseBasicParsing parameter to avoid dependency on Internet Explorer.', # Descriptive message about the issue
                    $node.Extent, # The extent (range) in the script file where the issue was found
                    'PSScriptAnalyzer_CustomRule_InvokeRestMethod', # Unique identifier for your custom rule
                    'Warning', # Severity of the issue (e.g., Warning, Error)
                    $null, # Name of the script file where the issue was found
                    'Workoho.Az.Automation.PS/.vscode/PSScriptAnalyzerCustomRules.ps1m' # Source of the rule (e.g., your custom rule module name)
                )
            }
            return $null
        }, $true)

    return $findings
}

# Custom rule to check for usage of Invoke-WebRequest
function PSScriptAnalyzer_CustomRule_InvokeWebRequest {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.Language.ScriptBlockAst] $Ast
    )

    # Check for usage of Invoke-WebRequest
    $findings = $Ast.FindAll({
            param($node)

            # Check for usage of Invoke-WebRequest with -SkipCertificateCheck parameter
            if (
                $node -is [System.Management.Automation.Language.CommandAst] -and
                $node.CommandElements[0].Value -eq 'Invoke-WebRequest' -and
                $node.CommandElements.Value -contains '-SkipCertificateCheck'
            ) {
                return [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord]::new(
                    'Invoke-WebRequest in PowerShell 5.1 does not support the -SkipCertificateCheck parameter.', # Descriptive message about the issue
                    $node.Extent, # The extent (range) in the script file where the issue was found
                    'PSScriptAnalyzer_CustomRule_InvokeWebRequest', # Unique identifier for your custom rule
                    'Warning', # Severity of the issue (e.g., Warning, Error)
                    $null, # Name of the script file where the issue was found
                    'Workoho.Az.Automation.PS/.vscode/PSScriptAnalyzerCustomRules.ps1m' # Source of the rule (e.g., your custom rule module name)
                )
            }

            # Check for usage of Invoke-WebRequest without -UseBasicParsing parameter
            if (
                $node -is [System.Management.Automation.Language.CommandAst] -and
                $node.CommandElements[0].Value -eq 'Invoke-WebRequest' -and
                $node.CommandElements.Value -notContains '-UseBasicParsing'
            ) {
                return [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord]::new(
                    'Invoke-WebRequest in PowerShell 5.1 should be used with the -UseBasicParsing parameter to avoid dependency on Internet Explorer.', # Descriptive message about the issue
                    $node.Extent, # The extent (range) in the script file where the issue was found
                    'PSScriptAnalyzer_CustomRule_InvokeWebRequest', # Unique identifier for your custom rule
                    'Warning', # Severity of the issue (e.g., Warning, Error)
                    $null, # Name of the script file where the issue was found
                    'Workoho.Az.Automation.PS/.vscode/PSScriptAnalyzerCustomRules.ps1m' # Source of the rule (e.g., your custom rule module name)
                )
            }
            return $null
        }, $true)

    return $findings
}

# Custom rule to check for usage of New-Object
function PSScriptAnalyzer_CustomRule_NewObject {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.Language.ScriptBlockAst] $Ast
    )

    # Check for usage of New-Object
    $findings = $Ast.FindAll({
            param($node)

            # Check for usage of New-Object with -Property parameter
            if (
                $node -is [System.Management.Automation.Language.CommandAst] -and
                $node.CommandElements[0].Value -eq 'New-Object' -and
                $node.CommandElements.Value -contains '-Property'
            ) {
                # Get the argument to the -Property parameter
                $propertyArgument = $node.CommandElements[$node.CommandElements.IndexOf('-Property') + 1]
                # Check if the argument is a hashtable or psobject
                if ($propertyArgument.Type -is [System.Management.Automation.Language.HashtableAst] -or $propertyArgument.Type -is [System.Management.Automation.Language.PSObjectAst]) {
                    # Check if the hashtable or psobject contains properties with values of type psobject
                    foreach ($pair in $propertyArgument.Pairs) {
                        if ($pair.Value.Type -is [System.Management.Automation.Language.PSObjectAst]) {
                            return [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord]::new(
                                'New-Object in PowerShell 5.1 does not support the -Property parameter with a hashtable or psobject that contains properties with values of type psobject.', # Descriptive message about the issue
                                $node.Extent, # The extent (range) in the script file where the issue was found
                                'PSScriptAnalyzer_CustomRule_NewObject', # Unique identifier for your custom rule
                                'Warning', # Severity of the issue (e.g., Warning, Error)
                                $null, # Name of the script file where the issue was found
                                'Workoho.Az.Automation.PS/.vscode/PSScriptAnalyzerCustomRules.ps1m' # Source of the rule (e.g., your custom rule module name)
                            )
                        }
                    }
                }
            }
            return $null
        }, $true)

    return $findings
}

# Custom rule to check for usage of Newer Cmdlets not available in PS 5.1
function PSScriptAnalyzer_CustomRule_NewerCmdlets {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.Language.ScriptBlockAst] $Ast
    )

    $newerCmdlets = @('Get-Error', 'Get-ComputerInfo')

    # Check for usage of newer cmdlets not available in PS 5.1
    $findings = $Ast.FindAll({
            param($node)

            if ($node -is [System.Management.Automation.Language.CommandAst] -and $newerCmdlets -contains $node.CommandElements[0].Value) {
                return [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord]::new(
                    "Cmdlet '$($node.CommandElements[0].Value)' is not available in PowerShell 5.1.", # Descriptive message about the issue
                    $node.Extent, # The extent (range) in the script file where the issue was found
                    'PSScriptAnalyzer_CustomRule_NewerCmdlets', # Unique identifier for your custom rule
                    'Warning', # Severity of the issue (e.g., Warning, Error)
                    $null, # Name of the script file where the issue was found
                    'Workoho.Az.Automation.PS/.vscode/PSScriptAnalyzerCustomRules.ps1m' # Source of the rule (e.g., your custom rule module name)
                )
            }
            return $null
        }, $true)

    return $findings
}

# Custom rule to check for usage of Newer Methods not available in PS 5.1
function PSScriptAnalyzer_CustomRule_NewerMethods {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.Language.ScriptBlockAst] $Ast
    )

    $newerMethods = @('ToHashSet')

    # Check for usage of newer methods not available in PS 5.1
    $findings = $Ast.FindAll({
            param($node)

            if (
                $node -is [System.Management.Automation.Language.CommandAst] -and
                $newerMethods -contains $node.Method.MemberName
            ) {
                return [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord]::new(
                    "Method '$($node.Method.MemberName)' is not available in PowerShell 5.1.", # Descriptive message about the issue
                    $node.Extent, # The extent (range) in the script file where the issue was found
                    'PSScriptAnalyzer_CustomRule_NewerMethods', # Unique identifier for your custom rule
                    'Warning', # Severity of the issue (e.g., Warning, Error)
                    $null, # Name of the script file where the issue was found
                    'Workoho.Az.Automation.PS/.vscode/PSScriptAnalyzerCustomRules.ps1m' # Source of the rule (e.g., your custom rule module name)
                )
            }

            return $null
        }, $true)

    return $findings
}

# Custom rule to check for usage of Aliases
function PSScriptAnalyzer_CustomRule_AvoidAliases {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.Language.ScriptBlockAst] $Ast
    )

    $findings = $Ast.FindAll({
            param($node)

            if ($node -is [System.Management.Automation.Language.CommandAst]) {
                foreach ($commandElement in $node.CommandElements) {
                    if ($commandElement -is [System.Management.Automation.Language.StringConstantExpressionAst]) {
                        $aliasDefinition = Get-Alias -Name $commandElement.Value -ErrorAction SilentlyContinue
                        if ($aliasDefinition) {
                            return [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord]::new(
                                "Avoid using alias '$($commandElement.Value)' in scripts. Use the full cmdlet name instead.", # Descriptive message about the issue
                                $node.Extent, # The extent (range) in the script file where the issue was found
                                'PSScriptAnalyzer_CustomRule_AvoidAliases', # Unique identifier for your custom rule
                                'Warning', # Severity of the issue (e.g., Warning, Error)
                                $null, # Name of the script file where the issue was found
                                'Workoho.Az.Automation.PS/.vscode/PSScriptAnalyzerCustomRules.ps1m' # Source of the rule (e.g., your custom rule module name)
                            )
                        }
                    }
                }
            }

            return $null
        }, $true)

    return $findings
}

# Export the function as a rule for PSScriptAnalyzer
Export-ModuleMember -Function PSScriptAnalyzer_CustomRule_JoinPath
Export-ModuleMember -Function PSScriptAnalyzer_CustomRule_SplitPath
Export-ModuleMember -Function PSScriptAnalyzer_CustomRule_GetChildItem
Export-ModuleMember -Function PSScriptAnalyzer_CustomRule_ConvertToJson
Export-ModuleMember -Function PSScriptAnalyzer_CustomRule_InvokeRestMethod
Export-ModuleMember -Function PSScriptAnalyzer_CustomRule_InvokeWebRequest
Export-ModuleMember -Function PSScriptAnalyzer_CustomRule_NewObject
Export-ModuleMember -Function PSScriptAnalyzer_CustomRule_NewerCmdlets
Export-ModuleMember -Function PSScriptAnalyzer_CustomRule_NewerMethods
Export-ModuleMember -Function PSScriptAnalyzer_CustomRule_AvoidAliases
