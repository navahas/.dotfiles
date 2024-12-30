function fish_prompt
    # Colors
    set -l color_green (set_color green)
    set -l color_red (set_color red)
    set -l color_blue (set_color blue)
    set -l color_grey (set_color 242)
    set -l color_reset (set_color normal)

    # Current directory
    set -l current_dir (string replace -r "^$HOME" "~" $PWD)
    echo -n $color_blue $current_dir $color_reset

    # Git status
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l git_branch (git branch --show-current)
        set -l git_dirty ""
        if not git diff --quiet --ignore-submodules >/dev/null 2>&1
            set git_dirty "*"
        end
        echo -n "$color_grey$git_branch$git_dirty $color_reset"
    end

    # Prompt symbol with your custom arrow
    if test $status -eq 0
        echo -n "$color_green  $color_reset"
    else
        echo -n "$color_red  $color_reset"
    end
end
