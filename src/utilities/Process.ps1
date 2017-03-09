########################################################
##
## Process.ps1
## Pip.Tasks.Common - Common build tasks for Pip.Tasks
## Process commands
##
#######################################################

function Invoke-Process
{
<#
.SYNOPSIS

Launches external process

.DESCRIPTION

Invoke-Process launches external process with arguments

.PARAMETER Path

Path where to execute process (default: .)

.PARAMETER Command

External command to execute

.PARAMETER Argument

Array of command arguments

.PARAMETER NoCheck

Turns off checking for exit code

.EXAMPLE

PS> Invoke-Process -Path . -Command node -Argument app.js -NoCheck

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName=$true)]
        [string] $Path = '.',
        [Parameter(Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
        [string] $Command,
        [Parameter(Mandatory=$false, Position=2, ValueFromPipelineByPropertyName=$true)]
        [string[]] $Argument = @(),
        [Parameter(Mandatory=$false, Position=3, ValueFromPipelineByPropertyName=$true)]
        [bool] $ErrorCheck = $true
    )
    begin {}
    process 
    {
        Invoke-At $Path {
            if ($ErrorCheck) {
                Invoke-External { 
                    & $Command @Argument
                } "Failed to execute command"
            }
            else
            {
                & $Command @Argument
            }
        }
    }
    end {}
}
