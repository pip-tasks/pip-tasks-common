# <img src="https://github.com/pip-tasks/pip-tasks-ps/raw/master/artifacts/logo.png" alt="Pip.Devs Logo" style="max-width:30%"> <br/> Common build tasks for Pip.Tasks

This Powershell module brings commonly used build tasks into the Pip.Tasks build system

**Git** tasks turned on by property **$VersionControl = 'git'**
* **Clone** - cloning Git component repositories in workspace. Repositories are stored as array in **VersionControlRepos** property
* **GetChangedComponents** - lists all components with pending changed in the workspace 
* **GetChanges** - lists of changes in git repository
* **Pull** - pulls changes from remote git repository
* **Push** - commits changes with comment defined by **Message** property and pushes them to remote git repository
* **Undo** - reverts all changes in local git repository

**NPM** tasks turned on by property **$Package = 'npm'**
* **CleanDep** - cleans packages with NPM dependencies
* **RestoreDep** - downloads NPM packages references by projects 
* **UpdateDep** - updates selected package or all packages from specified source to the latest compatible version

**Bower** tasks turned on by property **$Package = 'bower'**
* **CleanDep** - cleans packages with Bower dependencies
* **RestoreDep** - downloads Bower packages references by projects 
* **UpdateDep** - updates selected package or all packages from specified source to the latest compatible version

**Gulp** tasks turned on by property **$Build = 'gulp'**
* **Clean** - cleans projects with Gulp (gulp clean)
* **Build** - builds projects  with Gulp (gulp clean)
* **Rebuild** - rebuilds projects with Gulp (gulp rebuild)
* **Watch** - watches for changes in projects and builds them with Gulp (gulp watch)
* **Run** - runs projects with Gulp (gulp launch)

## Installation

* Checkout **pip-tasks-ps** and **pip-tasks-common-ps** modules
* Add folder with the modules to **PSModulePath**
* Import **pip-tasks-common-ps** module. **pip-tasks-ps** will be imported automatically

## Usage

TBD...

## Acknowledgements

This module created and maintained by **Sergey Seroukhov** and **Volodymyr Tkachenko**.
