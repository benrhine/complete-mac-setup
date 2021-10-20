#!/usr/bin/env bash
# ==============================================================================================================
# Scripting language support for local environment
# ==============================================================================================================
LANGUAGE_SUPPORT=(
    go
    markdown
    node
    npm
    postgresql
    python
    python3
    pypy
    rabbitmq
    ruby
    yarn
)

echo "Installing language support packages..."

for val in "${LANGUAGE_SUPPORT[@]}"; do
    brew install $val || simpleError "$val"
done

echo "Language support installed"