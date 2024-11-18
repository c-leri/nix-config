{
  pkgs,
  lib,
  ...
}: let
  explorer_command = pkgs.writeShellScriptBin "hx_explorer_command.sh" ''
    if [ $# -eq 1 ]; then
      # Launch yazi with custom config
      YAZI_CONFIG_HOME=/tmp/hx_explorer/yazi yazi --chooser-file /tmp/hx_explorer/picked

      # If a file as been picked
      if [ -s /tmp/hx_explorer/picked ]; then
        # Send the escape key to enter normal mode
        kitten @ send-key --match id:$1 escape

        # Open the picked file
        kitten @ send-text --match id:$1 ":o $(cat /tmp/hx_explorer/picked) \r"
      fi
    fi

    # Reset picked file
    rm -f /tmp/hx_explorer/picked

    # Close current window
    kitten @ close-window
  '';

  explorer = pkgs.writeShellScriptBin "hx_explorer.sh" ''
    # Only run in kitty with remote control on
    if [ -n "$KITTY_LISTEN_ON" ]; then
      # Makes sure that the working directory exists
      mkdir -p /tmp/hx_explorer

      # Focus the window if one is already open or open a new one
      if ! kitten @ focus-window --match title:\"hx\ explorer\" > /dev/null; then
        # Setup yazi config
        rm -rf /tmp/hx_explorer/yazi
        cp -r "$HOME/.config/yazi" /tmp/hx_explorer/yazi
        echo -e "\n[manager]\nratio = [ 0, 8, 0 ]\n" >> /tmp/hx_explorer/yazi/yazi.toml
        echo -e "\nfunction Status:render() return {} end\nlocal old_manager_render = Manager.render\nfunction Manager:render(area)\n\treturn old_manager_render(self, ui.Rect { x = area.x, y = area.y, w = area.w, h = area.h + 1 })\nend\n" >> /tmp/hx_explorer/yazi/init.lua

        # Open yazi in new window
        kitten @ launch --cwd=current --type=window --title="hx explorer" --location=vsplit --location=before --bias=30 --no-response ${lib.getExe explorer_command} $KITTY_WINDOW_ID
      fi
    fi
  '';
in {
  programs.helix = {
    enable = true;
    catppuccin.enable = true;
    extraPackages = with pkgs; [
      # C
      clang-tools

      # Nix
      alejandra
      nil
      nixd

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
        C-g = '':sh if [ -n "$KITTY_LISTEN_ON" ]; then kitten @ launch --cwd current --type=overlay ${lib.getExe pkgs.lazygit} > /dev/null; fi'';
        C-e = ":sh ${lib.getExe explorer}";
      };
    };
    languages = {
      language-server = {
        nixd = {
          command = "nixd";
        };

        ruff-lsp = {
          command = "ruff-lsp";
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
