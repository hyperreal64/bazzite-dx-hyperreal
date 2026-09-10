#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y \
	cronie \
	neomutt \
	nfs-utils \
	pass \
	prometheus-node-exporter \
	rpcbind

# compile gschema overrides
glib-compile-schemas /usr/share/glib-2.0/schemas/

systemctl disable cups.service
systemctl disable cups.socket
systemctl enable docker.service
systemctl enable mnt-personal.automount
systemctl enable mnt-wayback.automount
systemctl enable podman.socket
systemctl enable prometheus-node-exporter.service
systemctl enable rpcbind.service
