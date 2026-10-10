#!/usr/bin/env nu

def main [
    --update-inputs (-u)  # Run 'nix flake update' before rebuilding
    --home (-H)           # Also run 'home-manager switch' after system rebuild
    --push (-p)           # Push to remote after a successful build
    --boot (-b)           # Switch on next boot instead of immediately
    --message (-m): string = ""  # Commit message (default: auto-generated)
] {
    let flake_dir = ($env.CURRENT_FILE | path dirname)
    let rebuild_mode = if $boot { "boot" } else { "switch" }

    cd $flake_dir

    # Step 1: Update flake inputs if requested
    if $update_inputs {
        print ">> Updating flake inputs..."
        nix flake update
    }

    # Step 2: Commit any changes
    git add -A
    let staged = (git diff --cached --name-only | str trim)
    if ($staged | is-not-empty) {
        let commit_msg = if ($message | is-empty) {
            let changed = ($staged | lines | str join " ")
            let date = (date now | format date "%Y-%m-%d")
            $"update: ($changed) \(($date)\)"
        } else {
            $message
        }
        git commit -m $commit_msg
    } else {
        print ">> No changes to commit."
    }

    # Step 3: Rebuild NixOS
    print $">> Running nixos-rebuild ($rebuild_mode)..."
    try {
        nixos-rebuild $rebuild_mode --sudo --flake .#nixos
    } catch {
        print "!! nixos-rebuild failed. Aborting."
        exit 1
    }

    let gen = (nixos-rebuild list-generations --json | from json | where current | first | get generation)
    print $">> System rebuild successful \(generation ($gen)\)."

    # Step 4: Home Manager
    if $home {
        print ">> Running home-manager switch..."
        try {
            home-manager switch --flake .#alex
        } catch {
            print "!! home-manager switch failed."
            exit 1
        }
        print ">> Home Manager switch successful."
    }

    # Step 5: Push
    if $push {
        print ">> Pushing to remote..."
        git push
    }

    print ">> Done."
}
