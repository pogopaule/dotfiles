return {
  {
    url = 'https://github.com/L3MON4D3/LuaSnip',
    dependencies = {
      { url = 'https://github.com/rafamadriz/friendly-snippets' },
    },
    config = function()
      local map = vim.keymap.set
      -- TODO: use pure lua. need to figure out how to express the 'else <Tab>' case
      vim.api.nvim_exec([[
          " press <Tab> to expand or jump in a snippet. These can also be mapped separately
          " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
          imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
        ]], true)

      local ls = require('luasnip')

      map('n', '<F5>',
        '<CMD>source ~/dotfiles/nvim/lua/config/plugins/luasnip.lua<CR><CMD>lua require("notify")("Snippets reloaded")<CR>')

      map('s', '<s-tab>', function()
        if ls.jumpable(1) then
          ls.jump(1)
        end
      end, { silent = true })

      -- this always moves to the previous item within the snippet
      map({ 'i', 's' }, '<s-tab>', function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })

      -- selecting within a list of options
      map({ 'i', 's' }, '<c-e>', function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, opts)

      map('i', '<c-u>', require 'luasnip.extras.select_choice')


      local ls = require('luasnip')
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
        s({ trig = 'timestamp', dscr = 'current time as unix timestamp' }, f(
          function()
            return tostring(os.time())
          end)),
        s({ trig = 'uuid', dscr = 'random pseudo uuid' }, f(
          function()
            -- taken from https://gist.github.com/jrus/3197011
            local random = math.random
            local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
            return string.gsub(template, '[xy]', function(c)
              local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
              return string.format('%x', v)
            end)
          end)),
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
    ]]     , {
            i(1), i(2), i(3), i(4),
            c(5, { t 'true', t 'false' }),
            c(6, { t 'true', t 'false' }),
            get_existing_fields(7, 'field'),
            get_existing_fields(8, 'country'),
            i(9), i(10), i(11), i(12)
          })
        ),
      })

      ls.add_snippets('typescript', {
        s('describe',
          fmt([[
      describe('{}', () => {{
        {}('{}', {}() => {{
          {}
        }});
      }});
    ]]     , {
            i(1), c(2, { t 'it', t 'test' }), i(3), c(4, { t 'async ', t '' }), i(0)
          })
        ),
        s('test',
          fmt([[
      {}('{}', {}() => {{
        {}
      }});
    ]]     , {
            c(1, { t 'it', t 'test' }), i(2), c(3, { t 'async ', t '' }), i(0)
          })
        ),
      })

      ls.add_snippets('javascript', {
        postfix({ trig = '.fn', match_pattern = '[%w(){}]+$' }, {
          d(1, function(_, parent)
            return sn(nil, { i(1), t('(' .. parent.env.POSTFIX_MATCH .. ')'), i(0) })
          end)
        }),

        postfix({ trig = '.var', match_pattern = '[^%s%c]+$' }, {
          d(1, function(_, parent)
            return sn(nil, { t('let '), i(1), t(' = ' .. parent.env.POSTFIX_MATCH) })
          end)
        }),

        postfix({ trig = '.log', match_pattern = '[^%s%c]+$' }, {
          f(function(_, parent)
            return 'console.log(' .. parent.snippet.env.POSTFIX_MATCH .. ')'
          end, {}),
        }),
      })

      ls.add_snippets('python', {
        postfix({ trig = '.var', match_pattern = '[^%s%c]+$' }, {
          d(1, function(_, parent)
            return sn(nil, { i(1), t(' = ' .. parent.env.POSTFIX_MATCH) })
          end)
        }),

        postfix({ trig = '.log', match_pattern = '[^%s%c]+$' }, {
          f(function(_, parent)
            return 'print(' .. parent.snippet.env.POSTFIX_MATCH .. ')'
          end, {}),
        }),
      })

      ls.add_snippets('lua', {
        postfix({ trig = '.var', match_pattern = '[^%s%c]+$' }, {
          d(1, function(_, parent)
            return sn(nil, { t('local '), i(1), t(' = ' .. parent.env.POSTFIX_MATCH) })
          end)
        }),

        postfix({ trig = '.log', match_pattern = '[^%s%c]+$' }, {
          f(function(_, parent)
            return 'print(' .. parent.snippet.env.POSTFIX_MATCH .. ')'
          end, {}),
        }),
      })

      ls.add_snippets('nix', {
        s('attrset', fmt([[
    {1} = {{
      {2} = {3};
    }};
  ]]     , { i(1), i(2), i(3) })
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
  ]]     , { i(1) })
        )
      })
    end,
  },
}
