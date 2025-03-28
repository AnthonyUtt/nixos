eval "$(zoxide init --cmd cd zsh)"

autoload -U compinit && compinit

# Start a zellij session if it hasn't been started yet
export ZELLIJ_AUTO_ATTACH=true
if [[ -z "$ZELLIJ" ]]; then
    if [[ "$VSCODE_INJECTION" == "1" ]]; then
        # no-op
    else
        if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
            zellij attach -c
        else
            zellij
        fi
    fi

    if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
        exit
    fi
fi
