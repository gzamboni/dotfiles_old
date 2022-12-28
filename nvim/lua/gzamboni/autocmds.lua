
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		vim.cmd([[
			let save = winsaveview()
			keeppatterns %s/\s\+$//e
			call winrestview(save)
		]])
	end,
	group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true }),
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "packer.lua",
  callback = function()
    require("packer").sync()
  end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
	group = vim.api.nvim_create_augroup("Highlight", { clear = true }),
})
