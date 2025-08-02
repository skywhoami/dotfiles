{ lib, config, ... }:
{
  imports = [
    ./fail2ban.nix
    ./firewall.nix
    ./openssh.nix
  ];

  networking = {
    hostId = builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName);

    useDHCP = lib.mkForce false;
    useNetworkd = lib.mkForce true;
    usePredictableInterfaceNames = lib.mkDefault true;

    enableIPv6 = true;
  };
}
