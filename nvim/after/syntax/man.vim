" C/POSIX primitive types
syntax keyword manApiType
            \ int char void long short unsigned signed float double
            \ size_t ssize_t off_t pid_t uid_t gid_t mode_t dev_t ino_t nlink_t
            \ uint8_t uint16_t uint32_t uint64_t
            \ int8_t int16_t int32_t int64_t
            \ uintptr_t intptr_t ptrdiff_t wchar_t wint_t
            \ struct enum union FILE DIR

" Null/boolean constants
syntax keyword manApiNull NULL nullptr true false

" Flags/macros with underscore: O_RDONLY, AF_INET, MAP_SHARED, SA_RESTART
syntax match manApiConst display '\<[A-Z][A-Z0-9]*_[A-Z0-9_]\+\>'

" errno codes: EINVAL, ENOENT, EPERM, EACCES...
syntax match manApiErrno display '\<E[A-Z0-9]\{2,\}\>'

" Signal names: SIGTERM, SIGKILL, SIGCHLD...
syntax match manApiSignal display '\<SIG[A-Z0-9]\+\>'

" Hex literals (common in flags/addresses): 0x7fffffff
syntax match manApiNumber display '\<0[xX][0-9a-fA-F]\+\>'

" Re-assert section headings last so they win over manApiConst on heading lines
syntax match manSectionHeading display '^\S.*$'
syntax match manSubHeading     display '^ \{3\}\S.*$'

highlight default link manApiType     Type
highlight default link manApiNull     Special
highlight default link manApiConst    Constant
highlight default link manApiErrno    DiagnosticWarn
highlight default link manApiSignal   DiagnosticInfo
highlight default link manApiNumber   Number
