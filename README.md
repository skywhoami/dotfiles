# sky's dotfiles

> my mac setup, but make it ✨vibes✨

this is my personal dotfiles setup: minimal, functional, a little opinionated, and tailored for how **i** work. it’s not trying to be universal, it’s just what keeps me productive and vibing on macOS.

---

## purpose

this repo isn’t some fancy starter pack or overly abstract dotfiles framework. it’s just my actual setup, made for fast iteration.

i built this to:
- make setting up a new mac painless
- keep my terminal + editor feeling consistent
- stay in control of my environment, without relying on GUI tweaking
- document the small decisions that make my workflow smoother

everything here reflects how i *actually* work day-to-day.

## setup

> for fresh mac setups

```bash
git clone https://github.com/skywhoami/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh
```

this will:
- install homebrew in case you don't have it
- install all packages from Brewfile
- apply macOS defaults from .osx
- symlink everything with stow

if you’re not on macOS, it’ll skip the brew + osx steps automatically.

## git setup

i gpg-sign all my commits, and use a bunch of aliases like:

```bash
g s # git status -s
g fpush # force push
g fresh # orphan branch
g wopsy # amend last commit, no edit
g cleanup # fetch, prune, delete stale branches etc
```

## theme 

i use the [Rosé Pine](https://github.com/rose-pine) theme pretty much everywhere as well as the [Maple Mono](https://github.com/subframe7536/maple-font) font.

## thanks

to the tool authors, plugin creators, and all the weird little open source nerds out there - you inspire me.
