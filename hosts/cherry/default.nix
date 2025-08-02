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

  system.stateVersion = "23.11";
}
