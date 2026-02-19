for flatpak in "${FLATPAKS[@]}"; do
    echo "Installiere $flatpak..."
    if [ "$TESTMODE" = "true" ]; then
        echo "[DUMMY] flatpak install -y --or-update flathub $flatpak"
    else
        flatpak install -y --or-update flathub "$flatpak"
    fi
done
