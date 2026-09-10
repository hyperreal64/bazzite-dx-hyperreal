_default:
    @just --list

install-hyperreal-pkgs:
    #!/usr/bin/env bash
    echo "Installing hyperreal packages..."
    brew bundle --file=/usr/share/ublue-os/homebrew/hyperreal.Brewfile

install-joplin-desktop:
    #!/usr/bin/env bash
    set -euxo pipefail
    wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

install-ipfs-desktop:
    #!/usr/bin/env bash
    set -euxo pipefail
    url=$(curl -s https://api.github.com/repos/ipfs/ipfs-desktop/releases/latest | sed -n 's/.*"browser_download_url": //p' | grep -E ".AppImage" | tr -d '"')
    digest=$(curl -s https://api.github.com/repos/ipfs/ipfs-desktop/releases/latest | jq -c '.assets.[] | select(.browser_download_url | contains(".AppImage")) | .digest' | tr -d '"' | awk -F: '{print $2}')
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR" || exit
    wget "$url"
    checksum=$(sha256sum ./ipfs-desktop*.AppImage | awk '{print $1}')
    if ! [ "$digest" = "$checksum" ]; then
    	echo "Checksum failed!"
    	exit 1
    else
    	mv ipfs-desktop*.AppImage ~/Downloads
    fi
    cd ~/ || exit
    rm -rf "$TEMP_DIR"
    echo "IPFS-Desktop checksum verified."
    echo "You can now install IPFS-Desktop with GearLever."

install-wayback:
    #!/usr/bin/env bash
    brew tap wabarc/wayback
    brew install wayback

setup-autostart-apps:
    #!/usr/bin/env bash
    set -euxo pipefail
    if [ -f /var/lib/flatpak/app/ch.protonmail.protonmail-bridge/current/active/export/share/applications/ch.protonmail.protonmail-bridge.desktop ]; then ln -sf /var/lib/flatpak/app/ch.protonmail.protonmail-bridge/current/active/export/share/applications/ch.protonmail.protonmail-bridge.desktop /var/home/jas/.config/autostart/ch.protonmail.protonmail-bridge.desktop; fi
    if [ -f /var/lib/flatpak/app/io.github.martchus.syncthingtray/current/active/export/share/applications/io.github.martchus.syncthingtray.desktop ]; then ln -sf /var/lib/flatpak/app/io.github.martchus.syncthingtray/current/active/export/share/applications/io.github.martchus.syncthingtray.desktop /var/home/jas/.config/autostart/io.github.martchus.syncthingtray.desktop; fi
    if [ -f /var/lib/flatpak/app/org.signal.Signal/current/active/export/share/applications/org.signal.Signal.desktop ]; then ln -sf /var/lib/flatpak/app/org.signal.Signal/current/active/export/share/applications/org.signal.Signal.desktop /var/home/jas/.config/autostart/org.signal.Signal.desktop; fi
    if [ -f /var/lib/flatpak/app/org.gajim.Gajim/current/active/export/share/applications/org.gajim.Gajim.desktop ]; then ln -sf /var/lib/flatpak/app/org.gajim.Gajim/current/active/export/share/applications/org.gajim.Gajim.desktop /var/home/jas/.config/autostart/org.gajim.Gajim.desktop; fi
    if [ -f /var/home/jas/.local/share/applications/ipfs_desktop.desktop ]; then ln -sf /var/home/jas/.local/share/applications/ipfs_desktop.desktop /var/home/jas/.config/autostart/ipfs_desktop.desktop; fi
