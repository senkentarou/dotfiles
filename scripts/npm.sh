#!/bin/bash

install_by_npm() {
    local npms=('typescript' 'typescript-language-server' 'yaml-language-server' 'eslint_d')

    echo 'Install npm packages'
    for n in ${npms[@]}; do
        npm install -g $n
    done

    return 0
}

install_by_npm
