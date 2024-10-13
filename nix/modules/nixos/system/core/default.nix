{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.garf;

let
  cfg = config.garf.system;
in
{
  options.garf.system = with types; {
    hostName = mkOpt str "garf-atom" "Host Name for this machine.";
    timeZone = mkOpt str "America/New_York" "System Time Zone.";
    locale = mkOpt str "en_US.UTF-8" "Default System Locale.";
    keyMap = mkOpt str "us" "System Keyboard Mapping.";
    version = mkOpt str "24.05" "System NixOS Version.";
    shell = mkOpt (nullOr (enum [
      "bash"
      "zsh"
      "fish"
    ])) "zsh" "Default system shell";
    type = mkOpt (nullOr (enum [ "minimal" ])) null "Type of installation for this machine.";
  };

  config = {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "@wheel" ];
    };

    time.timeZone = cfg.timeZone;
    console.keyMap = cfg.keyMap;
    i18n = {
      defaultLocale = cfg.locale;
      extraLocaleSettings = {
        LC_ADDRESS = cfg.locale;
        LC_IDENTIFICATION = cfg.locale;
        LC_MEASUREMENT = cfg.locale;
        LC_MONETARY = cfg.locale;
        LC_NAME = cfg.locale;
        LC_NUMERIC = cfg.locale;
        LC_PAPER = cfg.locale;
        LC_TELEPHONE = cfg.locale;
        LC_TIME = cfg.locale;
      };
    };

    networking.hostName = cfg.hostName;

    programs.${cfg.shell} = enabled;

    environment = {
      localBinInPath = true;
      variables.EDITOR = "hx";
      systemPackages = with pkgs; [
        age
        sops
        helix
        devenv
      ];
    };

    system.stateVersion = cfg.version;
  };
}
