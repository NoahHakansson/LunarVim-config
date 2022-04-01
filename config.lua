--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- Settings
vim.opt.clipboard = ""
vim.opt.showmode = false
vim.opt.scrolloff = 15
vim.opt.wrap = true

-- Transparency
lvim.transparent_window = false

-- lualine set to show current vim mode
local mode = {
    "mode",
    padding = { left = 1, right = 1 },
    color = {gui="bold"},
    cond = nil,
  }
lvim.builtin.lualine.sections.lualine_a = {mode}


-- general
lvim.log.level = "warn"
lvim.format_on_save = false
-- lvim.colorscheme = "gruvbox-material"
lvim.colorscheme = "onedarker"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_palette = "mix"


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
-- switch between last two buffers
lvim.keys.normal_mode["<space><space>"] = "<C-^>"
-- Yank to system clipboard
lvim.keys.visual_mode["<space>y"] = '"+y'
-- shift+q to quit
lvim.keys.normal_mode["<S-q>"] = ":q<CR>"
lvim.keys.normal_mode["<Tab>"] = ":bnext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = ":bprev<CR>"
-- vim.cmd('vnoremap <leader>y "+y')
-- vim.cmd("nnoremap <leader><leader> <c-^>")
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-s>"] = false
-- 'jk' for quitting insert mode
lvim.keys.insert_mode["jk"] = false
-- 'kj' for quitting insert mode
lvim.keys.insert_mode["kj"] = false
-- 'jj' for quitting insert mode
lvim.keys.insert_mode["jj"] = false
-- edit a default keymapping

-- Fix alt to function like altGr for important keys.
-- Normal + (visual+select) + operator pending mode
vim.cmd("map <M-0> }")
vim.cmd("map <M-7> {")
vim.cmd("map <M-9> ]")
vim.cmd("map <M-8> [")
-- Insert + command-line mode
vim.cmd("map! <M-0> }")
vim.cmd("map! <M-7> {")
vim.cmd("map! <M-9> ]")
vim.cmd("map! <M-8> [")


