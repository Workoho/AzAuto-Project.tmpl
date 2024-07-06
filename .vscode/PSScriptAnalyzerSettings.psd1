@{
    # Use Severity when you want to limit the generated diagnostic records to a
    # subset of: Error, Warning and Information.
    # Uncomment the following line if you only want Errors and Warnings but
    # not Information diagnostic records.
    Severity       = @('Error', 'Warning')

    # Use IncludeRules when you want to run only a subset of the default rule set.
    #IncludeRules = @('PSAvoidDefaultValueSwitchParameter',
    #                 'PSMissingModuleManifestField',
    #                 'PSReservedCmdletChar',
    #                 'PSReservedParams',
    #                 'PSShouldProcess',
    #                 'PSUseApprovedVerbs',
    #                 'PSUseDeclaredVarsMoreThanAssigments')

    # Use ExcludeRules when you want to run most of the default set of rules except
    # for a few rules you wish to "exclude".  Note: if a rule is in both IncludeRules
    # and ExcludeRules, the rule will be excluded.
    ExcludeRules   = @('PSAvoidUsingWriteHost')

    CustomRulePath = @(
        # Path to the custom rule module
        '.vscode/PSScriptAnalyzerCustomRules.psm1'
    )

    # You can use the following entry to supply parameters to rules that take parameters.
    # For instance, the PSAvoidUsingCmdletAliases rule takes a whitelist for aliases you
    # want to allow.
    Rules          = @{
        PSAvoidUsingCmdletAliases = @{
            Enable    = $true
            # Do not flag 'cd' alias.
            Whitelist = @('cd')
        }

        PSUseCompatibleCmdlets    = @{
            Enable        = $true
            compatibility = @(
                'desktop-5.1.14393.206-windows'
                'core-6.1.0-windows'
                'core-6.1.0-linux'
                'core-6.1.0-linux-arm'
                'core-6.1.0-macos'
            )
        }

        PSUseCompatibleCommands   = @{
            Enable         = $true
            TargetProfiles = @(
                'win-48_x64_10.0.17763.0_5.1.17763.316_x64_4.0.30319.42000_framework'
                'win-4_x64_10.0.17763.0_6.2.4_x64_3.1.2_core'
                'ubuntu_x64_18.04_7.0.0_x64_3.1.2_core'
            )
            IgnoreCommands = @(
                'Install-Module'
                'Install-PSResource'
            )
        }

        PSUseCompatibleSyntax     = @{
            Enable         = $true
            TargetVersions = @(
                '5.1'
                '7.2'
            )
        }

        PSUseCompatibleTypes      = @{
            Enable         = $true
            TargetProfiles = @(
                'win-48_x64_10.0.17763.0_5.1.17763.316_x64_4.0.30319.42000_framework'
                'win-4_x64_10.0.17763.0_6.2.4_x64_3.1.2_core'
                'ubuntu_x64_18.04_7.0.0_x64_3.1.2_core'
            )
            IgnoreTypes    = @(
                'System.IO.Compression.ZipFile'
            )
        }
    }
}
