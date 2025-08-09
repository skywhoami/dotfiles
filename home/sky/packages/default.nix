{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./hyfetch
    ./zsh.nix
    ./ohmyposh
    ./gh.nix
    ./btop.nix
    ./ssh.nix
    ./fzf.nix
    ./lazygit.nix
    ./ripgrep.nix
    ./gpg.nix
    ./rust.nix
    ./neovim
    ./tmux.nix
    ./kitty
    ./crush
  ];

  sys.packages = {
    inherit (pkgs)
      nodejs
      just
      glow
      bun
      charm-freeze
      age
      sops
      go
      ;
  };
}
