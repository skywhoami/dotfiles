{
  gum = {
    users = [ "sky" ];
    profiles.headless.enable = true;
    services.docker.enable = true;
    system.networking.tailscale.enable = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f3d6d4c6-81f5-4b28-9f2e-a2a7fd98596b";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F22B-3527";
    fsType = "vfat";
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  system.stateVersion = "25.05";
}
