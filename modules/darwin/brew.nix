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
          rev = "1f4178b9e6d6a0e42c256e946d34f6c0f7cbc23c";
          hash = "sha256-t9BpMrzPp74TGywKiOyHx4/0yw0iC241PF0CD0w1p80=";
        };
        "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-cask";
          rev = "e44dad7cb3c4c736c3b6994b8f10c00a0a5970c7";
          hash = "sha256-SMAS5eVDsP9eDag+qsz+ORv7Xr7ZBHfvQaeZwrPv7Zo=";
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
        "zen"
        "proton-drive"
      ];
    };
  };
}
