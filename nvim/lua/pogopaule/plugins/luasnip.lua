local ls = require 'luasnip'
local types = require('luasnip.util.types')

ls.cleanup() -- used for re-sourcing this file, otherwise you get snippet duplicates

require('luasnip.loaders.from_vscode').lazy_load()

ls.config.setup({
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '🔶' } }
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
local events = require('luasnip.util.events')
local ai = require('luasnip.nodes.absolute_indexer')
local fmt = require('luasnip.extras.fmt').fmt
local m = require('luasnip.extras').m
local lambda = require('luasnip.extras').l
local postfix = require('luasnip.extras.postfix').postfix

local function get_existing_fields(position, field)
  return d(position, function()
    local nodes = {}
    local already_seen = {}

    local current_buffer = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(current_buffer) do
      local match = line:match('%s*' .. field .. ': (.*)$')
      if match then
        if (not already_seen[match]) then
          table.insert(nodes, t(match))
          already_seen[match] = true
        end
      end
    end
    return sn(nil, c(1, nodes))
  end, {})
end

ls.add_snippets('all', {
  s({ trig = 'epoch', dscr = 'current time as unix timestamp' }, f(
    function()
      return tostring(os.time())
    end)),

  postfix({ trig = '.var', match_pattern = '[^%s%c]+$' }, {
    d(1, function(_, parent)
      local keyword = '' -- python
      local ft = vim.bo.filetype
      if ft == 'javascript' then
        keyword = 'let '
      elseif ft == 'lua' then
        keyword = 'local '
      end
      return sn(nil, { t(keyword), i(1), t(' = ' .. parent.env.POSTFIX_MATCH) })
    end)
  }),

  postfix({ trig = '.log', match_pattern = '[^%s%c]+$'}, {
    f(function(_, parent)
      local func = 'print' -- lua, python
      if vim.bo.filetype == 'javascript' then
        func = 'console.log'
      end
      return func .. '(' .. parent.snippet.env.POSTFIX_MATCH .. ')'
    end, {}),
  }),
})

ls.add_snippets('yaml', {
  s('entry',
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
      c(5, { t 'true', t 'false' }),
      c(6, { t 'true', t 'false' }),
      get_existing_fields(7, 'field'),
      get_existing_fields(8, 'country'),
      i(9), i(10), i(11), i(12)
    })
  ),
})

ls.add_snippets('javascript', {
  postfix({ trig = '.fn', match_pattern = '[%w(){}]+$' }, {
    d(1, function(_, parent)
      return sn(nil, { i(1), t('(' .. parent.env.POSTFIX_MATCH .. ')'), i(0) })
    end)
  }),
})

ls.add_snippets('nix', {
  s('attrset', fmt([[
    {1} = {{
      {2} = {3};
    }};
  ]], {i(1), i(2), i(3)})
  ),
  s('devflake', fmt([[
    {{
      inputs = {{
        nixpkgs.url = "github:nixos/nixpkgs";
        flake-utils.url = "github:numtide/flake-utils";
      }};

      outputs = {{ self, nixpkgs, flake-utils }}:
        flake-utils.lib.eachDefaultSystem (system:
          let
            pkgs = nixpkgs.legacyPackages.${{system}};
          in
          {{
            devShell = pkgs.mkShell {{
              buildInputs = with pkgs; [
                {1}
              ];
            }};
          }});
    }}
  ]], {i(1)})
  )
})
