{
  programs.eza = {
    enable = true;
    colors = "auto";
    icons = "auto";
    git = true;
    extraOptions = [
      # Display
      "--classify"
      "--hyperlink"
      # Sort
      "--sort=extension"
      "--group-directories-first"
      # Long view
      "--header"
      "--mounts"
    ];
  };
}
