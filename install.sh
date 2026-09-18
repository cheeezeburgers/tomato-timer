#!/usr/bin/env bash

set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
install_dir="$HOME/.local/bin"
target="$install_dir/tomato"

mkdir -p "$install_dir"

install -m 755 "$script_dir/tomato.sh" "$target"

printf '[ OK ] Installed tomato → %s\n' "$target"

case ":$PATH:" in
    *":$install_dir:"*) ;;
    *)
        yellow=$(printf '\033[33m')
        reset=$(printf '\033[0m')

        printf '\n%sAdd ~/.local/bin to your PATH if it is not already there.%s\n' \
            "$yellow" "$reset"
        printf '%sFor zsh (the default shell on macOS):%s\n\n' \
            "$yellow" "$reset"

        printf '%s%s%s\n' \
            "$yellow" \
            '  export PATH="$HOME/.local/bin:$PATH"' \
            "$reset"

        printf '\n%sThen run:%s\n' "$yellow" "$reset"
        printf '%s  source ~/.zshrc%s\n' "$yellow" "$reset"

        printf '\n%sFor Bash, add the same line to ~/.bashrc and run source ~/.bashrc.%s\n' \
            "$yellow" "$reset"
        ;;
esac
