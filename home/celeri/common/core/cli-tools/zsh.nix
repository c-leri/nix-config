{
  pkgs,
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
