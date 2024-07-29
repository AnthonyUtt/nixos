{ pkgs, lib }: {
  plugin = pkgs.vimPlugins.codeium-vim;
  type = "lua";
  config = ''
    local wk = require("which-key")
    wk.add({
      {
        '<C-v>',
        function()
          return vim.fn['codeium#Accept']()
        end,
        desc = "Accept codeium suggestion",
        expr = true,
      }
    })
    vim.g.codeium_no_map_tab = true
  '';
}
