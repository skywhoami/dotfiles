{ config, ... }:
{
  programs.gh = {
    enable = config.programs.git.enable && config.gum.profiles.graphical.enable;
    settings = {
      git_protocol = "ssh";
    };
  };
}
