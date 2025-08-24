{
  sys = {
    profiles.headless.enable = true;
    services = {
      caddy.enable = true;
      pds.enable = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/7763-8830";
    fsType = "vfat";
  };

  boot = {
    loader.grub = {
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };

    initrd = {
      availableKernelModules = [
        "ata_piix"
        "uhci_hcd"
        "xen_blkfront"
      ];
      kernelModules = [ "nvme" ];
    };

    tmp.cleanOnBoot = true;
  };

  zramSwap.enable = true;

  system.stateVersion = "25.05";
}
