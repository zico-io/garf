{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.garf;
let
  cfg = config.garf.apps.helix;
  helixPkgs = with pkgs; [
    nixd
    nixfmt-rfc-style
    rust-analyzer
    nodePackages.bash-language-server
    nodePackages.yaml-language-server
    nodePackages.typescript-language-server
  ];
  helixWrapped = pkgs.writeShellScriptBin "hx" ''
    PATH="${lib.makeBinPath helixPkgs}:$PATH"
    ${pkgs.helix}/bin/hx "$@"
  '';
in
{
  options.garf.apps.helix = with types; {
    enable = mkBoolOpt false "Enable helix?";
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      package = helixWrapped;

      settings = {
        editor = {
          auto-format = true;
          line-number = "relative";
          lsp.display-messages = true;
          statusline = {
            left = [
              "mode"
              "version-control"
            ];
            center = [ "file-name" ];
          };
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
        };

        keys.normal = {
          C.g = ":sh tmux popup -d \"#{pane_current_path}\" -xC -yC -w80% -h80% -E gitui";
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];
        };
      };

      languages = {
        language-server.nixd.command = "nixd";
        language = [
          {
            name = "typescript";
            auto-format = true;
            formatter = {
              command = "prettier";
              args = [
                "--parser"
                "typescript"
              ];
            };
          }
          {
            name = "tsx";
            auto-format = true;
            formatter = {
              command = "prettier";
              args = [
                "--parser"
                "typescript"
              ];
            };
          }
          {
            name = "jsx";
            auto-format = true;
            formatter = {
              command = "prettier";
              args = [
                "--parser"
                "typescript"
              ];
            };
          }
          {
            name = "nix";
            language-servers = [ "nixd" ];
            auto-format = true;
            formatter = {
              command = "nixfmt";
            };
          }
        ];
      };
    };
  };
}
