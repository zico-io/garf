{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.garf; let
  cfg = config.garf.tools.eza;
  aliases = {
    ls = mkDefault "eza";
    tree = mkDefault "eza --tree --level=2";
  };
in {
  options.garf.tools.eza = with types; {
    enable = mkBoolOpt false "Enable eza?";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [eza];
    programs = {
      eza = {
        enable = true;
        icons = true;
        git = true;
        enableZshIntegration = true;
        extraOptions = [
          "--long"
          "--group-directories-first"
          "--no-filesize"
          "--no-time"
          "--no-user"
        ];
      };
      fish.shellAliases = aliases;
      bash.shellAliases = aliases;
      zsh.shellAliases = aliases;
    };
  };
}
