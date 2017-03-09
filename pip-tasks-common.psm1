########################################################
##
## pip-tasks-common.psm1
## Pip.Tasks.Common - Common build tasks for Pip.Tasks
## Startup module
##
#######################################################

$path = $PSScriptRoot
if ($path -eq "") { $path = "." }

. "$path\src\utilities\Process.ps1"
. "$path\src\version\Git.ps1"

. "$path\src\version\Version.registrations.ps1"
. "$path\src\package\Package.registrations.ps1"
. "$path\src\build\Build.registrations.ps1"
. "$path\src\bundle\Bundle.registrations.ps1"
. "$path\src\deploy\Deploy.registrations.ps1"
. "$path\src\run\Run.registrations.ps1"
