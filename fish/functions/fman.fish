function fman
    set query (rg --files $HOME/man/share/man | sed "s|$HOME/man/share/man/||" | fzf)
    if test -n "$query"
        env MANWIDTH=$COLUMNS man -l "$HOME/man/share/man/$query" 2>/dev/null | \
            col -bx | \
            bat --style=plain --language=man --paging=always
    end
end
