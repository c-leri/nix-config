{ inputs, ... }:
{
  zen-browser = final: _prev: {
    zen-browser = inputs.zen-browser.packages.${final.stdenv.hostPlatform.system}.default;
  };
}
