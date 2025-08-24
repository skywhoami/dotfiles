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
          rev = "ca9529d05e3a716c654522074f506046e4a01c1a";
          hash = "sha256-bEqT5IKv7L4ur7qky6X1VQ+kGv02+3/bvCTbdGP2ir8=";
        };
        "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-cask";
          rev = "8aa008eb2fb3908feabf97c6cce47544cad0e603";
          hash = "sha256-fJOBYrZVZh4UKV52cTAqpa1cLdSnrPlMIqLdMq0gLaE=";
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

      masApps = {
        "Pages" = 409201541;
        "TestFlight" = 899247664;
        "WhatsApp" = 310633997;
      };

      brews = [
        "colima"
        "docker"
        "docker-compose"
        "mas"
        "koekeishiya/formulae/yabai"
        "koekeishiya/formulae/skhd"
      ];

      casks = [
        "1password"
        "1password-cli"
        "aldente"
        "font-maple-mono"
        "kitty"
        "signal"
        "steam"
        "vesktop"
        "raycast"
        "zen@twilight"
        "mullvad-vpn"
      ];
    };
  };
}
