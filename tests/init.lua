--
-- Install Lazy.nvim
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--
-- Install Shell.nvim
--
require("lazy").setup({
  {
    "siadat/animated-resize.nvim",
    opts = {},
    dev = true,
  },
}, { dev = { path = '/work/src/nvim-plugins' } })
