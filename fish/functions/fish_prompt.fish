function fish_prompt
    set -l last_status $status

    # Colors
    set -l color_blue (set_color blue)
    set -l color_green (set_color green)
    set -l color_red (set_color red)
    set -l color_grey (set_color 868686)

    set -l color_reset (set_color normal)

    # Current directory
    # set -l current_dir (string replace -r "^$HOME" "~" $PWD)
    # echo -n $color_blue $current_dir $color_reset

    # Shorten path to last 2 dirs (~/…/dir1/dir2)
    set -l path (string replace -r "^$HOME" "~" $PWD)
    set -l parts (string split "/" $path)
    set -l count (count $parts)

    if test $count -le 3
        set show $path
    else
        set -l last2 $parts[-2..-1]
        # set show "~"/"…"/$last2[1]/$last2[2]
        # set show "~"/"…"/$last2[2]
        set show "[$last2[1]::$last2[2]]"
    end

    echo -n $color_blue$show $color_reset

    # Git status
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l git_branch (git branch --show-current)
        set -l git_dirty ""

        # Fix: Use command substitution without test
        set -l git_status (git status --porcelain 2>/dev/null | string collect)
        if test -n "$git_status"
            set git_dirty "*"
        end

        # set -l is_worktree (git rev-parse --git-path worktrees 2>/dev/null)
        
        # if test -d "$is_worktree"
        #     # Worktree → omit branch name
        #     echo -n "$color_grey$git_dirty $color_reset"
        # else
        #     # Normal repo → show branch name
        #     echo -n "$color_grey$git_branch$git_dirty $color_reset"
        # end

        echo -n "$color_grey$git_branch$git_dirty $color_reset"
    end

    # Prompt symbol with your custom arrow
    if test $last_status -ne 0
       echo -n "$color_red"\["$last_status"\]"   $color_reset"
       # echo -n "$color_red"\["$last_status"\]"   $color_reset"
    else
       echo -n "$color_green  $color_reset"
       # echo -n "$color_green  $color_reset"
    end
end
