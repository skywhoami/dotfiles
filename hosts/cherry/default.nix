{
  profiles.headless.enable = true;

  device.cpu = "intel";

  boot.loader = {
    grub = {
      enable = true;
      device = "/dev/sda";
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/f3d6d4c6-81f5-4b28-9f2e-a2a7fd98596b";
      fsType = "ext4";
    };
  };
}
