#!/bin/bash

trap 'echo "Abgebrochen."; exit 1' INT

# --- Konfiguration ---
TESTMODE=false
export XDG_DOCUMENTS_DIR="$(xdg-user-dir DOCUMENTS)"

DISTROBOX_REPO_DESTINATION="./DistroBoxes"
CHEZMOI_REPO_DESTINATION="./Chezmoi-Dotfiles"
BLUEBUILD_IMAGE="ghcr.io/kai-bruell/bluebuild:latest"
BLUEBUILD_REPO="kai-bruell/BlueBuild"

FLATPAKS=(
    com.brave.Browser
    org.keepassxc.KeePassXC
    org.libreoffice.LibreOffice
    com.github.xournalpp.xournalpp
    com.moonlight_stream.Moonlight
)

BOXES=(
arch-rolling-tools
)

# --- Ausführung ---
source ./scripts/00-basic.sh
source ./scripts/01-pull-resources.sh
source ./scripts/02-wait-for-pipeline.sh
source ./scripts/03-is-bluebuild-running.sh
source ./scripts/04-install-flatpaks.sh
source ./scripts/05-rollout-distroboxes.sh
source ./scripts/06-last-mile-chezmoi.sh
