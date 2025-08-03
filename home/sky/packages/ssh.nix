{ lib, config, ... }:
{
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    compression = true;

    matchBlocks = {
      "github.com" = {
        user = "git";
        hostname = "github.com";
      };

      "cherry".hostname = "91.99.239.117";
    };

    extraConfig = lib.mkIf config.profiles.graphical.enable ''
      Host *
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };
}
