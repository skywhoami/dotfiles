{
  services.openssh = {
    enable = true;

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      AuthenticationMethods = "publickey";
      PubkeyAuthentication = "yes";
      ChallengeResponseAuthentication = "no";

      ClientAliveCountMax = 5;
      ClientAliveInterval = 60;
    };

    openFirewall = true;
    ports = [ 22 ];
  };
}
