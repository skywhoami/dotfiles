{
  programs.fzf = {
    enable = true;

    defaultOptions = [
      "--height=40%"
      "--layout=reverse"
      "--border"
      "--preview-window=right:60%"
      "--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
    ];
  };
}
