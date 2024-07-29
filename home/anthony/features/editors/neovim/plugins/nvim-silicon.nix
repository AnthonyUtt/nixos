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
  plugin = (pluginFromGit "michaelrommel/nvim-silicon" "main" "ab664633e5090809da7470288404fe5b8735a8c8");
  type = "lua";
  config = ''
    require("silicon").setup({
      font = "ComicShannsMono Nerd Font=34",
      to_clipboard = true,
    })

    local wk = require("which-key")
    wk.add({
      { "<leader>ss", ":Silicon <CR>", desc = "Screenshot selection (silicon)", mode = "x" }
    })
  '';
}
