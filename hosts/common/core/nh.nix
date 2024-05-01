{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--nogcroots";
      dates = "daily";
    };
  };
}
