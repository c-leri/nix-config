{pkgs, ...}: let
  explorer = pkgs.writeShellScriptBin "explorer.sh" (builtins.readFile ./explorer.sh);
in {
  # Set helix as default editor
  home.sessionVariables.VISUAL = "hx";

  programs.helix = {
    enable = true;
    package = pkgs.unstable.helix;
    catppuccin.enable = true;
    extraPackages = with pkgs; [
      # C
      clang-tools

      # Nix
      alejandra
      nil

      # Bash
      nodePackages.bash-language-server
      shfmt

      # Typescript
      nodePackages.typescript
      nodePackages.typescript-language-server

      # Javascript/HTML/CSS
      nodePackages.vscode-langservers-extracted

      # Python
      black
      python3Packages.python-lsp-server
      python3Packages.python-lsp-ruff
      ruff-lsp

      # Toml
      taplo

      # Yaml
      yaml-language-server
    ];
    settings = {
      editor = {
        cursorline = true;
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
        soft-wrap.enable = true;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };
      keys.normal = {
        C-g = [
          ":new"
          ":insert-output ${pkgs.lazygit}/bin/lazygit"
          ":buffer-close!"
          ":redraw"
        ];
        C-e = ":sh ${explorer}/bin/explorer.sh";
      };
    };
    languages = {
      language-server = {
        ruff-lsp = {
          command = "ruff-lsp";
        };

        yaml-language-server.config.yaml = {
          validation = true;
          schemas = {
            "https://json.schemastore.org/github-workflow.json" = ".github/workflows/*.{yml,yaml}";
          };
        };
      };

      language = [
        {
          name = "bash";
          formatter = {
            command = "shfmt";
          };
          auto-format = true;
        }
        {
          name = "nix";
          formatter = {
            command = "alejandra";
          };
          auto-format = true;
        }
        {
          name = "python";
          language-servers = [
            "pylsp"
            "ruff-lsp"
          ];
          formatter = {
            command = "$black";
            args = [
              "--quiet"
              "-"
            ];
          };
          auto-format = true;
        }
      ];
    };
  };
}
