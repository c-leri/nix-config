{pkgs, ...}: let
  open_file = pkgs.writeShellScript "hx_open_file" ''
    # First argument is the id of the kitty window with helix running
    # Second argument is the file or folder to open
    # Third optional argument is the line to open the file at

    # Second argument is not empty
    if [ -n "$2" ]; then
      # Send the escape key to enter normal mode
      kitten @ send-key --match id:$1 escape

      # Third argument not empty and second argument leads to a file
      if [ -n "$3" ] && [ -f "$2" ]; then
        # Open the picked file at the picked line
        kitten @ send-text --match id:$1 ":o $2:$3\r"
      else
        # Open the picked file or folder
        kitten @ send-text --match id:$1 ":o $2\r"
      fi
    fi
  '';

  explorer = pkgs.writeShellScript "hx_explorer" ''
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
    ${open_file} $1 $(command cat $picked_file)

    # Delete temp file
    rm -f $picked_file

    # Delete temp yazi config dir if present
    if [ -d "$2" ]; then
      rm -rf $2
    fi

    # Close current window
    kitten @ close-window
  '';

  side_explorer = pkgs.writeShellScript "hx_side_explorer" ''
    # Only run in kitty with remote control on
    if [ -n "$KITTY_LISTEN_ON" ]; then
      # Create tmp config directory
      yazi_config=$(mktemp -d)

      # Focus the window if one is already open
      if ! kitten @ focus-window --match "title:\"hx explorer\"" > /dev/null; then
        # Setup yazi config
        cp -r "$HOME/.config/yazi/." $yazi_config
        echo -e "\n[manager]\nratio = [ 0, 1, 0 ]\n" >> "$yazi_config/yazi.toml"
        # Uses no-status yazi plugin to hide status bar
        echo -e "\nrequire(\"no-status\"):setup()\n" >> "$yazi_config/init.lua"

        # Open yazi with its custom config in new split window to the left
        kitten @ launch --cwd=current --type=window --title="hx explorer" --location=vsplit --location=before --bias=20 --no-response -- ${explorer} $KITTY_WINDOW_ID $yazi_config
      fi
    fi
  '';

  full_explorer = pkgs.writeShellScript "hx_full_explorer" ''
    # Only run in kitty with remote control on
    if [ -n "$KITTY_LISTEN_ON" ]; then
      # Focus the side explorer if one is already open
      if ! kitten @ focus-window --match "title:\"hx explorer\"" > /dev/null; then
        # Open yazi in new overlay window
        kitten @ launch --cwd=current --type=overlay-main --title="hx explorer" --no-response -- ${explorer} $KITTY_WINDOW_ID
      fi
    fi
  '';

  git_explorer = pkgs.writeShellScript "hx_git_explorer" ''
    # First argument is the id of the windows with helix open
    # Second argument is the path to the temp lazygit config file

    # Shorthand to delete the temp config file and close the window
    close="rm -f $2; kitten @ close-window"

    # Change the edit commands to open the file in the current helix instance
    echo 'os:
      edit: "${open_file} '"$1"' {{filename}}; '"$close"'"
      editAtLine: "${open_file} '"$1"' {{filename}} {{line}}; '"$close"'"
      openDirInEditor: "${open_file} '"$1"' {{dir}}; '"$close"'"
    ' > $2

    lazygit

    eval $close
  '';

  full_git_explorer = pkgs.writeShellScript "hx_full_git_explorer" ''
    # Only run in kitty with remote control on
    if [ -n "$KITTY_LISTEN_ON" ]; then
      # Find the root of the repo
      repo_root=$(git rev-parse --show-toplevel 2> /dev/null)

      # Not a repo, abort
      if [ -z "$repo_root" ]; then
        echo "Not a repository." >> /dev/stderr
        exit 1
      fi

      # Local config file for lazygit
      config_file="$repo_root/.git/lazygit.yml"

      # Config file already exists, abort
      if [ -f "$config_file" ]; then
        echo "Config file already exists." >> /dev/stderr
        exit 1
      fi

      # Open lazygit in new overlay window
      kitten @ launch --cwd=current --type=overlay-main --title="hx git explorer" --no-response -- ${git_explorer} $KITTY_WINDOW_ID $config_file
    fi
  '';
in {
  programs.helix = {
    enable = true;
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
        C-g = ":sh ${full_git_explorer}";
        C-m = ":sh ${side_explorer}";
        C-S-m = ":sh ${full_explorer}";
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
