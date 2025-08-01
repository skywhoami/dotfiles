{ config, ... }:
{
  programs.lazygit = {
    enable = config.programs.git.enable && config.profiles.graphical.enable;
    settings = {
      confirmOnQuit = false;
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --paging=never";
        };
      };
    };
  };
}
