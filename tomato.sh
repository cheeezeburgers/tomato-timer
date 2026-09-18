#!/usr/bin/env bash

# Source this file once (or add the source line to ~/.zshrc), then run:
#   tomato             # 20 minutes
#   tomato 1           # 1 minute
#   tomato 1 -s        # 1 minute, silent
#   tomato --help      # show all options

tomato_help() {
    printf '%s\n' \
        'Usage: tomato [minutes] [-s|--silent]' \
        '' \
        'Start a 20-minute timer, or provide a positive whole number of minutes.' \
        '' \
        'Options:' \
        '  -s, --silent   Disable the sound when the timer ends' \
        '  -h, --help     Show this help message' \
        '' \
        'Examples:' \
        '  tomato' \
        '  tomato 1' \
        '  tomato 1 --silent'
}

tomato() {
    local duration_minutes=20
    local silent=0
    local duration_set=0
    local arg

    while (( $# > 0 )); do
        arg=$1
        case "$arg" in
            -h|--help)
                tomato_help
                return 0
                ;;
            -s|--silent)
                silent=1
                ;;
            ''|*[!0-9]*)
                printf 'Usage: tomato [minutes] [-s|--silent]\n' >&2
                return 2
                ;;
            0)
                printf 'Minutes must be a positive whole number.\n' >&2
                return 2
                ;;
            *)
                if (( duration_set )); then
                    printf 'Specify the timer duration only once.\n' >&2
                    return 2
                fi
                duration_minutes=$arg
                duration_set=1
                ;;
        esac
        shift
    done

    local duration=$((duration_minutes * 60))
    local remaining=$duration
    local red=$'\033[31m'
    local reset=$'\033[0m'

    trap 'printf "\n%s\n" "Timer cancelled."; trap - INT; return 130 2>/dev/null || exit 130' INT

    while (( remaining > 0 )); do
        printf '\033[2J\033[H'
        printf '%s' "$red"
        printf '%s\n' \
            '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀' \
            '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀' \
            '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠻⣶⡆⠀⠿⠀⣶⠒⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀' \
            '⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣴⠾⠛⢹⣶⡤⢶⣿⡟⠶⠦⠄⠀⠀⠀⠀⠀⠀⠀⠀' \
            '⠀⠀⠀⠀⠀⣠⣶⣤⣤⣤⣤⣴⠂⠸⠋⢀⣄⡉⠓⠀⠲⣶⣾⣿⣷⣄⠀⠀⠀⠀' \
            '⠀⠀⠀⢀⣾⡿⠋⠁⣠⣤⣿⡟⢀⣠⣾⣿⣿⣿⣷⣶⣤⣼⣿⣿⣿⣿⣆⠀⠀⠀' \
            '⠀⠀⠀⣾⡟⠀⣰⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀' \
            '⠀⠀⢸⡿⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀' \
            '⠀⠀⢸⡇⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀' \
            '⠀⠀⢸⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀' \
            '⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀' \
            '⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀' \
            '⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀' \
            '⠀⠀⠀⠀⠀⠀⠉⠛⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠀⠀⠀⠀⠀⠀⠀' \
            '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'
        printf '%s' "$reset"
        printf '\nTime remaining: %02d:%02d\n' $((remaining / 60)) $((remaining % 60))
        sleep 1
        ((remaining--))
    done

    printf '\033[2J\033[H'
    if (( ! silent )); then
        printf '\a\a\a'
        if command -v afplay >/dev/null 2>&1; then
            afplay /System/Library/Sounds/Glass.aiff >/dev/null 2>&1 &
        fi
    fi
    printf '%s\n' '🍅 Time for a break: take a break, drink water, and go to the toilet.'
    trap - INT
}

# Also works when run directly: ./codex-test.sh
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    tomato "$@"
fi
