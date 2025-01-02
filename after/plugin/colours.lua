function ColorMyPencils(color)
	color = color or 'tokyonight-storm'
	vim.cmd.colorscheme(color)

  vim.cmd('hi linenr guifg=#a9b1d6 guibg=#3d59a1')
  vim.cmd('hi linenrabove guifg=#08629c')
  vim.cmd('hi linenrbelow guifg=#08629c')
end

ColorMyPencils()
