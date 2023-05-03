local ok, luasnip = pcall(require, "luasnip")
if not ok then
	return
end

luasnip.config.set_config({
	enable_autosnippets = false,
	store_selection_keys = "<Tab>",
})

require("luasnip.loaders.from_lua").lazy_load({
	paths = vim.fn.stdpath("config") .. "/snippets/",
})
