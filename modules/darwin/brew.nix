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
          rev = "b49e78f071d2c0274575b290f75a6c974346b160";
          hash = "sha256-7VkBWf9OmtfOIN3HzpW2enES4aRIo4kbslSgwtDC8Io=";
        };
        "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-cask";
          rev = "893c6b440cfe3ac6fe85b53cbc301d980904bdfc";
          hash = "sha256-aeXOWBlL6uBmm52iIPLEhGrW8o/eKbhKd84lyXJnscg=";
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
        "Tailscale" = 1475387142;
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
        "proton-mail"
        "raycast"
        "zen@twilight"
        "proton-drive"
      ];
    };
  };
}
