#!/usr/bin/env bash

hyperfine -w 200 -m 1000 -N 'fish -i -c exit' \
    'zsh -i -c exit' \
    'bash -i -c exit'
