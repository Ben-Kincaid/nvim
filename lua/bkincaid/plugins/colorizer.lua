local M = { 'norcalli/nvim-colorizer.lua' }

function M.config()
	require 'colorizer'.setup({
		'svelte', -- Highlight all files, but customize some others.
		'javascript',
		'css',
		'scss',
		'sass',
		'typescript',
		'javascriptreact',
		'typesriptreact',
		css = { rgb_fn = true, }, -- Enable parsing rgb(...) functions in css.
		html = { names = false, }, -- Disable parsing "names" like Blue or Gray or Red or Purple or Yellow  or rgb(0, 200, 0) or #e23562 or red,
	}, { mode = 'foreground', css = { css = true, rgb_fn = true, names = true } })
end

return M
