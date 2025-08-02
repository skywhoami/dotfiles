{ lib, config, ... }:
let
  inherit (lib.modules)
    mkIf
    mkForce
    mkMerge
    mkDefault
    ;
  inherit (lib.options) mkOption;
  inherit (lib.types)
    str
    enum
    nullOr
    ;

  cfg = config.system.boot;
in
{
  options.system.boot = {
    loader = mkOption {
      type = enum [
        "none"
        "grub"
      ];
      default = "none";
      description = "The bootloader that should be used for the host.";
    };

    grub = {
      device = mkOption {
        type = nullOr str;
        default = "nodev";
        description = "The device where the bootloader will be installed.";
      };
    };
  };

  config = mkMerge [
    (mkIf (cfg.loader == "none") {
      boot.loader = {
        grub.enable = mkForce false;
        systemd-boot.enable = mkForce false;
      };
    })

    (mkIf (cfg.loadert == "grub") {
      boot.loader.grub = {
        enable = mkDefault true;
        useOSProber = true;
        efiSupport = true;
        inherit (cfg.grub) device;
      };
    })
  ];
}
