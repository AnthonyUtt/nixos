{ pkgs, lib }:
let
  pluginFromGit = repo: ref: rev: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
      rev = rev;
    };
  };
in
{
  plugin = (pluginFromGit "zakissimo/smoji.nvim" "master" "97cee4129cadb2ee6c6e6c5c436e3a51e5dea7c5");
  type = "lua";
  config = ''
    require("smoji")

    local wk = require("which-key")
    wk.add({
      { "<leader><leader>e", "<cmd>Smoji<cr>", desc = "Toggle Smoji.nvim suggestions" },
    })
  '';
}
