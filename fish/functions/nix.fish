function nix
    if test "$argv[1]" = shell
        set -x IN_NIX_SHELL 1
        command nix $argv
    else
        command nix $argv
    end
end
