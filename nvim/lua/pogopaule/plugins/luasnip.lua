require("luasnip.loaders.from_vscode").lazy_load()

local ls = require"luasnip"
local types = require("luasnip.util.types")

ls.config.setup({
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = {{"🔶"}}
      }
    },
  },
})

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

local function get_existing_fields(position, field)
  return d(position, function()
    local nodes = {}
    local already_seen = {}

    local current_buffer = vim.api.nvim_buf_get_lines(0,0,-1,false)
    for _, line in ipairs(current_buffer) do
    local match = line:match('%s*'.. field ..': (.*)$')
      if match then
        if(not already_seen[match]) then
          table.insert(nodes, t(match))
          already_seen[match] = true
        end
      end
    end
    return sn(nil, c(1, nodes))
  end, {})
end

ls.add_snippets("all", {
  s("entry",
    fmt([[
  - name: {}
    website: {}
    jobs: {}
    description: {}
    remote: {}
    speculative: {}
    field: {}
    geo:
      - country: {}
        lat: {}
        long: {}
    review: {}
    rating: {}
    ]], {
        i(1), i(2), i(3), i(4),
        c(5, {t "true", t "false"}),
        c(6, {t "true", t "false"}),
        get_existing_fields(7, 'field'),
        get_existing_fields(8, 'country'),
        i(9), i(10), i(11), i(11)
      })
  ),
  postfix(".foo", {
    f(function(_, parent)
      return "[" .. parent.snippet.env.POSTFIX_MATCH .. "]"
    end, {}),
  })
})
