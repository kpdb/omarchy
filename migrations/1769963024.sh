#!/bin/bash
set -e

# Remove retired packages
# We use pacman directly because omarchy-pkg-remove is interactive
# We ignore errors in case packages are already removed or not present
sudo pacman -Rns --noconfirm alacritty obs-studio spotify dart tldr omarchy-chromium || true

# Install new packages
omarchy-pkg-add zed jujutsu tealdeer

# Remove retired config files
rm -f ~/.config/kitty/kitty.conf
rm -rf ~/.config/chromium/Default/Preferences

# Remove retired icons
ICON_DIR="$HOME/.local/share/applications/icons"
rm -f "$ICON_DIR/Google Contacts.png"
rm -f "$ICON_DIR/Google Maps.png"
rm -f "$ICON_DIR/Google Messages.png"
rm -f "$ICON_DIR/Google Photos.png"
rm -f "$ICON_DIR/WhatsApp.png"
rm -f "$ICON_DIR/X.png"
rm -f "$ICON_DIR/YouTube.png"
rm -f "$ICON_DIR/Zoom.png"
