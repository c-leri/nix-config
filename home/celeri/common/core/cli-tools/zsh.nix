{
  pkgs,
  config,
  ...
}: let
  catppuccin-fsh = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "zsh-fsh";
    rev = "dd7baca6e0e943f36d1a6721820346e91f25065f";
    sha256 = "sha256-qd/+MHmgP+dOnYm6meSu5oCZ/TunCWGHnHqAXm79ERw=";
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
        ${pkgs.nix-your-shell}/bin/nix-your-shell zsh | source /dev/stdin

        # Expand ... (or more) into ../.. when pressing RETURN
        function _expand-dots-then-accept-line() {
            local MATCH
            if [[ $LBUFFER =~ '(^| )\.\.\.+' ]]; then
                LBUFFER=$LBUFFER:fs%\.\.\.%../..%
            fi
            zle accept-line
        }

        zle -N _expand-dots-then-accept-line
        bindkey '^M' _expand-dots-then-accept-line

        # Change default cursor
        _fix_cursor() {
          echo -ne '\e[5 q'
        }

        precmd_functions+=(_fix_cursor)

        # Change directory with yazi
        ycd() {
          chosen_path=$(yazi --chooser-file /dev/stdout)

          if [[ -d $chosen_path ]]; then
            cd $chosen_path
          elif [[ -f $chosen_path ]]; then
            cd $(path dirname $chosen_path)
          fi
        }

        # Initialize a projet from one of the template flakes defined in the nix-config directory
        flake-init() {
          if [[ $# == 1 ]] && [[ -z "$(ls -A .)" ]]; then
            nix flake init --template ${config.home.homeDirectory}/nix-config#$1

            if [[ $? == 0 ]]; then
              ${pkgs.rpl}/bin/rpl -R PROJECT_NAME $(path basename -- $PWD) * .*

              # run cargo update if the used template
              # is a rust template
              rust_templates=(rust rust-github bevy bevy-github)
              if [[ $rust_templates[(Ie)$1] ]]; then
                cargo update
              fi

              git init; git add .

              echo 'use flake' > .envrc
              direnv allow
            fi
          fi
        }
      '';
    shellAliases = {
      cl = "clear";
      open = "xdg-open";
      lgit = "lazygit";
      ls = "${pkgs.eza}/bin/eza --classify --icons --hyperlink --group-directories-first --sort=extension";
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
