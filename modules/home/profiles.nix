{ lib, osConfig, ... }:
let
  cfg = osConfig.profiles;
in
{
  profiles = {
    inherit (cfg)
      graphical
      headless
      ;
  };
}
