function cdf
    set selected_dir (bash $HOME/.local/scripts/cd-fzf.sh)
    if test -n "$selected_dir"
        cd "$selected_dir"
    end
end
