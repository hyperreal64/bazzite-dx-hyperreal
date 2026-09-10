# bazzite-dx-hyperreal

Custom build of Bazzite with the following features:

- bazzite-dx-nvidia-gnome
- cronie
- neomutt
- prometheus-node-exporter
- rpcbind
- nerd-fonts: AdwaitaMono, GeistMono, JetBrainsMono
- Homebrew
- various gschema-overrides
- systemd services:
  - docker.service
  - prometheus-node-exporter.service
  - rpcbind.service

## Installation

To rebase from an existing Bazzite installation:

```bash
sudo bootc switch ghcr.io/hyperreal64/bazzite-dx-hyperreal:latest
```

Reboot to complete the rebase:

```bash
systemctl reboot
```
