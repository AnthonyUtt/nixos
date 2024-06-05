{ pkgs, lib }:
{
  plugin = pkgs.vimPlugins.pywal-nvim;
  type = "lua";
  config = ''
    if vim.fn.has('termguicolors') == 1 then
      vim.opt.termguicolors = true
    end

    vim.opt.background = 'dark'

    vim.cmd [[
      colorscheme pywal
    ]]
  '';
}
