local M = {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v<CurrentMajor>.*",
	-- install jsregexp (optional!:).
	build = "make install_jsregexp"
}

return M
