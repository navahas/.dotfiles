function fman
    set base ~/man/share/man
    set f (find $base -type f | string replace "$base/" "" | fzf)
    test -n "$f"; and man -l $base/$f
end
