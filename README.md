# nixos-configs
My personal NixOS system configs

The nixos/ directory is shared between all configs, it contains defaults and reusable snippets to accelerate the creation of system configs

## Why NixOS? ❄️

* Uses [Nix](https://nixos.org/guides/how-nix-works/), a powerful package manager and configuration system where everything is defined in **readable configuration files**.
* Lets you stay **stable and up to date at the same time**. You can use recent software without breaking your system.
* Makes setup **fully reproducible across machines**. You can recreate the same system anywhere from a single configuration.
* Changes are **explicit**. Your system only updates when you choose to apply changes.
* Updates are **safe and predictable**. If something fails during an update, it will not switch to the broken version.
* Software runs in **isolated environments**, preventing package conflicts.
* Supports **rollbacks and system history**. You can boot into previous working versions if something breaks.
* Keeps your system **minimal**. You only declare what you want, and dependencies are handled automatically.
* You can apply the same configuration repeatedly without causing **duplicates or unintended changes**.
