# Building nixos when unstable is broken

For the last several days nixos unstable channel has had build failures.
You can check the [status of nixos channels here](https://status.nixos.org/).
And the builds of [nixos unstable here](https://hydra.nixos.org/jobset/nixos/trunk-combined).

Following the [nixos cheatsheet I rebuilt my nixos from my own cloned copy of nixpkgs](https://nixos.wiki/wiki/Cheatsheet#Build_nixos_from_nixpkgs_repo).
I checked out a commit prior to the recent build failures and then ran the following:

```sh
nixos-rebuild -I nixpkgs=/path/to/nixpkgs boot
```
