{
  pkgs,
  lib,
  ...
}: {
  programs.anyrun = {
    enable = true;
    config = {
      closeOnClick = true;
      x = {
        fraction = 0.5;
      };
      y = {
        fraction = 0.3;
      };
      plugins = [
        "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/libwebsearch.so"
        "${pkgs.anyrun}/lib/libsymbols.so"
        "${pkgs.anyrun}/lib/librink.so"
      ];
    };
    extraConfigFiles."websearch.ron".text = ''
      Config(
        prefix: "?",
        // Options: Google, Ecosia, Bing, DuckDuckGo, Custom
        //
        // Custom engines can be defined as such:
        // Custom(
        //   name: "Searx",
        //   url: "searx.be/?q={}",
        // )
        //
        // NOTE: `{}` is replaced by the search query and `https://` is automatically added in front.
        engines: [DuckDuckGo]
      )
    '';
  };
}
