{
  profiles.headless.enable = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0235fbb8-6dcc-45a6-89f0-9d86fade040d";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F35B-6D22";
    fsType = "ext4";
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  users.users = {
    sky = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG56OdAD9r6wWd+ag1R+neANX1KSdpl/h8JkYVCVdNRi"
      ];
    };
  };

  system.stateVersion = "25.05";
}
