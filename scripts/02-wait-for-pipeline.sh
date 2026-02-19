if [ "$TESTMODE" = "true" ]; then
    echo "[DUMMY] gh run list --repo $BLUEBUILD_REPO --status in_progress"
else
    source ./scripts/utils/wait-for-pipeline.sh
fi
