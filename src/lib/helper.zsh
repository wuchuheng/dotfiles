##
# Copy the content to the clipboard.
# @Docs: clipboard: Copy the content to the clipboard.
##
function clipboard() {
    local content="$1"
    local os="$(uname -s 2>/dev/null)"

    case "${os}" in
        (Darwin)
            if command -v pbcopy >/dev/null 2>&1; then
                if printf '%s' "$content" | pbcopy >/dev/null 2>&1; then
                    return 0
                fi
            fi
            ;;
        (Linux)
            if [[ -n "${WAYLAND_DISPLAY}" ]] && command -v wl-copy >/dev/null 2>&1; then
                if printf '%s' "$content" | wl-copy >/dev/null 2>&1; then
                    return 0
                fi
            fi
            if [[ -n "${DISPLAY}" ]] && command -v xclip >/dev/null 2>&1; then
                if printf '%s' "$content" | xclip -selection clipboard >/dev/null 2>&1; then
                    return 0
                fi
            fi
            if [[ -n "${DISPLAY}" ]] && command -v xsel >/dev/null 2>&1; then
                if printf '%s' "$content" | xsel --clipboard --input >/dev/null 2>&1; then
                    return 0
                fi
            fi
            ;;
        (MINGW*|MSYS*|CYGWIN*)
            if command -v clip.exe >/dev/null 2>&1; then
                if printf '%s' "$content" | clip.exe >/dev/null 2>&1; then
                    return 0
                fi
            fi
            ;;
    esac

    # Windows / WSL specific helpers.
    if command -v win32yank.exe >/dev/null 2>&1; then
        if printf '%s' "$content" | win32yank.exe -i >/dev/null 2>&1; then
            return 0
        fi
    fi
    if [[ "${os}" == "Linux" ]] && command -v clip.exe >/dev/null 2>&1; then
        if printf '%s' "$content" | clip.exe >/dev/null 2>&1; then
            return 0
        fi
    fi

    # Fallback to any clipboard utility we can find.
    if command -v pbcopy >/dev/null 2>&1; then
        if printf '%s' "$content" | pbcopy >/dev/null 2>&1; then
            return 0
        fi
    fi
    if command -v xclip >/dev/null 2>&1; then
        if printf '%s' "$content" | xclip -selection clipboard >/dev/null 2>&1; then
            return 0
        fi
    fi
    if command -v xsel >/dev/null 2>&1; then
        if printf '%s' "$content" | xsel --clipboard --input >/dev/null 2>&1; then
            return 0
        fi
    fi
    if command -v clip.exe >/dev/null 2>&1; then
        if printf '%s' "$content" | clip.exe >/dev/null 2>&1; then
            return 0
        fi
    fi

    # OSC52 fallback for terminals that support clipboard escape codes.
    if command -v base64 >/dev/null 2>&1; then
        local osc52_payload
        osc52_payload="$(printf '%s' "$content" | base64 | tr -d '\r\n')"
        if [[ -n "${osc52_payload}" ]]; then
            # Prefer writing to the controlling TTY when stdout is not a terminal.
            if [[ -t 1 ]]; then
                if [[ -n "${TMUX}" ]]; then
                    printf '\033Ptmux;\033\033]52;c;%s\007\033\\' "${osc52_payload}"
                else
                    printf '\033]52;c;%s\a' "${osc52_payload}"
                fi
                return 0
            else
                exec {tty_fd}<>/dev/tty 2>/dev/null
                if [[ $? -eq 0 ]]; then
                    if [[ -n "${TMUX}" ]]; then
                        printf '\033Ptmux;\033\033]52;c;%s\007\033\\' "${osc52_payload}" >&${tty_fd}
                    else
                        printf '\033]52;c;%s\a' "${osc52_payload}" >&${tty_fd}
                    fi
                    exec {tty_fd}>&-
                    return 0
                fi
            fi
        fi
    fi

    echo "Error: No clipboard utility available. Install pbcopy, xclip, xsel, wl-copy, win32yank.exe, or enable clip.exe." >&2
    return 1
}
