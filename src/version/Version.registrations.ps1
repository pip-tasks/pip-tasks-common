########################################################
##
## Version.registrations.ps1
## Pip.Tasks.Common - Common build tasks for Pip.Tasks
## Registrations for version control tasks 
##
#######################################################

$gittasks = "$PSScriptRoot/Git.tasks.ps1"

# Registrations for imperative tasks
Register-ImperativeInclude -CallFile $gittasks -Component -Workspace

# Registrations for declarative tasks
Register-DeclarativeTask -Task GetChangedComponents -Variable VersionControl -Value git -CallFile $gittasks -CallTask GitGetChangedComponents -Component -Workspace
Register-DeclarativeTask -Task GetChanges -Variable VersionControl -Value git -CallFile $gittasks -CallTask GitGetChanges -Component -Workspace
Register-DeclarativeTask -Task Pull -Variable VersionControl -Value git -CallFile $gittasks -CallTask GitPull -Component -Workspace
Register-DeclarativeTask -Task Push -Variable VersionControl -Value git -CallFile $gittasks -CallTask GitPush -Component -Workspace
Register-DeclarativeTask -Task Undo -Variable VersionControl -Value git -CallFile $gittasks -CallTask GitUndo -Component -Workspace
Register-DeclarativeTask -Task Clone -Variable VersionControl -Value git -CallFile $gittasks -CallTask GitClone -Workspace
