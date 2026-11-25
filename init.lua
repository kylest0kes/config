-- ============================================================================
-- Options
-- ============================================================================

-- Enables filetype detection, plugin loading, and indent rules.
-- (Replaces the old `filetype plugin indent on`.)
vim.cmd('filetype plugin indent on')

-- Note: `syntax on` is not needed in Neovim — treesitter/highlighting is
-- enabled by default. Uncomment the line below if you want the old behavior.
-- vim.cmd('syntax on')

-- Use spaces instead of tabs, 4-wide.
local opt = vim.opt

opt.autoindent = true      -- copy indent from current line when starting new one
opt.smartindent = true     -- smart autoindenting on new lines
opt.number = true          -- show line numbers
opt.tabstop = 4            -- a tab counts for 4 spaces
opt.shiftwidth = 4         -- indentation width for >> and <<
opt.expandtab = true       -- insert spaces instead of tab characters

opt.wrap = true            -- wrap long lines
opt.linebreak = true       -- wrap at word boundaries, not mid-word

opt.errorbells = false     -- no error bells

-- ============================================================================
-- Cursor shape (block in normal mode, bar in insert mode)
-- ============================================================================

vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20"

-- ============================================================================
-- Disable clicking in files
-- ============================================================================
vim.keymap.set('n', '<LeftMouse>', '<Nop>')

-- ============================================================================
-- Colors
-- ============================================================================

-- termguicolors if running in kitty
if vim.env.TERM and vim.env.TERM:match('kitty') then
    opt.termguicolors = true
end

-- Visual selection highlight.
vim.api.nvim_set_hl(0, 'Visual', { bg = '#ff69b4', fg = '#000000' })

-- ============================================================================
-- Autocommands
-- ============================================================================

-- Autoformat Python files on save (requires vim-autoformat plugin).
-- vim.api.nvim_create_autocmd('BufWritePre', {
--     pattern = '*.py',
--     command = 'Autoformat',
-- })

-- ============================================================================
-- Keymaps
-- ============================================================================

local map = vim.keymap.set
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- ============================================================================
-- Bootstrap lazy.nvim
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." }
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ============================================================================
-- Initialize lazy.nvim
-- ============================================================================

require("lazy").setup({
    spec = {
        -- Autopairs: auto-close brackets and quotes
        { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },

        -- Telescope: fuzzy finder (with Ctrl+P keymap)
        {
            "nvim-telescope/telescope.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function()
                local builtin = require('telescope.builtin')
                vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
            end,
        },

        -- Cyberdream colorscheme
        {
            "scottmckendry/cyberdream.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                require("cyberdream").setup({
                    transparent = false,
                })
                vim.cmd("colorscheme cyberdream")
            end,
        },
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true },
})
