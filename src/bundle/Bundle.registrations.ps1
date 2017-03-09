########################################################
##
## Bundle.registrations.ps1
## Pip.Tasks.Common - Common build tasks for Pip.Tasks
## Registrations for bundling
##
#######################################################

$ptasks = "$PSScriptRoot/../utilities/Process.tasks.ps1"

# Registrations for declarative tasks
Register-DeclarativeTask -Task CleanBundle -Variable Bundle -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component -Workspace
Register-DeclarativeTask -Task Bundle -Variable Bundle -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component -Workspace
Register-DeclarativeTask -Task CopyBundle -Variable Bundle -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component -Workspace
