# NIXOS

```bash
# List available generations (system snapshots)
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
# -lt with t to view dates in order -> sort new first
ls -lt /nix/var/nix/profiles/system-*-link


# Delete all but the last 10 generations
sudo nix-collect-garbage --delete-older-than 10
##### Or delete generations older than 30 days
sudo nix-collect-garbage --delete-older-than 30d
##### Or keep only the last 5 generations
sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +5
##### Run garbage collection to remove unreferenced store paths
sudo nix-collect-garbage -d
# Then optimize the store (deduplicates files)
nix-store --optimise


# Roll back to a generation
sudo nix-env --switch-generation 0 --profile /nix/var/nix/profiles/system
```

