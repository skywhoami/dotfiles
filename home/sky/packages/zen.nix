{
  _class,
  lib,
  config,
  ...
}:
let
  policies = {
    policies = {
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = false;
      NoDefaultBookmarks = true;
      Cookies = {
        Allow = [
          "https://bsky.app"
          "https://github.com"
          "https://steamcommunity.com"
          "https://1password.com"
          "https://google.com"
          "https://youtube.com"
          "https://proton.me"
          "https://cloudflare.com"
          "https://twitch.tv"
          "https://apple.com"
          "https://instagram.com"
          "https://steampowered.com"
          "http://100.100.69.99"
          "https://porkbun.com"
          "https://ovh.com"
          "https://tailscale.com"
          "https://amazon.es"
          "https://hetzner.com"
        ];
      };
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = true;
        FormData = true;
      };
      DisableFirefoxAccounts = true;
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://base.dns.mullvad.net/dns-query";
        Fallback = true;
        Locked = true;
      };
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
      HttpsOnlyMode = "force_enabled";
      HttpAllowlist = [ "http://100.100.69.99" ];
      SkipTermsOfUse = true;
      Extensions = {
        Install = [
          "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/betterttv/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-web-file-icons/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/refined-github-/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/steam-database/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/styl-us/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
        ];
      };
    };
  };
in

{
  home.file.".mozilla/firefox-policies.json".text = builtins.toJSON policies;

  home.activation.installFirefoxPolicies = lib.mkIf (_class == "darwin") (
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "/Applications/Twilight.app/Contents/Resources/distribution"
      cp ${config.home.homeDirectory}/.mozilla/firefox-policies.json "/Applications/Twilight.app/Contents/Resources/distribution/policies.json"
    ''
  );
}
