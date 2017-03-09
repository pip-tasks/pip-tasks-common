########################################################
##
## Build.registrations.ps1
## Pip.Tasks.Common - Common build tasks for Pip.Tasks
## Registrations for build tasks 
##
#######################################################

$ptasks = "$PSScriptRoot/../utilities/Process.tasks.ps1"

# Registrations for declarative tasks
Register-DeclarativeTask -Task Clean -Variable Build -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component
Register-DeclarativeTask -Task Build -Variable Build -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component
Register-DeclarativeTask -Task Rebuild -Variable Build -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component
Register-DeclarativeTask -Task Watch -Variable Build -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component
