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
  ];

  gum.packages = {
    inherit (pkgs)
      just
      glow
      bun
      charm-freeze
      age
      sops
      ;
  };
}
