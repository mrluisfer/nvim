-- lazy.nvim bootstrap (use vim.uv in new versions)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	-- stylua: ignore
	vim.fn.system({
		"git", "clone", "--filter=blob:none", "--branch=stable",
		"https://github.com/folke/lazy.nvim.git", lazypath
	})
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
	spec = {
		-- LazyVim + plugins defaults
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
	},
	defaults = {
		-- version = false -- (recommended) always use the latest git commit
	},
	install = { colorscheme = { "tokyonight", "habamax" } },
	checker = { enabled = true }, -- check for updates in their background
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

local api = vim.api
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Disable 'paste' when leaving Insert mode (modern callback)
api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		vim.opt.paste = false
	end,
})

-- Fix conceal and spell per buffer (use *local*)
api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc" },
	callback = function()
		vim.opt_local.spell = false
		vim.opt_local.conceallevel = 0
	end,
})

-- Keymaps
keymap("n", "+", "<C-a>", { desc = "Incrementar número" })
keymap("n", "-", "<C-x>", { desc = "Decrementar número" })

-- Select all
keymap("n", "<C-a>", "ggVG", { desc = "Seleccionar todo" })

-- Tabs navigation
keymap("n", "<Tab>", "<cmd>tabnext<CR>", vim.tbl_extend("force", opts, { desc = "Tab siguiente" }))
keymap("n", "<S-Tab>", "<cmd>tabprev<CR>", vim.tbl_extend("force", opts, { desc = "Tab anterior" }))

-- Splits (fixed: 'sv' now is vsplit)
keymap("n", "ss", "<cmd>split<CR>", vim.tbl_extend("force", opts, { desc = "Split horizontal" }))
keymap("n", "sv", "<cmd>vsplit<CR>", vim.tbl_extend("force", opts, { desc = "Split vertical" }))

-- Move between windows (h j k l)
keymap("n", "sh", "<C-w>h", { desc = "Ir a ventana izquierda" })
keymap("n", "sj", "<C-w>j", { desc = "Ir a ventana abajo" })
keymap("n", "sk", "<C-w>k", { desc = "Ir a ventana arriba" })
keymap("n", "sl", "<C-w>l", { desc = "Ir a ventana derecha" })

-- Diagnostics
keymap("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, vim.tbl_extend("force", opts, { desc = "Siguiente diagnóstico" }))

-- Neo-tree (VS Code style)
keymap("n", "<C-b>", "<cmd>Neotree toggle<CR>", vim.tbl_extend("force", opts, { desc = "Toggle Neo-tree" }))
