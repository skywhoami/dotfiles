{ config, ... }:
{
  programs.gh = {
    enable = config.programs.git.enable;
    settings = {
      git_protocol = "ssh";
    };
  };
}
