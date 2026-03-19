local ls = require("luasnip")
local conds = require("luasnip.extras.conditions.expand")

return {
  ls.parser.parse_snippet({
    trig = "---",
    dscr = "em-dash",
    wordTrig = false,
    snippetType = "autosnippet",
    condition = -conds.line_begin,
  }, [[—]]),
}
