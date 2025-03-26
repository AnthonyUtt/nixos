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
        bookmarks = {
          force = true;
          settings = bookmarks;
        };
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          beyond-20
          bitwarden
          # clearurls
          darkreader
          enhanced-github
          gaoptout
          gruvbox-dark-theme
          history-cleaner
          istilldontcareaboutcookies
          onepassword-password-manager
          privacy-badger
          privacy-possum
          # pywalfox
          react-devtools
          reduxdevtools
          rust-search-extension
          sidebery
          sourcegraph
          sponsorblock
          stylus
          tabliss
          terms-of-service-didnt-read
          tomato-clock
          ublock-origin
          webhint
        ];
        search = {
          default = "ddg";
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

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "x-scheme-handler/http" = [ "firefox-devedition.desktop" ];
      "x-scheme-handler/https" = [ "firefox-devedition.desktop" ];
      "x-scheme-handler/chrome" = [ "firefox-devedition.desktop" ];
      "text/html" = [ "firefox-devedition.desktop" ];
      "application/x-extension-htm" = [ "firefox-devedition.desktop" ];
      "application/x-extension-html" = [ "firefox-devedition.desktop" ];
      "application/x-extension-shtml" = [ "firefox-devedition.desktop" ];
      "application/xhtml+xml" = [ "firefox-devedition.desktop" ];
      "application/x-extension-xhtml" = [ "firefox-devedition.desktop" ];
      "application/x-extension-xht" = [ "firefox-devedition.desktop" ];
    };
    defaultApplications = {
      "text/html" = [ "firefox-devedition.desktop" ];
      "text/xml" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox-devedition.desktop" ];
      "x-scheme-handler/https" = [ "firefox-devedition.desktop" ];
      "x-scheme-handler/chrome" = [ "firefox-devedition.desktop" ];
      "application/x-extension-htm" = [ "firefox-devedition.desktop" ];
      "application/x-extension-html" = [ "firefox-devedition.desktop" ];
      "application/x-extension-shtml" = [ "firefox-devedition.desktop" ];
      "application/xhtml+xml" = [ "firefox-devedition.desktop" ];
      "application/x-extension-xhtml" = [ "firefox-devedition.desktop" ];
      "application/x-extension-xht" = [ "firefox-devedition.desktop" ];
    };
  };
}
