local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

local snippets, autosnippets = {}, {}

local snip = s("snip", {
	t("hi, this a node for a snippets"),
	i(1, " placeholdertext"),
	t("this is another text node"),
})

local snip2 = s(
	"snip2",
	fmt(
		[[

local {} = function({})
{}
end
]],
		{
			i(1, "myVar"),
			c(2, { t(""), t("myArg") }),
			i(3, "-- TODO: "),
		}
	)
)

local autoSnip = s({ trig = "autosnipt", regTrig = true }, { t("auto expnd") })

local functionSnip = s("fsnip", {
	f(function(arg, snipp)
		return arg[1][1]
	end, 1),
	i(1, "bomdia"),
})

--
-- table.insert(snippets, snip)
table.insert(snippets, snip2)
table.insert(snippets, functionSnip)
-- table.insert(autosnippets, autoSnip)

return snippets, autosnippets
