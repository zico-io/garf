{ config, lib, pkgs, ... }:

with lib;
with lib.garf;

let cfg = config.garf.tools.zsh;
in {
  options.garf.tools.zsh = with types; {
    enable = mkBoolOpt false "Enable ZSH.";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
    };
  };
}
