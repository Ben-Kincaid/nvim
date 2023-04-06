local M = {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v<CurrentMajor>.*",
	-- install jsregexp (optional!:).
	build = "make install_jsregexp"
}

function M.config()
	local ls = require("luasnip")

	ls.add_snippets(nil, {
		all = {
			ls.snippet({
				trig = "link",
				namr = "markdown_link",
				dscr = "Create markdown link [txt](url)"
			}, {
				ls.text_node('['),
				ls.insert_node(1),
				ls.text_node(']('),
				ls.function_node(function(_, snip)
					return snip.env.TM_SELECTED_TEXT[1] or {}
				end, {}),
				ls.text_node(')'),
				ls.insert_node(0),
			})
		}
	});
end

return M
