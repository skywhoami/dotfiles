{ self, inputs, ... }:
{
  imports = [ inputs.easy-hosts.flakeModule ];

  config.easy-hosts = {
    perClass = class: {
      modules = [ "${self}/modules/${class}" ];
    };

    shared.modules = [ ../modules/base ];

    hosts = {
      gloss = {
        arch = "aarch64";
        class = "darwin";
      };
    };
  };
}
