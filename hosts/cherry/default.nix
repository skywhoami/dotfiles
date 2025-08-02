{
  profiles.headless.enable = true;

  device.cpu = "intel";

  boot = {
    loader = "grub";
    grub.device = "/dev/sda";
  };
}
