@{
    ModuleVersion = '1.0.0'     # This is the version of the framework you want to use. Only used if GitReference is set to 'ModuleVersion'.
    Author        = 'Azure Automation Common Runbook Framework'
    Description   = 'Main configuration file child project using the Azure Automation Common Runbook Framework.'
    PrivateData   = @{
        # GitReference can be one of the following:
        # 1. 'ModuleVersion' (see value above in the ModuleVersion key of this file)
        # 2. 'LatestRelease' (ignores ModuleVersion but detects latest release version automatically as it is released)
        # 3. 'latest' (will go to the latest commit of the branch to give you the latest code, but may be unstable)
        # 4. A Git commit hash or branch name (if you know what you're doing and want to pin to a specific commit or branch)
        GitReference           = 'ModuleVersion'

        # GitRepositoryUrl must be a valid Git repository URL. You likely don't want to change this unless you're forking the framework.
        GitRepositoryUrl       = 'https://github.com/Workoho/AzAuto-Common-Runbook-FW.git'

        # Files belonging to the framework are usually symlinked to the child project to keep them up to date.
        # On Windows, this requires Linked Connections to be enabled, or manually running the Update-AzAutoFWProjectRunbooks.ps1 script as an administrator.
        # If you would like to enforce using symlinks on Windows in any case, set this to $true.
        EnforceSymlink         = $false

        # In rare cases, common runbooks may be copied instead of using symbolic links.
        # If you set $EnforceSymlink to $true but still would like to copy the runbooks, set this to $true.
        CopyRunbooks           = $false

        # If you enabled CopyRunbooks, or Windows is not enabled for symlinks, common runbooks are automatically updated when the
        # Update-AzAutoFWProjectRunbooks.ps1 script is run.
        # In case you want to update them manually, you can set this to $true. That way, you may keep changes you made to the runbooks.
        # Please note that you will need to manually keep track of updates to the common runbooks and apply them yourself.
        # We recommend that you instead write your own runbooks that call the common runbooks, so that you can update the common runbooks
        # updates automatically.
        UpdateRunbooksManually = $false
    }
}
