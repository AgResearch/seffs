# seffs

Like `seff` but for multiple jobs.

Default behaviour is to show all the user's own jobs from today.

## Installation

Since this is an Elvish script it is best installed from its Nix flake.

Users without the ability to do that may run it directly from GitHub (best on login-1), for example:

```
login-1$ nix run github:AgResearch/seffs

login-1$ nix run github:AgResearch/seffs -- -a

login-1$ nix run github:AgResearch/seffs -- -a -d 3

login-1$ nix run github:AgResearch/seffs -- -a -d 3 -n gbs_prism
```

### eRI installer and environment module

The install script runs from a Nix flake, so all that is needed is the following.  Best done on `login-1` because that is the Nix head node (and so is much faster at building Nix derivations).  This installs into the main eRI software directory tree.

The module version is extracted from the flake URI by the install script.

```
login-1$ export FLAKE_URI='github:AgResearch/seffs?ref=refs/tags/0.1.0'

login-1$ nix run "${FLAKE_URI}#eri-install" -- $FLAKE_URI
```

To install in the user's home directory for testing:

```
login-1$ nix run "${FLAKE_URI}#eri-install" -- --home $FLAKE_URI
```



## Options

Docs are somewhat missing, but these options are supported:

- `-u <username>` - query another user's jobs, default is own jobs
- `-a` - query all users jobs
- `-d <n>` - query jobs from the last `n` days
- `-n <job-name` - filter by job name
