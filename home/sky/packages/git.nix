{ pkgs, lib, ... }:
{
  programs.git = {
    package = pkgs.gitMinimal;
    enable = true;
    userName = "Skylar";
    userEmail = "hi" + "@" + "skylar" + "." + "sh";

    signing = {
      key = "29E2B1E3F89581C0";
      format = "openpgp";
      signByDefault = true;
    };

    ignores = [
      ".DS_Store"
      "*~"
      "*.swp"
      "*.bak"
      "*.tmp"
      "*.log"
      ".idea"
      "changes.txt"
      "*freeze.png"
    ];

    attributes = [
      "* text=auto"
      "*.sh text eol=lf"
      "tsconfig.json linguist-language=JSON-with-Comments"
      "*.lock text -diff"
    ];

    aliases = {
      s = "status -s";
      undo = "reset --soft HEAD^";
      cleanup = ''
        git fetch upstream; \
        git checkout main; \
        git pull upstream main; \
        git push origin main; \
        git branch -r --merged | grep -v main | grep origin | sed 's/origin\\///' | gxargs -r -n 1 git push --delete origin; \
        git branch --merged | grep -v main | gxargs -r -n 1 git branch -d; \
        git branch -vv | grep ': gone]'|  grep -v '\\*' | awk '{ print $1; }' | gxargs -r git branch -D; \
        git fetch --all --prune; \
        git prune; \
        git gc --aggressive;
      '';
      wopsy = "commit -a --amend --no-edit";
    };

    lfs.enable = true;

    delta = {
      enable = true;
      options = {
        line-numbers = true;
        hyperlinks = true;
        side-by-side = true;
      };
    };

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
