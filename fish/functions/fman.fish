function fman
    set query (rg --files $HOME/man/share/man | sed "s|$HOME/man/share/man/||" | fzf)
    if test -n "$query"
        GROFF_NO_SGR=1 man -l "$HOME/man/share/man/$query" | \
        col -bx | \
        bat --theme=OneHalfDark --style=plain --language=man --paging=always
    end
end
