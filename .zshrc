export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$PWD/node_modules/.bin:$PATH"
export HOMEBREW_NO_ANALYTICS=1

export DOCKER_HOST="unix://$HOME/.colima/default/docker.sock"

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export EDITOR="nvim"

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  if [[ -f "$XDG_CONFIG_HOME/omp.yaml" ]]; then
    eval "$(oh-my-posh init zsh --config $XDG_CONFIG_HOME/omp.yaml)"
  fi
fi

source $(brew --prefix)/opt/zinit/zinit.zsh

zinit wait lucid for \
  zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-history-substring-search \
  Aloxaf/fzf-tab

source ~/.zsh/catppuccin_frappe-zsh-syntax-highlighting.zsh

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -rfv"
alias mkdir="mkdir -pv"
alias cd="z"
alias ~="cd ~"
alias p="cd ~/Developer/"
alias dl="cd ~/Downloads/"
alias f="open -a Finder"
alias ls="eza"
alias cat="bat"
alias g="git"
alias lg="lazygit"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#F2D5CF,hl:#E78284 \
--color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#F2D5CF \
--color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284 \
--color=selected-bg:#51576D \
--color=border:#414559,label:#C6D0F5 \
--height 40% \
--layout=reverse \
--border \
--ansi \
--preview-window=right:60% \
--preview 'bat --color=always --style=numbers --line-range=:500 {}'"

docker_rm_stopped() {
  docker rm $(docker ps -a -q)
}

bindkey -v
for mode in viins vicmd; do
  bindkey -M $mode '^[[A' history-substring-search-up
  bindkey -M $mode '^[[B' history-substring-search-down
done

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

source <(fzf --zsh)
eval "$(zoxide init zsh)"

export GPG_TTY=$(tty)
echo -e "\e[35m"

/bin/cat <<'EOF'
  ╱|、
 (˚ˎ。7
 |、˜〵
 じしˍ,)ノ
EOF

echo -e "\e[0m"
