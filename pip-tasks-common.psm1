########################################################
##
## pip-tasks-common.psm1
## Pip.Tasks.Common - Common build tasks for Pip.Tasks
## Startup module
##
#######################################################

$path = $PSScriptRoot
if ($path -eq "") { $path = "." }

. "$path\src\version\Git.ps1"

. "$path\src\version\Version.registrations.ps1"
. "$path\src\deploy\Deploy.registrations.ps1"
