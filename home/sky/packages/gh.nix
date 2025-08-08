{ config, ... }:
{
  programs.gh = {
    enable = config.programs.git.enable && config.sys.profiles.graphical.enable;
    settings = {
      git_protocol = "ssh";
    };
  };
}
