{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.homebrew.darwinModules.nix-homebrew
    ./environment.nix
  ];

  config = {
    nix-homebrew = {
      enable = true;
      taps = {
        "homebrew/homebrew-core" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-core";
          rev = "db574cbe661e06a7a7cb9e9a50b5730a0fd2f2dd";
          hash = "sha256-qw+KlfW6+kaaojvwXrPziGTuZBIsANo7iztc+nED9bI=";
        };
        "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-cask";
          rev = "fe151eb20497f0de52b26bbcf7c55aacaae3286b";
          hash = "sha256-6icfTrqUldnW3pCeM4ClocNUbIrd2DjSfKHXqY0tIfc=";
        };
        "koekeishiya/homebrew-formulae" = pkgs.fetchFromGitHub {
          owner = "koekeishiya";
          repo = "homebrew-formulae";
          rev = "f5711b9c70e104bffc79e3525e2ed0dc335bdbba";
          hash = "sha256-e7NybFVmFDHHy8m+cJPnDugGKzfYkMvh/3c+O7jMM2Y=";
        };
      };
      mutableTaps = false;
      user = "sky";
      autoMigrate = true;
    };

    homebrew = {
      enable = true;

      global.autoUpdate = true;

      onActivation = {
        upgrade = true;
        cleanup = "zap";
      };

      taps = builtins.attrNames config.nix-homebrew.taps;

      masApps = { };

      brews = [
        "colima"
        "docker"
        "docker-compose"
        "mas"
        "tmux"
        "tpm"
        "koekeishiya/formulae/yabai"
        "koekeishiya/formulae/skhd"
      ];

      casks = [
        "1password"
        "1password-cli"
        "aldente"
        "font-maple-mono"
        "ghostty"
        "signal"
        "steam"
        "vesktop"
      ];
    };
  };
}
