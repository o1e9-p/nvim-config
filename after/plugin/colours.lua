function ColorMyPencils(color)
	color = color or 'tokyonight-storm'
	vim.cmd.colorscheme(color)

  vim.cmd('hi linenr guifg=#0D7FC8')
end

ColorMyPencils()
