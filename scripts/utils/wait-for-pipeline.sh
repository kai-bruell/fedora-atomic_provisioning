echo "Prüfe ob eine BlueBuild Pipeline läuft..."
while true; do
    running=$(curl -s "https://api.github.com/repos/$BLUEBUILD_REPO/actions/runs?status=in_progress" | jq '.total_count')
    if [ "$running" -eq 0 ]; then
        echo "Keine aktive Pipeline – weiter."
        break
    fi
    echo "Pipeline läuft noch ($running aktiv) – warte 5 Sekunden..."
    sleep 5
done
