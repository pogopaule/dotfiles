require("luasnip.loaders.from_vscode").lazy_load()

local ls = require"luasnip"
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
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l
local postfix = require("luasnip.extras.postfix").postfix

ls.add_snippets("all", {
  s("ternary", {
    -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
    i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else"),
  }),
  postfix(".foo", {
    f(function(_, parent)
      return "[" .. parent.snippet.env.POSTFIX_MATCH .. "]"
    end, {}),
  })
})
