# dotfiles

Minimal and opinionated dotfiles built for macOS. Managed with [GNU Stow](https://www.gnu.org/software/stow/), with
portability in mind.

> ⚠️ Tested on macOS (Apple Silicon). May not behave the same on Linux or Intel Macs.

---

## Setup

1. Clone the repo:
```bash
git clone https://github.com/skywhoami/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Run the installation script:
```bash
./install.sh
```

## Structure

Each app or tool lives in a folder that mirrors its path in $HOME, e.g.:
```
.zshrc
.config/
    omp.yaml
    ghostty/
        config
.gnupg/
    gpg-agent.conf
```

Stow handles the symlinking automatically.