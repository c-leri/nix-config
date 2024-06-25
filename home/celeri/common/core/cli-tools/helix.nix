{pkgs, ...}: let
  explorer = pkgs.writeShellScriptBin "explorer.sh" ''
    left_pane_id=$(wezterm cli get-pane-direction left)
    if [ -n "$left_pane_id" ]; then
      left_program=$(wezterm cli list | awk -v pane_id="$left_pane_id" '$3==pane_id { print $6 }')
    fi

    if [[ -z "$left_pane_id" || "$left_program" != "Yazi:"* ]]; then
      left_pane_id=$(wezterm cli split-pane --left --cells 30 -- sh)

      rm -r /tmp/yazi_tree
      cp -r "$HOME/.config/yazi" /tmp/yazi_tree
      echo -e "\n[manager]\nratio = [ 0, 8, 0 ]\n" >>/tmp/yazi_tree/yazi.toml
      echo -e "\nfunction Status:render() return {} end\nlocal old_manager_render = Manager.render\nfunction Manager:render(area)\n\treturn old_manager_render(self, ui.Rect { x = area.x, y = area.y, w = area.w, h = area.h + 1 })\nend\n" >>/tmp/yazi_tree/init.lua

      echo "chosen_file=\$(YAZI_CONFIG_HOME=/tmp/yazi_tree yazi --chooser-file /dev/stdout); echo -e \"\e :o \$chosen_file \r\" | wezterm cli send-text --pane-id $WEZTERM_PANE --no-paste; exit" | wezterm cli send-text --pane-id "$left_pane_id" --no-paste
    fi

    wezterm cli activate-pane-direction left
  '';
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
