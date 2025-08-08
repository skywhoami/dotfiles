{ lib, config, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.options) mkEnableOption;
in
{
  options.sys.services.glance.enable = mkEnableOption "Enable Glance";

  config = mkIf config.sys.services.glance.enable {
    services.glance = {
      enable = true;
      settings = {
        server = {
          port = 5678;
        };
        branding = {
          hide-footer = true;
        };
        theme = {
          background-color = "229 19 23";
          contrast-multiplier = 1.2;
          primary-color = "222 74 74";
          positive-color = "96 44 68";
          negative-color = "359 68 71";
        };
        pages = [
          {
            name = "Home";
            hide-desktop-navigation = true;
            columns = [
              {
                size = "small";
                widgets = [
                  {
                    type = "rss";
                    limit = 10;
                    collapse-after = 3;
                    cache = "12h";
                    feeds = [
                      {
                        url = "https://isabelroses.com/feed.xml";
                        title = "isabel roses";
                      }
                      {
                        url = "https://sapphic.moe/rss.xml";
                        title = "sapphic angels";
                      }
                    ];
                  }
                  {
                    type = "twitch-channels";
                    channels = [
                      "bashbunni"
                      "theprimeagen"
                      "lcolonq"
                      "danielroe"
                      "endingwithali"
                      "ppy"
                      "badcop_"
                      "ravenalternative"
                      "hackerling"
                      "thealtf4stream"
                      "rosannatxt"
                    ];
                  }
                ];
              }
              {
                size = "full";
                widgets = [
                  {
                    type = "search";
                    search-engine = "duckduckgo";
                  }
                  {
                    type = "videos";
                    style = "grid-cards";
                    channels = [
                      "UC9H0HzpKf5JlazkADWnW1Jw" # bashbunni
                      "UCsBjURrPoezykLs9EqgamOA" # fireship
                      "UClT-HLZIIdT4CKBVMJw8Odg" # lummi
                      "UCUyeluBRhGPCW4rPe_UvBZQ" # primetime
                      "UCbRP3c757lWg9M-U7TyEkXA" # theo
                      "UCSuHzQ3GrHSzoBbwrIq3LLA" # nbtv
                      "UC8ENHE5xdFSwx71u3fDH5Xw" # primeagen
                      "UC5--wS0Ljbin1TjWQX6eafA" # bigboxswe
                      "UCw24-aQvuVMP3C8gAduidPg" # madeline argy
                      "UCZ_cuJGBis0vi6U3bWmvDIg" # facedev
                    ];
                  }
                ];
              }
              {
                size = "small";
                widgets = [
                  {
                    type = "server-stats";
                    servers = [
                      {
                        type = "local";
                        name = "cherry";
                        hide-swap = true;
                        mountpoints = {
                          "/boot" = {
                            hide = true;
                          };
                          "/nix/store" = {
                            hide = true;
                          };
                        };
                      }
                    ];
                  }
                  {
                    type = "monitor";
                    cache = "1m";
                    sites = [
                      {
                        title = "website";
                        url = "https://${config.sys.services.caddy.domain}";
                      }
                    ];
                  }
                ];
              }
            ];
          }
        ];
      };
    };

    services.caddy.virtualHosts = {
      "glance.${config.sys.services.caddy.domain}" = {
        extraConfig = ''
          reverse_proxy localhost:5678
        '';
      };
    };
  };
}
