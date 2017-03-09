########################################################
##
## Process.tasks.ps1
## Pip.Tasks.Common - Common build tasks for Pip.Tasks
## Common build tasks
##
#######################################################

# Set correct path when invoked from other scripts
$BuildRoot = $BuildPath

# Synopsis: Starts Gulp project
task ProcessInvoke {
    $reg = Find-DeclarativeTask -Task $TaskName
    if ($reg -eq $null)
    {
        throw "Cannot find process task declaration"
    }

    $prefix = "$($reg.Variable)$TaskName"

    $commandVar = Get-Variable -Name "$($prefix)Command"
    $command = $commandVar.value

    $argumentsVar = Get-Variable -Name "$($prefix)Arguments" -ErrorAction Ignore
    $arguments = @()
    if ($argumentsVar -ne $null) { $arguments = $argumentsVar.value }

    $pathVar = Get-Variable -Name "$($prefix)Path" -ErrorAction Ignore
    $path = '.'
    if ($pathVar -ne $null) { $path = $pathVar.value }

    $checkVar = Get-Variable -Name "$($prefix)Check" -ErrorAction Ignore
    $check = $true
    if ($checkVar -ne $null) { $check = $checkVar.value }

    ">> $path/$command $arguments $check"

    Invoke-Process -Path $path -Command $command -Argument $arguments -ErrorCheck $check
}
