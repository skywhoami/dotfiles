{
  sys = {
    users = [ "sky" ];
    profiles.headless.enable = true;
    services = {
      caddy.enable = true;
    };
    networking.tailscale.enable = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5280ec1e-52c5-48db-9e36-79b0548aeed0";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F58E-402B";
    fsType = "vfat";
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  users.users.sky = {
    hashedPassword = "$y$j9T$gr3AsFOgHR3fthkAWtX.g0$WpG6J.l2tTLq5Uzf03PvAtElO0CqakFXMtQT0pwS09/";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGIyMCwBcRVn8QdhGrI/2PWY6g9cIFEGphXBG2T3FHg5"
    ];
  };

  services.caddy.virtualHosts = {
    "subnetbabe.cloud" = {
      extraConfig = ''
        reverse_proxy localhost:4321
      '';
    };
  };
  system.stateVersion = "25.05";
}
