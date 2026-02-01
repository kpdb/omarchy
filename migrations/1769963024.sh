#!/bin/bash
set -e

# Remove retired packages
omarchy-pkg-drop alacritty obs-studio spotify dart tldr omarchy-chromium

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
