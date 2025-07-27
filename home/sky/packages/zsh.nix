{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      source <(fzf --zsh)
      echo -e "\e[35m"
      /bin/cat <<'EOF'
        ╱|、
       (˚ˎ。7
       |、˜〵
       じしˍ,)ノ
      EOF
      echo -e "\e[0m"
    '';

    envExtra = ''
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
    '';

    shellAliases = {
      cat = "bat";
      cd = "z";
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -rfv";
      mkdir = "mkdir -pv";
      p = "cd ~/Developer/";
      dl = "cd ~/Downloads/";
      f = "open -a Finder";
      ls = "eza";
      g = "git";
      lg = "lazygit";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.eza = {
    enable = true;
    git = true;
  };
}
