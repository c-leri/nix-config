{
  pkgs,
  lib,
  config,
  ...
}: let
  catppuccin-fsh = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "zsh-fsh";
    rev = "a9bdf479f8982c4b83b5c5005c8231c6b3352e2a";
    sha256 = "sha256-WeqvsKXTO3Iham+2dI1QsNZWA8Yv9BHn1BgdlvR8zaw=";
  };
in {
  programs.zsh = {
    enable = true;
    autocd = true;
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
    };
    sessionVariables = {
      FAST_WORK_DIR = "XDG";
    };
    initExtra =
      /*
      zsh
      */
      ''
        # syntax highlighting catppuccin
        mkdir -p ${config.home.homeDirectory}/.config/fsh
        fast-theme -q ${catppuccin-fsh}/themes/catppuccin-macchiato.ini

        # nix-your-shell
        ${lib.getExe pkgs.nix-your-shell} zsh | source /dev/stdin

        # set helix as default editor if it is installed
        if command -v hx &> /dev/null; then
          export EDITOR=hx
        fi

        # Expand ... (or more) into ../.. when pressing RETURN
        _expand-dots-then-accept-line () {
            local MATCH
            if [[ $LBUFFER =~ '(^| )\.\.\.+' ]]; then
                LBUFFER=$LBUFFER:fs%\.\.\.%../..%
            fi
            zle accept-line
        }
        zle -N _expand-dots-then-accept-line
        bindkey '^M' _expand-dots-then-accept-line

        # Change default cursor
        _fix_cursor () {
          echo -ne '\e[5 q'
        }

        precmd_functions+=(_fix_cursor)

        # Change directory with yazi
        y () {
          # Setup tmp file
          local tmp="$(mktemp --tmpdir= "yazi-cwd.XXXXXX")" cwd

          # Open yazi writing cwd to tmp file
          yazi "$@" --cwd-file="$tmp"

          # cd into the path stored into the tmp file
          # if it's not empty and different from current working dir
          if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
          fi

          # Cleanup
          rm -f -- "$tmp"
        }

        # Initialize a projet from one of the template flakes defined in the nix-config directory
        flake-init () {
          # Not exactly one argument, abort
          if [[ $# != 1 ]]; then
            echo -e "\e[31mPlease provide a template name.\e[0m" >> /dev/stderr
            return 1
          fi

          # Folder not empty, confirm with the user
          if [ -n "$(command ls -A .)" ]; then
            echo "This folder is not empty, do you wish to continue? (y/N)"
            read yn

            case $yn in
              # y or Y, continue
              y|Y)
                ;;
              # Anything else, abort
              *)
                return 0
                ;;
            esac
          fi

          # Init the right flake in the current directory
          nix flake init --template ${config.home.homeDirectory}/nix-config#$1

          # flake init returned an error, abort
          if [[ $? != 0 ]]; then
            return $?
          fi

          # Replace all mentions of "PROJECT_NAME" in the project files with the name of the current directory
          ${lib.getExe pkgs.rpl} -F PROJECT_NAME ${"\${PWD##*/}"} flake.nix Cargo.toml .github/workflows/build.yml

          # Run additional setup commands
          case $1 in
            # Run cargo update for rust
            rust|rust-github|bevy|bevy-github)
              # Temporary lock file
              touch Cargo.lock
              nix develop --command bash -c "cargo update"
              ;;
            # Modify .gitignore and manually generate lock file for tauri
            tauri)
              echo "\n\n# Direnv\n/.direnv/\n/.envrc" >> .gitignore
              nix flake lock
              ;;
            # Manually generate the lock file in other cases
            *)
              nix flake lock
              ;;
          esac

          # Init the git repository
          git init; git add .

          # Init the .envrc file
          echo 'use flake' > .envrc
          direnv allow
        }
      '';
    shellAliases = {
      cl = "clear";
      open = "xdg-open";
      lgit = "lazygit";
      ls = "${lib.getExe pkgs.eza} --classify --icons --hyperlink --group-directories-first --sort=extension";
      l = "ls --long --header --mounts";
      la = "ls --all";
      ll = "l --all";
      lst = "ls --tree --level=2";
      lt = "l --tree --level=2";
      lat = "la --tree --level=2";
      llt = "ll --tree --level=2";
    };
    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];
  };
}
