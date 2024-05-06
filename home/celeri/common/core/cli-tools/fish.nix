{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs.fishPlugins; [
    autopair
    puffer
  ];

  programs.fish = {
    enable = true;
    catppuccin.enable = true;
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
    shellAliases = {
      cl = "clear";
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
    functions = {
      ycd = ''
        set chosen_path $(yazi --chooser-file /dev/stdout);
        if path is -d $chosen_path
          cd $chosen_path
        else if path is -f $chosen_path
          cd $(path dirname $chosen_path)
        end
      '';
      flake-init = ''
        if test $(count $argv) = 1 && test -z "$(ls -A .)"
          nix flake init --template ${config.home.homeDirectory}/nix-config#$argv[1]

          if test $status = 0
            ${pkgs.rpl}/bin/rpl -R PROJECT_NAME $(path basename -- $PWD) * .*

            # run cargo update if the used template
            # is a rust template
            set rust_templates rust rust-github bevy bevy-github
            if contains -- $argv[1] $rust_templates
              cargo update
            end

            git init; git add .

            echo 'use flake' > .envrc
            direnv allow

            return
          end
        end
      '';
    };
  };
}
