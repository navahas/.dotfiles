function fman
    # man -k . | awk '{print $1}' | sed 's/(.*//' | sort -u | fzf | xargs man
    man -k . | 
    awk '{print $1}' | 
    sed 's/(.*//' | 
    sort -u | 
    fzf | 
    xargs -I {} sh -c 'man {} | col -bx | bat --style=plain --language=man --paging=always'
end
