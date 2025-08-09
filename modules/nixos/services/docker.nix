{ lib, config, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.options) mkEnableOption;
in
{
  options.sys.services.docker.enable = mkEnableOption "Enable Docker";

  config = mkIf config.sys.services.docker.enable {
    virtualisation.docker.enable = true;

    users.users.deploy = {
      isNormalUser = true;
      extraGroups = [ "docker" ];
      openssh.authorizedKeys.keys = [
        "command=\"docker system dial-stdio\" ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDp7bOljpc3R1nCoRA7IoCr/ZqXRBbQn/+g7xvwr+MHGtyI+f2lD2om0bYonctmXj5eNAgRNLqgN4WfVdUYRaUswa9GuZWP6FdpDCxQzMYMeyqp4BE7bM5hH4RCzoiL0mGTToO0PwyNEJk7AfrNai5PGM6xJ0czhDUllbz5Jh+GqE11pFZVOJU0uGPs5dZf60tlSr6K5cPmK4iDJkudMFfTsV0tEjgHmcJ5L17gwG0QD4CJO6r7WLjk4+4VhcKAfXBTGZ6/7+9OlFWkAlMSPofizdenqFQq0yJwyrSam5cExvWfQ6OU2E5nHHKCFdCavlI6y4UDR4t2wTzATTSmjTjeoujO5GbSfPyh8Tegw/RwAi23rNVeP8geYHFNulYEn0xth1EJqu+yQQPSWCSlC7SjJ3NMSpR126CXMly1YgZdTjgp5Q2KwdvaOzAeBK1isVFpp/wMeXZ9syBD+2s7V3YqH6wFokc+ucwICNz9hKDEuqUpK3ukKa4ZAg2ARP1FWfKcneqLtEftJaeOI3ds6oV6LoNy7LMOOeSSoAATOWiuKcfu2QaWyeSdoXawy5lVk8PxYyUoe4GdBV1qlRHwImQyK1npz923wqNw0e9Z2dW9mYiuoDozQNVjmpllpw+O+QnOjJ55w7b0wkllcPiMUrF7xg1PGrUjWDYwUlLKTGV9Jw=="
      ];
    };
  };
}
