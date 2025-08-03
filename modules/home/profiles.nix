{ osConfig, ... }:
let
  cfg = osConfig.gum.profiles;
in
{
  gum.profiles = {
    inherit (cfg)
      graphical
      headless
      ;
  };
}
