{ lib, config, ... }:
{
  config = lib.mkIf (lib.elem "sky" config.gum.users) {
    users.users.sky = {
      hashedPassword = "$y$j9T$gr3AsFOgHR3fthkAWtX.g0$WpG6J.l2tTLq5Uzf03PvAtElO0CqakFXMtQT0pwS09/";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG56OdAD9r6wWd+ag1R+neANX1KSdpl/h8JkYVCVdNRi"
      ];
    };
  };
}
