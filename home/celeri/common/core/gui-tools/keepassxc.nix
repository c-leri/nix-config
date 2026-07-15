{
  programs.keepassxc = {
    enable = true;
    settings = {
      Browser = {
        Enabled = true;
      };
      GUI = {
        ApplicationTheme = "auto";
        ColorPasswords = true;
        MinimizeOnClose = true;
        MinimizeOnStartup = true;
        ShowTrayIcon = true;
        TrayIconAppearance = "colorful";
      };
      Security = {
        IconDownloadFallback = true;
      };
      PasswordGenerator = {
        AdvancedMode = true;
        Length = 24;
        LowerCase = true;
        UpperCase = true;
        Punctuation = true;
        Dashes = true;
        Logograms = true;
        Math = true;
      };
    };
  };
}
