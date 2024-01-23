# Custom rule to check for usage of Join-Path
function PSScriptAnalyzer_CustomRule_JoinPath {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.Language.ScriptBlockAst] $Ast
    )

    # Check for usage of Join-Path and Split-Path
    $findings = $Ast.FindAll({
            param($node)

            # Check for usage of Join-Path with more than two arguments
            if ($node.CommandElements[0].Value -eq 'Join-Path' -and $node.CommandElements.Count -gt 3) {
                $violationMessage = "Join-Path in PowerShell 5.1 can only handle two paths."
                $extent = $node.Extent
                $diagnosticRecord = New-Object -TypeName Microsoft.Windows.PSScriptAnalyzer.Generic.DiagnosticRecord -ArgumentList $violationMessage, $extent, 'CustomRule', 'Warning', $null, $null
                return $diagnosticRecord
            }

            return $null
        }, $true)

    return $findings
}

function PSScriptAnalyzer_CustomRule_SplitPath {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.Language.ScriptBlockAst] $Ast
    )

    # Check for usage of Join-Path and Split-Path
    $findings = $Ast.FindAll({
            param($node)

            # Check for usage of Split-Path with -LeafBase parameter
            if ($node.CommandElements[0].Value -eq 'Split-Path' -and $node.CommandElements.Value -contains '-LeafBase') {
                $violationMessage = "Split-Path in PowerShell 5.1 does not support the -LeafBase parameter."
                $extent = $node.Extent
                $diagnosticRecord = New-Object -TypeName Microsoft.Windows.PSScriptAnalyzer.Generic.DiagnosticRecord -ArgumentList $violationMessage, $extent, 'CustomRule', 'Warning', $null, $null
                return $diagnosticRecord
            }

            return $null
        }, $true)

    return $findings
}

# Export the functions as a rule for PSScriptAnalyzer
Export-ModuleMember -Function PSScriptAnalyzer_CustomRule_JoinPath
Export-ModuleMember -Function PSScriptAnalyzer_CustomRule_SplitPath
