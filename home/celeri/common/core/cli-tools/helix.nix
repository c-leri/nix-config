{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # C
      clang-tools

      # Nix
      nil
      nixd
      nixfmt

      # Bash
      bash-language-server
      shfmt

      # Typescript
      typescript
      typescript-language-server

      # Javascript/HTML/CSS
      vscode-langservers-extracted

      # Python
      ruff
      ty

      # Toml
      tombi

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
          args = [ "server" ];
        };

        rust-analyzer.config.check = {
          command = "clippy";
        };

        ty = {
          command = "ty";
          args = [ "server" ];
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
            "ruff"
            "ty"
          ];
          auto-format = true;
        }
      ];
    };
  };
}
