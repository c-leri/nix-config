{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      # C
      clang-tools

      # Nix
      nil
      nixd
      nixfmt

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
      ruff

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
    };
    languages = {
      language-server = {
        nixd = {
          command = "nixd";
        };

        ruff = {
          command = "ruff";
        };

        rust-analyzer.config.check = {
          command = "clippy";
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
          language-servers = [
            "nixd"
            "nil"
          ];
          formatter = {
            command = "nixfmt";
          };
          auto-format = true;
        }
        {
          name = "python";
          language-servers = [
            "pylsp"
            "ruff"
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
