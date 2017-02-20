########################################################
##
## Deploy.registrations.ps1
## Pip.Tasks.Common - Common build tasks for Pip.Tasks
## Registrations for deployment tasks 
##
#######################################################

# $dtasks = "$PSScriptRoot/Docker.tasks.ps1"

# # Registrations for imperative tasks
# Register-ImperativeInclude -CallFile $dtasks -Component

# # Registrations for declarative tasks
# Register-DeclarativeTask -Task Deploy -Variable Deploy -Value docker -CallFile $dtasks -CallTask DockerDeploy -Component
# Register-DeclarativeTask -Task Undeploy -Variable Deploy -Value docker -CallFile $dtasks -CallTask DockerUndeploy -Component
# Register-DeclarativeTask -Task GetDeployedComponents -Variable Deploy -Value docker -CallFile $dtasks -CallTask DockerGetDeployedComponents -Component -Workspace
# Register-DeclarativeTask -Task ResetServer -Variable Deploy -Value docker -CallFile $dtasks -CallTask DockerResetServer -Component -Workspace
