{
  ...
}:
{
  # Set primary user
  system.primaryUser = "skyeav";
  # NixDarwin user configuration
  users.users.skyeav = {
    name = "skyeav";
    home = "/Users/skyeav";
  };
  # HOMEBREW
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    brews = [
      "pi-coding-agent"
      "kimi-code"
    ];
  };
}
