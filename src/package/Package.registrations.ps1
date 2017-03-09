########################################################
##
## Package.registrations.ps1
## Pip.Tasks.Common - Common build tasks for Pip.Tasks
## Registrations for package management
##
#######################################################

$ptasks = "$PSScriptRoot/../utilities/Process.tasks.ps1"

# Registrations for declarative tasks
Register-DeclarativeTask -Task GetVersion -Variable Package -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component -Workspace
Register-DeclarativeTask -Task SetVersion -Variable Package -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component -Workspace
Register-DeclarativeTask -Task GetDep -Variable Package -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component -Workspace
Register-DeclarativeTask -Task CleanDep -Variable Package -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component -Workspace
Register-DeclarativeTask -Task InstallDep -Variable Package -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component -Workspace
Register-DeclarativeTask -Task UpdateDep -Variable Package -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component -Workspace
Register-DeclarativeTask -Task Publish -Variable Package -Value process -CallFile $ptasks -CallTask ProcessInvoke -Component -Workspace
