{ pkgs, lib }: {
  plugin = pkgs.vimPlugins.comment-nvim;
  type = "lua";
  config = ''
    require('Comment').setup()

    local wk = require("which-key")
    wk.add({
      {
        "<leader>/",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        desc = "Toggle comment"
      },
      {
        mode = "v",
        { "<leader>/", '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', desc = "Toggle comment" }
      },
    })
  '';
}
