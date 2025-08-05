{ lib, config, ... }:
let
  inherit (lib) mkOption optional;
  inherit (lib.types) listOf str;
in
{
  options.gum.users = mkOption {
    type = listOf str;
    default = [ "sky" ];
    description = ''
      A list of users that the host will have.
    '';
  };

  config = {
    warnings = optional (config.gum.users == [ ]) ''
      You have not configured any users.

      Please set {option}`config.gum.users` in your host configuration.
    '';
  };
}
