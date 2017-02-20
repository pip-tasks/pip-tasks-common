########################################################
##
## Git.tasks.ps1
## Pip.Tasks.Common - Common build tasks for Pip.Tasks
## Git build tasks
##
#######################################################

# Set correct path when invoked from other scripts
$BuildRoot = $BuildPath

# Synopsis: Clones git repositories
task GitClone {
    assert ($VersionControlRepos -ne $null) "VersionControlRepos are not set"

    foreach ($r in $VersionControlRepos)
    {        
        Out-GitRepo -Path . -Uri $r
    }
}

# Synopsis: Pulls changes from remote git repository
task GitPull {
    Pop-GitChanges -Path .
}

# Synopsis: Pushes changes to remote git repository
task GitPush {
    assert ($Message -ne $null) "Message is not set"

    Push-GitChanges -Path . -Message $Message
}

# Synopsis: Pulls changes from remote git repository
task GitUndo {
    Undo-GitChanges -Path .
}

# Synopsis: Get changes
task GitGetChanges {
    Get-GitChanges -Path .
}

# Synopsis: Get changed components
task GitGetChangedComponents {
    $ws = Find-Workspace -Path .
    $Components = Get-Components -Path $ws
    foreach ($c in $Components)
    {
        if (Test-GitChanges -Path "$ws/$c")
        {
            Write-Host $c
        }
    }
}
