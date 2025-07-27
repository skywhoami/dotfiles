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
  ];

  home.packages = with pkgs; [
    just
    glow
    bun
    charm-freeze
  ];
}
