{ inputs, ... }:
{
  system.primaryUser = "sky";

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults.CustomUserPreferences."com.apple.AdLib".allowApplePersonalizedAdvertising = false;

  imports = [
    inputs.home-manager.darwinModules.home-manager
    ../shared
    ./preferences.nix
    ./network.nix
    ./keyboard.nix
    ./brew.nix
  ];
}
