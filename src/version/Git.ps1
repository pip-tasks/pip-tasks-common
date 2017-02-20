########################################################
##
## Git.ps1
## Pip.Tasks.Common - Common build tasks for Pip.Tasks
## Git commands
##
#######################################################

function Out-GitRepo
{
<#
.SYNOPSIS

Clones component repository

.DESCRIPTION

Out-GitRepo clones component repository into the Path

.PARAMETER Path

Path where to clone the repository (default: .)

.PARAMETER Uri

Uri of the component repository

.EXAMPLE

PS> Out-GitRepo -Path . -Uri "https://github.com/pip-tasks/pip-tasks-ps.git"

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName=$true)]
        [string] $Path = '.',

        [Parameter(Mandatory=$true, Position=1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri
    )
    begin {}
    process 
    {
        Invoke-At $Path {
            # Invoke-External { git clone $Uri } "Cloning git repository failed"
            git clone $Uri
        }
    }
    end {}
}


function Pop-GitChanges
{
<#
.SYNOPSIS

Pulls component from git repository

.DESCRIPTION

Pop-GitChanges pulls changed for specified component from remote git repository

.PARAMETER Path

The Path to git local repository (default: .)

.EXAMPLE

PS> Pop-GitChanges -Path .

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Path = '.'
    )
    begin {}
    process 
    {
        Invoke-At $Path {
            # Invoke-External { git pull } "Failed to pull changed from git"
            git pull
        }
    }
    end {}
}


function Push-GitChanges
{
<#
.SYNOPSIS

Pushes component changes

.DESCRIPTION

Push-GitChanges commits component changes locally and pushes into remote git repository

.PARAMETER Path

The path to local git repository (default: .)

.PARAMETER Message

Commit message

.EXAMPLE

PS> Push-GitChanges -Path "./Integration.Adapter" -Message "Minor changes"

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Path = '.',

        [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Message
    )
    begin {}
    process 
    {
        Invoke-At $Path {
            # Invoke-External { git add -A . } "Failed to add files to git"
            # Invoke-External { git commit -am "'$Message'" } "Failed to commit local changes to git"
            # Invoke-External { git push } "Failed to pull changed from git"

            git add -A .
            git commit -am "'$Message'"
            git push
        }
    }
    end {}
}


function Get-GitChanges
{
<#
.SYNOPSIS

Gets component changes

.DESCRIPTION

Get-GitChanges gets component changes at the local git repository

.PARAMETER Path

The Path to git local repository (default: .)

.EXAMPLE

PS> Get-GitChanges -Path .

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Path = '.'
    )
    begin {}
    process 
    {
        Invoke-At $Path {
            #$diff = Invoke-External { git diff } "Failed to get diff from git"
            $diff = git diff
            
            if ($diff -ne $null)
            {
                # $diff = Invoke-External { git diff --stat --minimal }
                $diff = git diff --stat --minimal
            }

            if ($diff -ne $null)
            {
                Write-Output $diff
            }
        }
    }
    end {}
}


function Undo-GitChanges
{
<#
.SYNOPSIS

Reverts local component changes

.DESCRIPTION

Undo-GitChanges reverts all changed made in local git repository

.PARAMETER Path

The Path to git local repository (default: .)

.EXAMPLE

PS> Undo-GitChanges -Path .

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Path = '.'
    )
    begin {}
    process 
    {
        Invoke-At $Path {
            # Invoke-External { git reset --hard } "Failed to reset changes"
            # Invoke-External { git clean -r -d } "Failed to clean untracked files"
            # #Invoke-External { git checkout . } "Failed to checkout"

            git reset --hard
            git clean -f -d
        }
    }
    end {}
}


function Test-GitChanges
{
<#
.SYNOPSIS

Checks if component was changed

.DESCRIPTION

Test-GitChanges checks if component local git repository was changed

.PARAMETER Path

The Path to git local repository (default: .)

.EXAMPLE

PS> Test-GitChanges -Path .

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Path = '.'
    )
    begin {}
    process 
    {
        Invoke-At $Path {
            #$diff = Invoke-External { git diff --stat --minimal } "Failed to check diff from git"
            $diff = git diff --stat --minimal
            return $diff -ne $null -and $diff -ne ''
        }
    }
    end {}
}
