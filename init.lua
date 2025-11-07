-- Configuración básica de Neovim (estilo VSCode)
vim.g.mapleader = " " -- Líder como espacio
vim.g.maplocalleader = "\\"

-- Configuraciones básicas
vim.opt.number = true             -- Números de línea
vim.opt.relativenumber = true     -- Números relativos
vim.opt.mouse = "a"               -- Mouse habilitado
vim.opt.clipboard = "unnamedplus" -- Clipboard del sistema
vim.opt.ignorecase = true         -- Ignorar mayúsculas en búsqueda
vim.opt.smartcase = true          -- Inteligente para mayúsculas
vim.opt.expandtab = true          -- Usar espacios en lugar de tabs
vim.opt.shiftwidth = 2            -- 2 espacios para indentación
vim.opt.tabstop = 2               -- 2 espacios por tab
vim.opt.wrap = false              -- No envolver líneas
vim.opt.cursorline = true         -- Resaltar línea actual
vim.opt.termguicolors = true      -- Colores 24-bit

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git", "--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugins esenciales (mínimos)
require("lazy").setup({
	-- Explorador de archivos (como VSCode)
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = false,
				popup_border_style = "rounded",
				enable_git_status = true,
			})
		end,
	},

	-- Autocompletado básico
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				},
			})
		end,
	},

	-- LSP básico
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls" }, -- Solo lo básico
			})

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.ts_ls.setup({})
		end,
	},

	-- Buscador de archivos (como Ctrl+P en VSCode)
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({})
		end,
	},

	-- Resaltado de sintaxis
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "javascript", "typescript", "html", "css" },
				highlight = { enable = true },
			})
		end,
	},

	-- Tema simple
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	-- Línea de estado simple
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup()
		end,
	},
})

-- Keymaps estilo VSCode
local keymap = vim.keymap.set

-- Explorador de archivos (Ctrl+B como en VSCode)
keymap("n", "<C-b>", "<cmd>Neotree toggle<CR>", { desc = "Toggle explorer" })

-- Buscador de archivos (Ctrl+P como en VSCode)
keymap("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

-- Búsqueda en archivos (Ctrl+Shift+F como en VSCode)
keymap("n", "<C-S-f>", "<cmd>Telescope live_grep<CR>", { desc = "Search in files" })

-- Comando palette (Ctrl+Shift+P como en VSCode)
keymap("n", "<C-S-p>", "<cmd>Telescope commands<CR>", { desc = "Command palette" })

-- Seleccionar todo (Ctrl+A)
keymap("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Guardar (Ctrl+S)
keymap("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- Nuevo archivo (Ctrl+N)
keymap("n", "<C-n>", "<cmd>enew<CR>", { desc = "New file" })

-- Cerrar archivo (Ctrl+W)
keymap("n", "<C-w>", "<cmd>bd<CR>", { desc = "Close file" })

-- Navegación entre pestañas (Ctrl+Tab / Ctrl+Shift+Tab)
keymap("n", "<C-Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "<C-S-Tab>", "<cmd>bprev<CR>", { desc = "Previous buffer" })

-- Comentarios (Ctrl+/ como en VSCode)
keymap("n", "<C-/>", "gcc", { desc = "Toggle comment", remap = true })
keymap("v", "<C-/>", "gc", { desc = "Toggle comment", remap = true })

-- Duplicar línea (Shift+Alt+Down)
keymap("n", "<S-A-Down>", ":t.<CR>", { desc = "Duplicate line down" })

-- Mover línea arriba/abajo (Alt+Up/Down)
keymap("n", "<A-Up>", ":m .-2<CR>", { desc = "Move line up" })
keymap("n", "<A-Down>", ":m .+1<CR>", { desc = "Move line down" })

-- LSP keymaps (como VSCode)
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		keymap("n", "gd", vim.lsp.buf.definition, opts)
		keymap("n", "K", vim.lsp.buf.hover, opts)
		keymap("n", "<F2>", vim.lsp.buf.rename, opts)
		keymap("n", "<C-.>", vim.lsp.buf.code_action, opts)
	end,
})
