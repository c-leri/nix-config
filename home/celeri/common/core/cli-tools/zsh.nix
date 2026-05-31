{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    autocd = true;
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
    };
    syntaxHighlighting.enable = true;
    initContent = /* zsh */ ''
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
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];
  };
}
