echo "Kein BlueBuild Image erkannt – rebase auf $BLUEBUILD_IMAGE..."
rpm-ostree rebase ostree-unverified-registry:$BLUEBUILD_IMAGE

if [ $? -eq 0 ]; then
    read -rp "Rebase erfolgreich. Jetzt neu starten? (y/n): " reboot_answer
    if [[ "$reboot_answer" =~ ^[yY] ]]; then
        echo "Nach dem Neustart bitte das Skript erneut ausführen."
        for i in 5 4 3 2 1; do
            echo "Neustart in $i Sekunden..."
            sleep 1
        done
        systemctl reboot
    else
        echo "Bitte später neu starten und das Skript erneut ausführen."
        exit 0
    fi
else
    echo "Rebase fehlgeschlagen."
    exit 1
fi
