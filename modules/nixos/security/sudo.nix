{ lib, pkgs, ... }:
let
  inherit (lib) mkForce mkDefault getExe';
in
{
  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = mkDefault false;
      execWheelOnly = true;
      extraRules = [
        {
          groups = [ "wheel" ];

          commands = [
            {
              command = getExe' pkgs.nixos-rebuild "nixos-rebuild";
              options = [ "NOPASSWD" ];
            }
            {
              command = getExe' pkgs.systemd "reboot";
              options = [ "NOPASSWD" ];
            }
            {
              command = getExe' pkgs.systemd "shutdown";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
  };
}
