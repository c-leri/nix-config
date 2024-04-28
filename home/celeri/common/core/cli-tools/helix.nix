{pkgs, ...}: {
  programs.helix = {
    enable = true;
    package = pkgs.unstable.helix;
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
      theme = "catppuccin_macchiato";
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
        ruff-lsp = {
          command = "${pkgs.ruff-lsp}/bin/ruff-lsp";
        };
      };

      language = [
        {
          name = "nix";
          formatter = {command = "${pkgs.alejandra}/bin/alejandra";};
          auto-format = true;
        }
        {
          name = "python";
          language-servers = ["pylsp" "ruff-lsp"];
          formatter = {
            command = "${pkgs.black}/bin/black";
            args = ["--quiet" "-"];
          };
          auto-format = true;
        }
      ];
    };
    themes = {
      catppuccin_macchiato = let
        # catppuccin palette colors
        rosewater = "#f4dbd6";
        flamingo = "#f0c6c6";
        pink = "#f5bde6";
        mauve = "#c6a0f6";
        red = "#ed8796";
        maroon = "#ee99a0";
        peach = "#f5a97f";
        yellow = "#eed49f";
        green = "#a6da95";
        teal = "#8bd5ca";
        sky = "#91d7e3";
        sapphire = "#7dc4e4";
        blue = "#8aadf4";
        lavender = "#b7bdf8";

        text = "#cad3f5";
        subtext1 = "#b8c0e0";
        subtext0 = "#a5adcb";
        overlay2 = "#939ab7";
        overlay1 = "#8087a2";
        overlay0 = "#6e738d";
        surface2 = "#5b6078";
        surface1 = "#494d64";
        surface0 = "#363a4f";

        base = "#24273a";
        mantle = "#1e2030";
        crust = "#181926";

        # derived colors by blending existing palette colors
        cursorline = "#303347";
        secondary_cursor = "#b6a5a7";
      in {
        # Syntax highlighting
        # -------------------
        "type" = yellow;

        "constructor" = sapphire;

        "constant" = peach;
        "constant.builtin" = peach;
        "constant.character" = teal;
        "constant.character.escape" = pink;

        "string" = green;
        "string.regexp" = peach;
        "string.special" = blue;

        "comment" = {
          fg = overlay1;
          modifiers = ["italic"];
        };

        "variable" = text;
        "variable.parameter" = {
          fg = maroon;
          modifiers = ["italic"];
        };
        "variable.builtin" = red;
        "variable.other.member" = teal;

        "label" = sapphire;

        "punctuation" = overlay2;
        "punctuation.special" = sky;

        "keyword" = mauve;
        "keyword.control.conditional" = {
          fg = mauve;
          modifiers = ["italic"];
        };

        "operator" = sky;

        "function" = blue;
        "function.macro" = mauve;

        "tag" = mauve;
        "attribute" = blue;

        "namespace" = {
          fg = blue;
          modifiers = ["italic"];
        };

        "special" = blue;

        "markup.heading.marker" = {
          fg = peach;
          modifiers = ["bold"];
        };
        "markup.heading.1" = lavender;
        "markup.heading.2" = mauve;
        "markup.heading.3" = green;
        "markup.heading.4" = yellow;
        "markup.heading.5" = pink;
        "markup.heading.6" = teal;
        "markup.list" = mauve;
        "markup.bold" = {modifiers = ["bold"];};
        "markup.italic" = {modifiers = ["italic"];};
        "markup.link.url" = {
          fg = rosewater;
          modifiers = ["italic" "underline"];
        };
        "markup.link.text" = blue;
        "markup.raw" = flamingo;

        "diff.plus" = green;
        "diff.minus" = red;
        "diff.delta" = blue;

        # User Interface
        # --------------
        "ui.background" = {
          fg = text;
          bg = base;
        };

        "ui.linenr" = {fg = surface1;};
        "ui.linenr.selected" = {fg = lavender;};

        "ui.statusline" = {
          fg = subtext1;
          bg = mantle;
        };
        "ui.statusline.inactive" = {
          fg = surface2;
          bg = mantle;
        };
        "ui.statusline.normal" = {
          fg = base;
          bg = lavender;
          modifiers = ["bold"];
        };
        "ui.statusline.insert" = {
          fg = base;
          bg = green;
          modifiers = ["bold"];
        };
        "ui.statusline.select" = {
          fg = base;
          bg = flamingo;
          modifiers = ["bold"];
        };

        "ui.popup" = {
          fg = text;
          bg = surface0;
        };
        "ui.window" = {fg = crust;};
        "ui.help" = {
          fg = overlay2;
          bg = surface0;
        };

        "ui.bufferline" = {
          fg = subtext0;
          bg = mantle;
        };
        "ui.bufferline.active" = {
          fg = mauve;
          bg = base;
          underline = {
            color = mauve;
            style = "line";
          };
        };
        "ui.bufferline.background" = {bg = crust;};

        "ui.text" = text;
        "ui.text.focus" = {
          fg = text;
          bg = surface0;
          modifiers = ["bold"];
        };
        "ui.text.inactive" = {fg = overlay1;};

        "ui.virtual" = overlay0;
        "ui.virtual.ruler" = {bg = surface0;};
        "ui.virtual.indent-guide" = surface0;
        "ui.virtual.inlay-hint" = {
          fg = surface1;
          bg = mantle;
        };

        "ui.selection" = {bg = surface1;};

        "ui.cursor" = {
          fg = base;
          bg = secondary_cursor;
        };
        "ui.cursor.primary" = {
          fg = base;
          bg = rosewater;
        };
        "ui.cursor.match" = {
          fg = peach;
          modifiers = ["bold"];
        };

        "ui.cursorline.primary" = {bg = cursorline;};

        "ui.highlight" = {
          bg = surface1;
          modifiers = ["bold"];
        };

        "ui.menu" = {
          fg = overlay2;
          bg = surface0;
        };
        "ui.menu.selected" = {
          fg = text;
          bg = surface1;
          modifiers = ["bold"];
        };

        "diagnostic.error" = {
          underline = {
            color = red;
            style = "curl";
          };
        };
        "diagnostic.warning" = {
          underline = {
            color = yellow;
            style = "curl";
          };
        };
        "diagnostic.info" = {
          underline = {
            color = sky;
            style = "curl";
          };
        };
        "diagnostic.hint" = {
          underline = {
            color = teal;
            style = "curl";
          };
        };

        error = red;
        warning = yellow;
        info = sky;
        hint = teal;
      };
    };
  };
}