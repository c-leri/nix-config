{
  # Nix settings
  nix.settings = {
    trusted-users = ["root"];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };
}
