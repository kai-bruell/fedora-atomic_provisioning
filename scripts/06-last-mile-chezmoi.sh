apply_chezmoi_dotfiles() {
    echo "Wende Chezmoi-Dotfiles an..."
    local source_dir
    source_dir="$(realpath "$CHEZMOI_REPO_DESTINATION")"
    local chezmoi_config="$HOME/.config/chezmoi/chezmoi.toml"

    if [ "$TESTMODE" = "true" ]; then
        echo "[DUMMY] mkdir -p ~/.config/chezmoi"
        echo "[DUMMY] echo sourceDir nach $chezmoi_config schreiben: $source_dir"
        echo "[DUMMY] chezmoi apply --source $CHEZMOI_REPO_DESTINATION --force -v"
    else
        mkdir -p "$HOME/.config/chezmoi"
        echo "sourceDir = \"$source_dir\"" > "$chezmoi_config"
        chezmoi apply --source "$CHEZMOI_REPO_DESTINATION" --force -v
    fi
}

apply_chezmoi_dotfiles
