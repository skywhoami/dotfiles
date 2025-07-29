{ config, ... }:
{
  programs.gh = {
    enable = config.programs.git.enable && config.profiles.graphical.enable;
    settings = {
      git_protocol = "ssh";
    };
  };
}
