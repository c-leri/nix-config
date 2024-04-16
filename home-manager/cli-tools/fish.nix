{ pkgs, ... }:

{
  home.packages = with pkgs.fishPlugins; [
    autopair
    puffer
  ];

  programs.starship.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Remove greetings
      set fish_greeting

      # vi mode
      fish_vi_key_bindings
      set fish_vi_force_cursor 1

      # Set the cursor shape for the different vi modes
      set fish_cursor_default block blink
      set fish_cursor_insert line blink
      set fish_cursor_replace_one underscore blink
      set fish_cursor_visual block

      # nix-your-shell
      ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source
    '';
    shellAbbrs = {
      rebuild = "sudo nixos-rebuild switch --flake '/home/celeri/nixos-config#TRONC'";
      remove-old-generations = ''
        sudo nix-collect-garbage -d
        nix-collect-garbage -d
        sudo /run/current-system/bin/switch-to-configuration boot
      '';
    };
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --classify --icons --hyperlink --group-directories-first --sort=extension";
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
