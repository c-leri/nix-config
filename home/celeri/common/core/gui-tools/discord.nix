{ inputs, ... }:
{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;

    discord.enable = false;
    vesktop.enable = true;

    config = {
      plugins = {
        gameActivityToggle.enable = true;
        imageZoom.enable = true;
        mentionAvatars.enable = true;
        previewMessage.enable = true;
        translate.enable = true;
        userMessagesPronouns.enable = true;
        voiceMessages.enable = true;
        volumeBooster.enable = true;
        webScreenShareFixes.enable = true;
        whoReacted.enable = true;

        showMeYourName = {
          enable = true;
          mode = "nick-user";
          displayNames = true;
          inReplies = true;
        };
      };
    };
  };
}
