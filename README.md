# <img src="https://github.com/pip-tasks/pip-tasks/raw/master/artifacts/logo.png" alt="Pip.Devs Logo" style="max-width:30%"> <br/> Common build tasks for Pip.Tasks

This Powershell module contains common tasks [Pip.Tasks](https://github.com/pip-tasks/pip-tasks) that can be use in components implemented in different languages.

### Git version control tasks

Git tasks:
* **Clone** - cloning Git component repositories in workspace. Repositories are defined in **VersionControlRepos** variable
* **GetChangedComponents** - lists all components with pending changed in the workspace 
* **GetChanges** - lists of changes in git repository
* **Pull** - pulls changes from remote git repository
* **Push** - commits changes and pushes them to remote git repository
  - **Message** - comment for 
* **Undo** - reverts all changes in local git repository

Git configuration variables:
* **VersionControl** - Turns on git tasks (must be 'git')
* **VersionControlRepos** - List with URLs of git repositories for **Clone** task

## Installation

* Checkout **pip-tasks** and **pip-tasks-common** modules
* Add folder with the modules to **PSModulePath**
* Import **pip-tasks-common** module. **pip-tasks** will be imported automatically

## Usage

A typical usage scenario to with common tasks:

* Set a default workspace
```powershell
> Use-Workspace -Path <path to workspace>
```

* Clone component repositories
```powershell
> Invoke-Task -Task Clone -Workspace
```

* Pull latest changes for all components
```powershell
> Invoke-Task -Task Pull -All
```

* Get changed components
```powershell
> Invoke-Task -Task GetChangedComponents -Workspace
```

* Get changes across all components
```powershell
> Invoke-Task -Task GetChanges -All
```

* Undo uncommited changed for component1
```powershell
> Invoke-Task -Task Undo -Component component1
```

** Commit and push changes for across all components and workspace
```powershell
> Invoke-Task -Task Push -Message "My changes" -Global
```

## Acknowledgements

This module created and maintained by **Sergey Seroukhov**.
