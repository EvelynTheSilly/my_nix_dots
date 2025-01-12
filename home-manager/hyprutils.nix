{pkgs, lib,...}:


{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/images/wallpapers/wp.png"
        "~/images/wallpapers/wp2.png"
      ];
      wallpaper = [
        "DP-1, ~/images/wallpapers/wp.png"
        "DP-2, ~/images/wallpapers/wp2.png"
      ];
    };
  };
  programs.hyprlock = {
    enable = true;
    settings = {

      "$accent" = "rgb(cba6f7)"; #mauve accent
      "$surface0" = "rbg(313244)";
      "$text" = "rbg(cdd6f4)"; #mauve accent
      "$textAlpha" = "cdd6f4";
      "$accentAlpha" = "cba6f7";
      "$red" = "rbg(f38ba8)";
      "$yellow" = "rbg(f9e2af)";

      general = {
        hide_cursor = false;
      };

      background = {
        monitor = "";
        path = "/home/vlad/images/wallpapers/lockscreen.png";
        blur_passes = 0;
      };

      input-field = {
        monitor = "";
        size = "300, 60";
        outline_thickness = 4;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "$accent";
        inner_color = "$surface0";
        font_color = "$text";
        fade_on_empty = false;
        placeholder_text = ''<span foreground="##$textAlpha"><i>󰌾 Logged in as </i><span foreground="##$accentAlpha">$USER</span></span>'';
        hide_input = false;
        check_color = "$accent";
        fail_color = "$red";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        capslock_color = "$yellow";
        position = "0, -47";
        halign = "center";
        valign = "center";
      };
    };
  };
}
