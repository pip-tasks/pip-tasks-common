########################################################
##
## Run.registrations.ps1
## Pip.Tasks.Common - Common build tasks for Pip.Tasks
## Registrations for run tasks 
##
#######################################################

$ptasks = "$PSScriptRoot/../utilities/Process.tasks.ps1"

# Registrations for declarative tasks
Register-DeclarativeTask -Task Start -Variable Run -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component -Workspace
Register-DeclarativeTask -Task Stop -Variable Run -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component -Workspace
Register-DeclarativeTask -Task Run -Variable Run -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component -Workspace
