{pkgs, ...}: {
  programs.helix = {
    enable = true;
    catppuccin.enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      clang-tools

      nil

      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted

      python3Packages.python-lsp-server
      python3Packages.python-lsp-ruff

      taplo

      zls
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
      };
    };
    languages = {
      language-server = {
        ruff-lsp = {
          command = "${pkgs.ruff-lsp}/bin/ruff-lsp";
        };
      };

      language = [
        {
          name = "nix";
          formatter = {
            command = "${pkgs.alejandra}/bin/alejandra";
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
            command = "${pkgs.black}/bin/black";
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
