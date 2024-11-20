{
  pkgs,
  lib,
  ...
}: let
  explorer_command = pkgs.writeShellScriptBin "hx_explorer_command.sh" ''
    # First argument is path to tmp directory
    # Second argument is the id of the windows with helix open
    if [ $# -eq 2 ]; then
      # Launch yazi with custom conmfig
      # writing picked file to file in tmp directory
      YAZI_CONFIG_HOME="$1/yazi" yazi --chooser-file "$1/picked"

      # If a file has been picked
      if [ -s "$1/picked" ]; then
        # Send the escape key to enter normal mode
        kitten @ send-key --match id:$2 escape

        # Open the picked file
        kitten @ send-text --match id:$2 ":o $(command cat "$1/picked") \r"
      fi

      # Delete tmp directory
      rm -f $1
    fi

    # Close current window
    kitten @ close-window
  '';

  explorer = pkgs.writeShellScriptBin "hx_explorer.sh" ''
    # Only run in kitty with remote control on
    if [ -n "$KITTY_LISTEN_ON" ]; then
      # Create tmp directory
      tmp="$(mktemp -d --tmpdir= "hx_explorer.XXXXXX")"

      # Focus the window if one is already open or open a new one
      if ! kitten @ focus-window --match "title:\"hx explorer\"" > /dev/null; then
        # Setup yazi config
        cp -r "$HOME/.config/yazi" $tmp
        echo -e "\n[manager]\nratio = [ 0, 1, 0 ]\n" >> "$tmp/yazi/yazi.toml"
        # Uses no-status yazi plugin to hide status bar
        echo -e "\nrequire(\"no-status\"):setup()\n" >> "$tmp/yazi/init.lua"

        # Open yazi with its custom config in new window
        kitten @ launch --cwd=current --type=window --title="hx explorer" --location=vsplit --location=before --bias=20 --no-response ${lib.getExe explorer_command} $tmp $KITTY_WINDOW_ID
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
