{
  programs.git = {
    enable = true;
    userName = "celeri";
    userEmail = "celestin.bouchet@gmail.com";

    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
      };
    };

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
