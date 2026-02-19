read -rp "Distrobox ist noch nicht installiert. Möchtest du fortfahren? (y/n): " answer
if [[ "$answer" =~ ^[yY] ]]; then
    if [ "$TESTMODE" = "true" ]; then
        echo "[DUMMY] sudo rpm-ostree install distrobox"
    else
        sudo rpm-ostree install distrobox
    fi
    if [ $? -eq 0 ]; then
        read -rp "Installation erfolgreich. Jetzt neu starten? (y/n): " reboot_answer
        if [[ "$reboot_answer" =~ ^[yY] ]]; then
            echo "Nach dem Neustart bitte das Skript erneut ausführen."
            for i in 5 4 3 2 1; do
                echo "Neustart in $i Sekunden..."
                sleep 1
            done
            if [ "$TESTMODE" = "true" ]; then
                echo "[DUMMY] systemctl reboot"
            else
                systemctl reboot
            fi
        else
            echo "Bitte später neu starten, damit die Änderungen wirksam werden."
            echo "Danach das Skript erneut ausführen."
        fi
    else
        echo "Installation fehlgeschlagen."
        exit 1
    fi
else
    echo "Abgebrochen."
fi
