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
}
