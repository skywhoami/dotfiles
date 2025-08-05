{
  gum = {
    users = [ "sky" ];
    profiles.headless.enable = true;
    services = {
      docker.enable = true;
      caddy.enable = true;
      postgres.enable = true;
    };
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

  users.users.sky = {
    hashedPassword = "$y$j9T$gr3AsFOgHR3fthkAWtX.g0$WpG6J.l2tTLq5Uzf03PvAtElO0CqakFXMtQT0pwS09/";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG56OdAD9r6wWd+ag1R+neANX1KSdpl/h8JkYVCVdNRi"
    ];
  };

  system.stateVersion = "25.05";
}
