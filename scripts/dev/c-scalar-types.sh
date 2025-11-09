#!/usr/bin/env bash

cat <<'EOF' | column -t -s '|'
Level|Name|Category|Where|printf
0|size_t|Unsigned|<stddef.h>|%zu %zx
0|double|Floating|Built in|%e %f %g %a
0|signed (int)|Signed|Built in|%d
0|unsigned|Unsigned|Built in|%b %o %u %x
0|bool (_Bool)|Unsigned|Built in (since C23)|%d (0 or 1)
1|ptrdiff_t|Signed|<stddef.h>|%td
1|char const*|String|Built in|%s
1|char|Character|Built in|%c
1|void*|Pointer|Built in|%p
2|unsigned char|Unsigned|Built in|%hhu %02hhx
EOF
