{
  pkgs,
  lib,
  ...
}: {
  programs.git = {
    enable = true;
    settings = {
      pull.rebase = "true";
      user.name = "Evelyn";
      user.email = "45495711+EvelynTheSilly@users.noreply.github.com. ";
    };
  };
}
