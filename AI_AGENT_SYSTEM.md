# AI Agent — Systemkontext: `fedora.fritz.box`

## System

**Fedora 43 Sway Atomic** – immutable (ostree). Kein `dnf install` auf dem Host.
Software-Quellen: **Flatpak**, **Distrobox** (`arch-rolling-system`), **BlueBuild-Image-Rebuild**.
Dotfiles managed via **Chezmoi**.

## Terminal

```
foot → zsh + Oh-My-Zsh → tmux (vi-mode)
```

Prompt zeigt `(distrobox: arch-rolling-system)` wenn in der Box.

## Distrobox `arch-rolling-system`

Hier läuft alles, was auf dem Atomic-Host nicht verfügbar ist.
Exportierte Binaries (Host-Aufruf): `nvim`, `gh`, `grim`, `slurp`, `tesseract`, `wl-copy`, `wl-paste`, `notify-send`, `pandoc`, `lualatex`, `glow`, `grip`, `opencode`, `pastel`

```bash
distrobox-host-exec <cmd>           # Ausführung auf dem Host
distrobox enter arch-rolling-system # Eintreten in die Box
```

## KI-Tooling

| Tool | Aufruf | Config |
|---|---|---|
| **OpenCode** | `opencode` | `~/.config/opencode/opencode.jsonc` – über Distrobox exportiert |
| **Aider** | `aider` | `~/.config/aider/` – via Chezmoi verwaltet |

## Chezmoi-Workflow (Dotfiles)

Jede Änderung am Repository **muss** in dieser Reihenfolge passieren:

```bash
git add -A
git commit -m "…"
git push
chezmoi apply   # parsed die Änderungen nach ~/.config/
```

**Wieso funktioniert `chezmoi apply` sofort?**  
Chezmois `sourceDir` zeigt direkt auf das Git-Repo (`Chezmoi-Dotfiles/`).  
`chezmoi apply` liest von dort, substituiert Template-Variablen und schreibt die Dateien an die Zielorte (`~/.config/…`).  
Ein `git push` reicht, damit der Source immer auf dem aktuellen Stand ist.

## Wichtigsten Pfade

| Pfad | Zweck |
|---|---|
| `~/Documents/fedora-atomic_provisioning/` | Repo-Root |
| `~/Documents/fedora-atomic_provisioning/Chezmoi-Dotfiles/` | Chezmoi-Source (Git-Submodule) |
| `~/Documents/fedora-atomic_provisioning/DistroBoxes/` | Distrobox-Definitionen |
| `~/.config/aider/` | Aider-Runscript |
| `~/.config/opencode/` | OpenCode-Config |
| `~/.local/bin/` | Exportierte Distrobox-Binaries |
