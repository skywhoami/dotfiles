{ inputs, ... }:
{
  system.primaryUser = "sky";

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults.CustomUserPreferences."com.apple.AdLib".allowApplePersonalizedAdvertising = false;

  imports = [
    ../base
    inputs.home-manager.darwinModules.home-manager
    ./preferences.nix
    ./network.nix
    ./keyboard.nix
    ./brew.nix
  ];

  system.stateVersion = 6;
}
