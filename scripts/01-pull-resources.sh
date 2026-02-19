update_submodules() {
    echo "Aktualisiere Submodules..."
    if [ "$TESTMODE" = "true" ]; then
        echo "[DUMMY] git submodule update --init --recursive"
    else
        git submodule update --init --recursive
    fi
}

update_submodules
