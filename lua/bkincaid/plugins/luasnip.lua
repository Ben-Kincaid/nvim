local M = {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v<CurrentMajor>.*",
	-- install jsregexp (optional!:).
	build = "make install_jsregexp"
}

function CreateSvelteComponentSnippet()
	local ls = require("luasnip")
	local text = ls.text_node;
	local insert = ls.insert_node;

	-- The snippet table to be returned
	local snippet = {}


	table.insert(snippet, text({ '<script lang="ts">', '</script>' }))

	table.insert(snippet, text({ '', '' }))
	table.insert(snippet, insert(0))
	table.insert(snippet, text({ '', '' }))

	table.insert(snippet, text({ '<style lang="scss">', '</style>' }))

	return snippet;
end

-- Create snippet object for a React component skeleton
function CreateReactComponentSnippet(opts)
	local ls = require("luasnip")

	local text = ls.text_node;
	local insert = ls.insert_node;
	local func = ls.function_node;
	local filename = function()
		return func(function(_, snip)
			local name = snip.env.TM_FILENAME
			return name:match("(.+)%..+$"):gsub("^%l", string.upper)
		end, {})
	end

	-- Default user supplied opts to empty table
	opts = opts or {}

	-- default options for the snippet; will create an "rfce" if no opts provided.
	local defaultOpts = {
		ts = false,
		export = true
	}

	-- Merge provided options with default
	local merged_opts = defaultOpts;
	for k, v in pairs(opts) do merged_opts[k] = v end

	-- The snippet table to be returned
	local snippet = {}

	-- For ts, output Props type
	if merged_opts.ts == true then
		table.insert(snippet, text("export type "))
		table.insert(snippet, filename())
		table.insert(snippet, text({ "Props = {}", "", "" }))
	end

	if merged_opts.export == true then
		table.insert(snippet, text("export default "))
	end

	table.insert(snippet, text("function "))
	table.insert(snippet, filename())
	table.insert(snippet, text('({}'))
	-- For ts, define type in parameter
	if merged_opts.ts == true then
		table.insert(snippet, text(': '))
		table.insert(snippet, filename())
		table.insert(snippet, text('Props'))
	end
	table.insert(snippet, text(') '))

	table.insert(snippet, text({ '{', '' }))
	table.insert(snippet, text('	')) --Indent for newline
	table.insert(snippet, insert(1))
	table.insert(snippet, text({ '', '}' }))

	return snippet;
end

function M.config()
	local ls = require("luasnip")

	-- JS/JSX Snippets
	ls.add_snippets("javascript", {
		ls.snippet({
			trig = "rfce",
			namr = "react_js_component_w_props_export",
			dscr = "Create a React component (Javascript) with an interface for props. Component is exported."
		}, CreateReactComponentSnippet({ ts = false, export = true })),
		ls.snippet({
			trig = "rfc",
			namr = "react_js_component_w_props",
			dscr = "Create a React component (Javascript) with an interface for props."
		}, CreateReactComponentSnippet({ ts = false, export = false })),
	})
	ls.filetype_extend("javascriptreact", { "javascript" })

	-- TS/TSX Snippets
	ls.add_snippets("typescript", {
		ls.snippet({
			trig = "trfce",
			namr = "react_ts_component_w_props_export",
			dscr = "Create a React component (Typescript) with an interface for props. Component & types are exported."
		}, CreateReactComponentSnippet({ ts = true, export = true })),
		ls.snippet({
			trig = "trfc",
			namr = "react_ts_component_w_props",
			dscr = "Create a React component (Typescript) with an interface for props."
		}, CreateReactComponentSnippet({ ts = true, export = false })),
	})
	ls.filetype_extend("typescriptreact", { "typescript" })


	-- Svelte snippets
	ls.add_snippets("svelte", {
		ls.snippet({
			trig = "svtc",
			namr = "svelte_ts_component",
			dscr = "Create a Svelte component (Typescript)."
		}, CreateSvelteComponentSnippet())
	})

	-- MD Snippets
	ls.add_snippets("markdown",
		{
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
	);
end

return M
