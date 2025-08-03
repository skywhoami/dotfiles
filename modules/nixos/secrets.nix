{ inputs, self, ... }:
{
  imports = [ inputs.sops.nixosModules.sops ];

  sops = {
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };

    secrets.cloudflared = {
      sopsFile = "${self}/secrets/services/cloudflared.yaml";
    };
  };
}
