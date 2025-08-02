{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  imports = [
    ./intel.nix
  ];

  options.device.cpu = mkOption {
    type = types.nullOr (
      types.enum [
        "intel"
      ]
    );
    default = null;
    description = "Manufacturer of the host CPU.";
  };
}
