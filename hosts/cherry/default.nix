{
  profiles.headless.enable = true;

  device.cpu = "intel";

  system.boot = {
    loader = "grub";
    grub.device = "/dev/sda";
  };
}
