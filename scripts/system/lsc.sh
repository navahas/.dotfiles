#!/usr/bin/env bash

# lsc - ls with customizable column colors

LS_FLAGS="-gFh --color --no-group"

# Uses perl to preserve exact spacing from ls while adding colors
ls $LS_FLAGS "$@" | sed '/^total/d' | perl -pe '
    # Define colors
    @colors = (
        "\033[38;5;240m",  # Column 1
        "\033[38;5;241m",  # Column 2
        "\033[38;5;242m",  # Column 3
        "\033[38;5;243m",  # Column 4
        "\033[38;5;244m",  # Column 5
        "\033[38;5;245m",  # Column 6
        "\033[38;5;246m",  # Column 7 (if needed, e.g., with -i or -o flags)
        "\033[38;5;247m"  # Column 8 (if needed)
    );
    $reset = "\033[0m";

    # Split into fields but preserve spacing by matching non-space chunks
    my @fields = m/(\S+)/g;
    my $line = $_;

    # Color each field except the last one (filename with ls colors)
    for (my $i = 0; $i < @fields - 1 && $i < @colors; $i++) {
        my $field = quotemeta($fields[$i]);
        # Replace first occurrence, handling any character boundaries
        $line =~ s/(?<!\S)$field(?!\S)/$colors[$i]$fields[$i]$reset/;
    }

    $_ = $line;
'
