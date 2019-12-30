#!/bin/bash
for keytype in nnoremap inoremap; do
    for prefix in C S; do
        for letter in {a..z}; do
            echo "${keytype} <${prefix}-${letter}> <${prefix}-${letter}>"
        done
    done
done
