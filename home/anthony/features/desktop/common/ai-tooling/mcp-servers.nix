{ pkgs, inputs, config, secrets, ... }:
inputs.mcp-servers-nix.lib.mkConfig pkgs {
  programs = {
    brave-search = {
      enable = true;
      passwordCommand = {
        BRAVE_API_KEY = ["cat" "${secrets.brave_search_api_key.path}"];
      };
    };
    fetch.enable = true;
    memory = {
      enable = true;
      env = {
        MEMORY_FILE_PATH = "${config.home.homeDirectory}/.mcp/memory.json";
      };
    };
    sequential-thinking.enable = true;
    time.enable = true;
  };

  settings.servers = {
    desktop-commander = {
      command = "${pkgs.lib.getExe' pkgs.nodejs "npx"}";
      args = [
        "-y"
        "@wonderwhy-er/desktop-commander"
      ];
    };
    vikunja = {
      command = "${pkgs.lib.getExe' pkgs.nodejs "npx"}";
      args = [
        "-y"
        "vikunja-mcp"
      ];
      env = {
        VIKUNJA_API_BASE = "https://todo.uttho.me";
        VIKUNJA_API_TOKEN = ["cat" "${secrets.vikunja_api_token.path}"];
      };
    };
    linear = {
      command = "${pkgs.lib.getExe' pkgs.nodejs "npx"}";
      args = [
        "-y"
        "mcp-server-linear"
      ];
      env = {
        LINEAR_ACCESS_TOKEN = ["cat" "${secrets.linear_access_token.path}"];
      };
    };
  };
}
