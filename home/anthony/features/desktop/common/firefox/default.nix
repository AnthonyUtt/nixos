{ pkgs, inputs, ... }:
let
  bookmarks = import ./bookmarks.nix;
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
    profiles = {
      dev-edition-default = {
        bookmarks = bookmarks;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          beyond-20
          bitwarden
          clearurls
          darkreader
          enhanced-github
          gaoptout
          gruvbox-dark-theme
          history-cleaner
          istilldontcareaboutcookies
          onepassword-password-manager
          privacy-badger
          privacy-possum
          react-devtools
          reduxdevtools
          rust-search-extension
          sidebery
          sourcegraph
          sponsorblock
          tabliss
          terms-of-service-didnt-read
          tomato-clock
          ublock-origin
          webhint
        ];
        search = {
          default = "DuckDuckGo";
          force = true;
        };
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        userChrome = builtins.readFile ./userChrome.css;
      };
    };
  };

  home = {
    sessionVariables.BROWSER = "firefox";
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
