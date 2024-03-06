function ColorMyPencils(color)
	color = color or 'tokyonight-storm'
	vim.cmd.colorscheme(color)

  vim.cmd('hi linenr guifg=#0D7FC8')
	-- vim.api.nvim_set_hl(100, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
