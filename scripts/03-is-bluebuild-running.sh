if rpm-ostree status | grep -q "kai-bruell/bluebuild"; then
    echo "BlueBuild Image erkannt – prüfe auf Updates..."
    if [ "$TESTMODE" = "true" ]; then
        echo "[DUMMY] rpm-ostree rebase ostree-image-signed:docker://$BLUEBUILD_IMAGE"
    else
        local_digest=$(rpm-ostree status --json | jq -r '[.deployments[] | select(.booted == true)][0]."container-image-reference-digest"')
        remote_digest=$(skopeo inspect --raw "docker://$BLUEBUILD_IMAGE" 2>/dev/null | jq -r '.manifests[]? | select(.platform.architecture == "amd64" and .platform.os == "linux") | .digest')

        if [ "$local_digest" = "$remote_digest" ]; then
            echo "Kein Update verfügbar – weiter."
        else
            echo "Neues Image verfügbar – aktualisiere..."
            rebase_output=$(rpm-ostree rebase "ostree-image-signed:docker://$BLUEBUILD_IMAGE" 2>&1)
            rebase_exit=$?
            echo "$rebase_output"
            if echo "$rebase_output" | grep -q "Old and new refs are equal"; then
                echo "Image bereits aktuell – weiter."
            elif [ $rebase_exit -eq 0 ]; then
                read -rp "Neues Image heruntergeladen – Neustart erforderlich. Jetzt neu starten? (y/n): " reboot_answer
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
                echo "Update fehlgeschlagen."
                exit 1
            fi

        fi
    fi
elif [ "$TESTMODE" = "true" ]; then
    echo "[DUMMY] rpm-ostree rebase ostree-unverified-registry:$BLUEBUILD_IMAGE"
else
    source ./scripts/utils/rebase-to-bluebuild.sh
fi
