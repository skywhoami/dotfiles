{ lib, ... }:
{
  profiles.headless.enable = true;

  boot.tmp.cleanOnBoot = true;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.availableKernelModules = [
    "ata_piix"
    "uhci_hcd"
    "xen_blkfront"
    "vmw_pvscsi"
  ];
  boot.initrd.kernelModules = [ "nvme" ];

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  users.users.sky.openssh.authorizedKeys.keys = [
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG56OdAD9r6wWd+ag1R+neANX1KSdpl/h8JkYVCVdNRi''
  ];

  networking = {
    defaultGateway = "172.31.1.1";
    defaultGateway6 = {
      address = "fe80::1";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          {
            address = "91.99.239.117";
            prefixLength = 32;
          }
        ];
        ipv6.addresses = [
          {
            address = "2a01:4f8:c0c:9289::1";
            prefixLength = 64;
          }
          {
            address = "fe80::9000:6ff:fe4f:4b39";
            prefixLength = 64;
          }
        ];
        ipv4.routes = [
          {
            address = "172.31.1.1";
            prefixLength = 32;
          }
        ];
        ipv6.routes = [
          {
            address = "fe80::1";
            prefixLength = 128;
          }
        ];
      };

    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="92:00:06:4f:4b:39", NAME="eth0"
  '';

  system.stateVersion = "23.11";
}
