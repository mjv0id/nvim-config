-- lazyvim installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- configure nvim theme
require("lazy").setup({
    {
        "oskarnurm/koda.nvim",
        config = function()
          require("koda").setup({
            colors = {
              bg = "#090909",
              line = "#1a1a1a",
            },

            on_highlights = function(hl)
              hl["@variable"] = {
                fg = "#b0b0b0",
              }
            end,

          })
            vim.cmd("colorscheme koda-dark")
        end,
    },

-- alpha config
    {
        "goolord/alpha-nvim",
        event = "VimEnter",

        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            dashboard.section.header.val = {
                [[                                                                     ]],
                [[       ███████████           █████      ██                     ]],
                [[      ███████████             █████                             ]],
                [[      ████████████████ ███████████ ███   ███████     ]],
                [[     ████████████████ ████████████ █████ ██████████████   ]],
                [[    █████████████████████████████ █████ █████ ████ █████   ]],
                [[  ██████████████████████████████████ █████ █████ ████ █████  ]],
                [[ ██████  ███ █████████████████ ████ █████ █████ ████ ██████ ]],
                [[ ██████   ██  ███████████████   ██ █████████████████ ]],
                [[ ██████   ██  ███████████████   ██ █████████████████ ]],
            }

            dashboard.section.buttons.val = {
                dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
                dashboard.button("f", " > Find file", "<cmd>Telescope find_files<CR>"),
                dashboard.button("CTRL N", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
                dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
                dashboard.button("SPC fw", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
                dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
                dashboard.button("CTRL N", "-- Toggle file explorer --", "<cmd>NvimTreeToggle<CR>") -- toggle file dashboard
            }

            alpha.setup(dashboard.opts)

            vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
        end,
    },

-- telescope
  {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
},

-- nvim tree
  { 
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },

-- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate'
  },

  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },

  {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {},
  },

  -- autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

})

-- treesitter config
require("nvim-treesitter").install({
  "lua",
  "python",
  "c",
  "html",
  "css",
  "javascript",
  "markdown",
  "yaml",
  "json",
  "bash",
  "vim",
  "vimdoc",
})

vim.api.nvim_create_autocmd("FileType", { 
  pattern = {
    "c",
    "python",
    "markdown",
    "yaml",
    "html",
    "css",
    "javascript",
    "json",
    "sh",
  },
  callback = function()
    vim.treesitter.start()
  end,
})

vim.cmd("colorscheme koda-dark")

-- nvim configs
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>")
vim.lsp.enable("pyright")
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>gg", "<cmd>term lazygit<CR>")
vim.keymap.set("n", "<C-h>", "<C-w>h") -- window change in split view
vim.keymap.set("n", "<C-j>", "<C-w>j") -- window change in split view
vim.keymap.set("n", "<C-k>", "<C-w>k") -- window change in split view
vim.keymap.set("n", "<C-l>", "<C-w>l") -- window change in split view

