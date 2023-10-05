local plugins = {
    -- Colorscheme
    { 'Everblush/nvim',  name = 'everblush' },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    { "shaunsingh/nord.nvim",     name = "nord" },
    { "maxmx03/dracula.nvim",     name = "dracula" },
    { "neanias/everforest-nvim",  name = "everforest" },
    { "ellisonleao/gruvbox.nvim", name = "gruvbox" },
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("plugins.config.neotree")
        end
    },

    -- Lualine
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("plugins.config.lualine")
        end
    },
    -- Whichkey
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("plugins.config.whichkey")
        end,
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 0
        end,
    },
    -- Toggle term
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = true
    },
    -- Dashboard
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("plugins.config.alpha")
        end
    },
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
        dependencies = { "nvim-treesitter/nvim-treesitter-context", "HiPhish/rainbow-delimiters.nvim" },
        config = function()
            require("plugins.config.treesitter")
        end
    },
    -- LuaSnip
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
    },
    -- Nvim Telesccope
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        lazy = true,
        tag = '0.1.3',
        dependencies = { "nvim-telescope/telescope-media-files.nvim" },
        config = function()
            require("plugins.config.telescope")
        end
    },
    -- Colorizer
    {
        "NvChad/nvim-colorizer.lua",
        event = 'BufRead',
        config = function()
            require("plugins.config.colorizer")
        end
    },

    -- Gitsigns
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = { "BufRead" },
        config = function()
            require("plugins.config.gitsigns")
        end
    },
    -- nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                version = "2.*",
                build = "make install_jsregexp"
            },
            {
                "onsails/lspkind.nvim",
                event = "InsertEnter",
                lazy = true,
            },
        },
        config = function()
            require("plugins.cmp.cmp")
        end
    },
    -- LSP Config
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        lazy = true,
        cmd = { "LspInfo", "LspInstall", "LspUninstall", "LspStart" },
        dependencies = {
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require("plugins.lsp.null-ls")
                end
            },
            {
                "nvimdev/lspsaga.nvim",
                config = function()
                    require("plugins.lsp.lspsaga")
                end
            },
            {
                "williamboman/mason.nvim",
                cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
                config = function()
                    require("plugins.lsp.mason")
                end
            }
        },
        config = function()
            require("plugins.lsp.lspconfig")
        end
    },
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
    },

    defaults = { lazy = true },
    ui = {
        icons = {
            ft = "",
            lazy = "󰂠 ",
            loaded = "",
            not_loaded = "",
        },
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "2html_plugin",
                "tohtml",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "matchit",
                "tar",
                "tarPlugin",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
                "tutor",
                "rplugin",
                "syntax",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin",
            },
        },
    },
}

require("lazy").setup(plugins)
