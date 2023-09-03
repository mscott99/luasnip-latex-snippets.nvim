local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
-- local is_math = require("luasnip-latex-snippets.util.utils").is_math

local math_wrA = {
  autosnippet(
    { trig = "//", name = "fraction", dscr = "fraction (general)" },
    fmta(
      [[
    \frac{<>}{<>}<>
    ]],
      { i(1), i(2), i(0) }
    ),
    {}
    -- { condition = is_math, show_condition = is_math }
  ),
  autosnippet(
    {
      trig = "(%b())/",
      name = "fraction",
      dscr = "auto fraction 2",
      regTrig = true,
      hidden = true,
    },
    fmta(
      [[
    \frac{<>}{<>}<>
    ]],
      {
        f(function(_, snip)
          return string.sub(snip.captures[1], 2, -2)
        end),
        i(1),
        i(0),
      }
    ),
    {
      -- condition = is_math, show_condition = is_math
    }
  ),
  autosnippet(
    { trig = "(%S+)/", name = "fraction", dscr = "auto fraction 1", regTrig = true, hidden = true },
    fmta(
      [[
    \frac{<>}{<>}<>
    ]],
      { f(function(_, snip)
        return snip.captures[1]
      end), i(1), i(0) }
    ),
    {
      -- condition = is_math, show_condition = is_math
    }
  ),
  s({
    trig = "[%a]",
    name = "test this",
  }, {
    f(function(_, snip)
      return string.format("\\frac{%s}{", snip.captures[1])
    end, {}),
    i(1),
    t("}"),
    i(0),
  }),
}

return math_wrA
