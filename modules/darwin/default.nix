{ inputs, ... }:
{
  _class = "darwin";

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
