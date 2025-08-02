{
  profiles.headless.enable = true;

  device.cpu = "intel";

  boot.loader = {
    grub = {
      enable = true;
      device = "/dev/sda";
    };
  };
}
