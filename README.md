# NixOS Dotfiles

NixOS configuration managed as a flake.

## update script

`system_update.sh` handles committing config changes, rebuilding the system, and optionally updating flake inputs and switching home-manager.

```
Usage: ./system_update.sh [options]

Options:
  -u, --update-inputs   Run 'nix flake update' before rebuilding
  -H, --home            Also run 'home-manager switch' after system rebuild
  -p, --push            Push to remote after a successful build
  -b, --boot            Switch on next boot instead of immediately
  -m, --message MSG     Commit message (default: auto-generated from changed files)
  -h, --help            Show this help
```

### Examples

Standard rebuild after editing config:
```sh
./system_update.sh
```

Update all flake inputs, rebuild, switch home-manager, and push:
```sh
./system_update.sh -u -H -p
```

Stage changes for next boot with a custom commit message:
```sh
./system_update.sh -b -m "switch to pipewire"
```
