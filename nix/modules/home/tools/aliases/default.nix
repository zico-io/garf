{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.garf; let
  cfg = config.garf.tools.aliases;
  aliases = {
    # Misc
    nnn = "nnn -C";
    nn = "nnn";
    dev = "tmuxp load";

    # inception
    incept = "pipx run copier copy --trust gh:DataChefHq/Inception .";

    # dust
    dust = "du -b";
  };
in {
  options.garf.tools.aliases = with types; {
    enable = mkBoolOpt true "Enable shell aliases?";
  };

  config = mkIf cfg.enable {
    programs = {
      bash.shellAliases = aliases;
      fish.shellAliases = aliases;
      zsh.shellAliases = aliases;
    };
  };
}
