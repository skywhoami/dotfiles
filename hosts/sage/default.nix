{ config, ... }:
{
  sys = {
    users = [ "sky" ];
    profiles.headless.enable = true;
    services = {
      caddy.enable = true;
      pds.enable = true;
      docker.enable = true;
      glance.enable = true;
      uptime-kuma.enable = true;
      postgres.enable = true;
    };
    networking.tailscale.enable = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/04340f95-85c7-4eb6-9e96-07f13a80f745";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/DFFA-971E";
    fsType = "vfat";
  };

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
    };

    initrd = {
      availableKernelModules = [
        "ata_piix"
        "uhci_hcd"
        "xen_blkfront"
        "vmw_pvscsi"
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

  services.caddy.virtualHosts = {
    ${config.sys.services.caddy.domain} = {
      extraConfig = ''
        reverse_proxy 127.0.0.1:3000
      '';
    };
  };

  system.stateVersion = "25.05";
}
