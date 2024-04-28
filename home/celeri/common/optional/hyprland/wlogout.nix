{pkgs, ...}: {
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Logout";
        keybind = "i";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "o";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "p";
      }
    ];
    style = ''
      * {
        background-image: none;
      }

      window {
        background-color: rgba(0, 0, 0, 0.4);
      }

      button {
        font-family: "CaskaydiaCove Nerd Font";
        font-size: 1.4rem;
        color: #cad3f5;
        background-color: #24273a;
        border: 2px solid #181926;
        border-radius: 10px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 40%;
        margin: 50px;
      }

      button:focus {
        outline: 5px solid #c6a0f6;
      }

      #logout {
        background-image: image(
          url("${pkgs.wlogout}/share/wlogout/icons/logout.png")
        );
      }

      #reboot {
        background-image: image(
          url("${pkgs.wlogout}/share/wlogout/icons/reboot.png")
        );
      }

      #shutdown {
        background-image: image(
          url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png")
        );
      }
    '';
  };
}
