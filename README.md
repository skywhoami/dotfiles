# dotfiles

managed with GNU Stow so I don’t lose my mind syncing configs across machines.

## what you need

- [Git](https://git-scm.com)
- [GNU Stow](https://www.gnu.org/software/stow/)
- Zsh
- [Homebrew](https://brew.sh/)

## setup

### 1. clone the repo

```bash
git clone https://github.com/skywhoami/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. install stow (if not already installed)

```bash
brew install stow
```

### 3. backup your current config (optional but recommended)

```bash
mkdir -p ~/dotfiles-backup
cp -r ~/{.zshrc,.zprofile,.vimrc,.gitconfig,Brewfile,.config/nvim,.config/omp.yaml,.config/ghostty,.ssh/config} ~/dotfiles-backup/ 2>/dev/null || echo "backup done"
```

### 4. delete existing dotfiles

```bash
rm -f ~/.zshrc ~/.zprofile ~/.vimrc ~/.gitconfig ~/.gitignore ~/Brewfile
rm -rf ~/.config/nvim ~/.config/omp.yaml ~/.config/ghostty ~/.ssh/config
```

### 5. stow the stuff
```bash
cd ~/dotfiles
for dir in */; do
  stow "${dir%/}"
done
```

### 6. install brew packages

```bash
brew bundle --file=~/dotfiles/brew/Brewfile
```

### 7. set up colima for Docker

```bash
brew services start colima
```

## what's in here

- **zsh**: shell setup, aliases, some shortcuts that make life nicer
- **git**: opinionated but friendly
- **brew**: all the tools I use
- **nvim**: tricked out with LSP, telescope, dap, all the goodies
- **oh my posh**: pretty prompt
- **ghostty**: fast terminal, GPU accelerated, cool config

## keymap

see [keymap.md](keymap.md)