-- Harpoon bindings
lvim.keys.normal_mode["<C-f>"] = "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>"
lvim.keys.normal_mode["<C-m>"] = "<cmd>lua require('harpoon.mark').add_file()<cr>"
lvim.keys.normal_mode["<S-l>"] = "<cmd>lua require('harpoon.ui').nav_next()<cr>"
lvim.keys.normal_mode["<S-h>"] = "<cmd>lua require('harpoon.ui').nav_prev()<cr>"
lvim.builtin.which_key.mappings["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Harpoon(1)" }
lvim.builtin.which_key.mappings["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "Harpoon(2)" }
lvim.builtin.which_key.mappings["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "Harpoon(3)" }
lvim.builtin.which_key.mappings["4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "Harpoon(4)" }
lvim.builtin.which_key.mappings["5"] = { "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", "Harpoon(5)" }


-- rebind ToggleTerminal Terminal
lvim.builtin.terminal.open_mapping = [[<c-x>]]

lvim.builtin.which_key.mappings["g"] = {
  name = "Git",
  j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
  k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
  l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
  p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
  r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
  R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
  f = { "<cmd>G<cr>", "Fugitive" },
  u = {
    "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
    "Undo Stage Hunk",
  },
  o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
  b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
  c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
  C = {
    "<cmd>Telescope git_bcommits<cr>",
    "Checkout commit(for current file)",
  },
  -- Diffview plugin binds
  d = {"<cmd>DiffviewOpen<cr>", "Git Diff (diffview)",},
  h = {"<cmd>DiffviewFileHistory<cr>", "File history (diffview)",},
}

-- auto hybrid line numbers
vim.cmd([[
:set number

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END
]])

-- Bind vim fugitive to which_key <leader>gs
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.file_ignore_patterns = {".cach"}
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["h"] = { ":ClangdSwitchSourceHeader<CR>", "Switch Source/Header" }
lvim.builtin.which_key.mappings["7"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" }
lvim.builtin.which_key.vmappings["7"] = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" }

-- Search and replace
lvim.builtin.which_key.mappings["r"] = {
  ":%s/pattern/replace/gc", "Search and replace"
}

-- gitsigns
lvim.builtin.gitsigns.opts.signs.add.text = "+"
lvim.builtin.gitsigns.opts.signs.change.text = "~"
lvim.builtin.gitsigns.opts.signs.delete.text = "-"
lvim.builtin.gitsigns.opts.signs.topdelete.text = "-"
lvim.builtin.gitsigns.opts.signs.changedelete.text = "~"


--
-- Nice old vim binds
--
-- Turn off highlight when pressing Esc
vim.cmd("nmap <silent> <Esc> :noh <CR>")
-- Remaps for swedish keyboard layout.
vim.cmd("noremap § $")
-- Quality of life rebinds
vim.cmd("nnoremap n nzzzv")
vim.cmd("nnoremap N Nzzzv")
vim.cmd("inoremap , ,<c-g>u")
vim.cmd("inoremap . .<c-g>u")
vim.cmd("inoremap ! !<c-g>u")
vim.cmd("inoremap ? ?<c-g>u")

-- Yank to system clipboard
-- vim.cmd('vnoremap <leader>y "+y')

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
-- Configure builtin plugins
lvim.builtin.alpha.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "cpp",
  "markdown",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Rainbow
-- lvim.builtin.treesitter.rainbow = {
--   enable = false,
--   extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
--   max_file_lines = 2000, -- Do not enable for files with more than 1000 lines, int
-- }

-- Additional plugin binds
vim.api.nvim_set_keymap("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "S", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
vim.api.nvim_set_keymap("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })

-- Trouble.nvim plugin
lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}


-- Additional Plugins
lvim.plugins = {
  {"folke/tokyonight.nvim"},
  {"tpope/vim-surround"},
  {"sainnhe/gruvbox-material"},
  -- smart identation
  {"tpope/vim-sleuth"},
  -- {"Darazaki/indent-o-matic"},
  -- Git-related plugins
  {"tpope/vim-fugitive"},
  {"ThePrimeagen/harpoon"},
  {"tpope/vim-rhubarb"},
  {"tpope/vim-obsession"},
  {"tommcdo/vim-fugitive-blame-ext"},
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  -- end Git-related plugins
  -- {"p00f/nvim-ts-rainbow"},
  {
  "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  -- The GOAT lsp_signature
  {
    "ray-x/lsp_signature.nvim",
    config = function() require"lsp_signature".on_attach() end,
    event = "BufRead"
  },
  {"ellisonleao/glow.nvim"},
  {
    "danymat/neogen",
    config = function()
        require('neogen').setup()
    end,
    requires = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
  },
  {
    "nvim-telescope/telescope-project.nvim",
    event = "BufWinEnter",
    setup = function()
      vim.cmd [[packadd telescope.nvim]]
    end,
  },
  {
    "gbprod/substitute.nvim",
    config = function()
      require("substitute").setup()
    end
  },
  {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufRead",
  setup = function()
    vim.g.indentLine_enabled = 1
    vim.g.indent_blankline_char = "▏"
    vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
    vim.g.indent_blankline_buftype_exclude = {"terminal"}
    vim.g.indent_blankline_show_trailing_blankline_indent = false
    vim.g.indent_blankline_show_first_indent_level = false
  end
  },
  -- half buggy colorizer
  {
    "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup({ "*" }, {
            RGB = true, -- #RGB hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            RRGGBBAA = true, -- #RRGGBBAA hex codes
            rgb_fn = true, -- CSS rgb() and rgba() functions
            hsl_fn = true, -- CSS hsl() and hsla() functions
            css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            -- Available modes: foreground, background
            mode = 'background'; -- Set the display mode.
            })
    end,
  },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
