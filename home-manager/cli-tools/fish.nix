{
  programs.eza.enable = true;
  programs.starship.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Remove greetings
      set fish_greeting

      # vi mode
      fish_vi_key_bindings

      # Set the cursor shape for the different vi modes
      set fish_cursor_default block blink
      set fish_cursor_insert line blink
      set fish_cursor_replace_one underscore blink
      set fish_cursor_visual block

      # nix-shell
      any-nix-shell fish --info-right | source
    '';
    shellAbbrs = {
      rebuild = "sudo nixos-rebuild switch --flake '/home/celeri/nixos-config#TRONC-Linux'";
    };
    shellAliases = {
      ls = "eza --classify --icons --group-directories-first --sort=extension";
      l = "ls --long --header --mounts";
      la = "ls --all";
      ll = "l --all";
      lst = "ls --tree --level=2";
      lt = "l --tree --level=2";
      lat = "la --tree --level=2";
      llt = "ll --tree --level=2";
    };
  };
}
