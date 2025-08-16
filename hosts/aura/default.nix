{
  sys = {
    users = [ "sky" ];
    profiles.headless.enable = true;
    services = {
      caddy = {
        enable = true;
        domain = "subnetbabe.cloud";
      };
      pds.enable = true;
    };
    networking.tailscale.enable = true;
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

  users.users.sky = {
    hashedPassword = "$y$j9T$gr3AsFOgHR3fthkAWtX.g0$WpG6J.l2tTLq5Uzf03PvAtElO0CqakFXMtQT0pwS09/";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGIyMCwBcRVn8QdhGrI/2PWY6g9cIFEGphXBG2T3FHg5"
    ];
  };

  system.stateVersion = "25.05";
}
