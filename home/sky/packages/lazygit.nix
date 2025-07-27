{ config, ... }:
{
  programs.lazygit = {
    enable = config.programs.git.enable;
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
