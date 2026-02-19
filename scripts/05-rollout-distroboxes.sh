for box in "${BOXES[@]}"; do
    ini_file="$DISTROBOX_REPO_DESTINATION/$box/$box.ini"

    if [ ! -f "$ini_file" ]; then
        echo "[$box] Kein ini file gefunden – überspringe."
        continue
    fi

    echo "[$box] Installiere Distrobox..."
    if [ "$TESTMODE" = "true" ]; then
        echo "[DUMMY] distrobox assemble create --replace --file $ini_file"
    else
        distrobox assemble create --replace --file "$ini_file"
        distrobox enter "$box" -- true
    fi
done
