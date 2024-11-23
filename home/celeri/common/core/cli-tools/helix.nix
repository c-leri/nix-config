{
  pkgs,
  lib,
  ...
}: let
  open_file = pkgs.writeShellScriptBin "hx_open_file.sh" ''
    # First argument is the id of the kitty window with helix running
    # Second argument is the file or folder to open

    # If the file or folder to open does exist
    if [ -f "$2" ] || [ -d "$2" ]; then
      # Send the escape key to enter normal mode
      kitten @ send-key --match id:$1 escape

      # Open the picked file or folder
      kitten @ send-text --match id:$1 ":o $2\r"
    fi
  '';

  explorer = pkgs.writeShellScriptBin "hx_explorer.sh" ''
    # First argument is the id of the windows with helix open
    # Second optional argument is the path to a temp yazi config dir

    # Temp file to store the path to the picked file
    picked_file=$(mktemp)

    # Second argument is present and a directory
    # launch yazi with it as config
    if [ -d "$2" ]; then
      YAZI_CONFIG_HOME=$2 yazi --chooser-file "$picked_file"
    else
      yazi --chooser-file "$picked_file"
    fi

    # Open picked file in helix
    ${lib.getExe open_file} $1 $(command cat $picked_file)

    # Delete temp file
    rm -f $picked_file

    # Delete temp yazi config dir if present
    if [ -d "$2" ]; then
      rm -rf $2
    fi

    # Close current window
    kitten @ close-window
  '';

  side_explorer = pkgs.writeShellScriptBin "hx_side_explorer.sh" ''
    # Only run in kitty with remote control on
    if [ -n "$KITTY_LISTEN_ON" ]; then
      # Create tmp config directory
      yazi_config=$(mktemp -d)

      # Focus the window if one is already open or open a new one
      if ! kitten @ focus-window --match "title:\"hx explorer\"" > /dev/null; then
        # Setup yazi config
        cp -r "$HOME/.config/yazi/." $yazi_config
        echo -e "\n[manager]\nratio = [ 0, 1, 0 ]\n" >> "$yazi_config/yazi.toml"
        # Uses no-status yazi plugin to hide status bar
        echo -e "\nrequire(\"no-status\"):setup()\n" >> "$yazi_config/init.lua"

        # Open yazi with its custom config in new split window to the left
        kitten @ launch --cwd=current --type=window --title="hx explorer" --location=vsplit --location=before --bias=20 --no-response -- ${lib.getExe explorer} $KITTY_WINDOW_ID $yazi_config
      fi
    fi
  '';

  full_explorer = pkgs.writeShellScriptBin "hx_full_explorer.sh" ''
    # Only run in kitty with remote control on
    if [ -n "$KITTY_LISTEN_ON" ]; then
      # Open yazi in new overlay window
      kitten @ launch --cwd=current --type=overlay --no-response -- ${lib.getExe explorer} $KITTY_WINDOW_ID
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
        C-m = ":sh ${lib.getExe side_explorer}";
        C-S-m = ":sh ${lib.getExe full_explorer}";
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
