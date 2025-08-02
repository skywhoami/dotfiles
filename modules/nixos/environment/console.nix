{ lib, ... }:
{
  console = {
    enable = lib.mkDefault true;
    earlySetup = true;

    keyMap = "en";
  };
}
