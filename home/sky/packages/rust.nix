{ pkgs, ... }:
{
  sys.packages = {
    inherit (pkgs)
      rustc
      cargo
      ;
  };
}
