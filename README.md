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

## Options

Docs are somewhat missing, but these options are supported:

- `-u <username>` - query another user's jobs, default is own jobs
- `-a` - query all users jobs
- `-d <n>` - query jobs from the last `n` days
- `-n <job-name` - filter by job name
