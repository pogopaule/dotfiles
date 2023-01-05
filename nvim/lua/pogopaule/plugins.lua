-- TODO: checkout plugins
-- https://github.com/Pocco81/DAPInstall.nvim
-- https://github.com/jose-elias-alvarez/typescript.nvim additional lsp features for typescript, mainly imports related
-- https://github.com/ms-jpq/chadtree alternative to nvim-tree?
-- https://github.com/danymat/neogen generate annotations and documentation
-- https://github.com/ThePrimeagen/harpoon naviage favorite locations
-- https://github.com/mizlan/iswap.nvim swapping powered by treesitter
-- https://github.com/Vonr/align.nvim replace Tabularize?
-- https://github.com/lukas-reineke/headlines.nvim better markdown headline highlights
-- https://github.com/jakewvincent/mkdnflow.nvim
-- https://github.com/andythigpen/nvim-coverage display test coverage


local lazy_config = {
  defaults = {
    lazy = true,
  },
  git = {
    url_format = '%s.git',
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    }
  },
}

-- has to be defined here so keys activation work properly
-- see https://github.com/folke/lazy.nvim#-installation
vim.g.mapleader = ','

-- for https://github.com/tyru/open-browser.vim
vim.cmd([[
  " disable netrw's gx mapping.
  let g:netrw_nogx = 1
  let g:openbrowser_default_search = 'duckduckgo'
]])


require("lazy").setup(
  {
    -- Incubator ###############################

    -- ChatGPT
    {
      'https://github.com/jackMort/ChatGPT.nvim',
      config = {
        welcome_message = '',
      },
      keys = {
        { '<leader>c', '<CMD>ChatGPT<CR>', desc = 'ChatGPT' },
      },
      dependencies = { 'MunifTanjim/nui.nvim' }
    },

    -- undo tree in telescope
    {
      'https://github.com/debugloop/telescope-undo.nvim',
      keys = {
        { '<leader>fu', '<CMD>Telescope undo<CR>', desc = 'Undo' },
      },
      config = function()
        require('telescope').load_extension('undo')
      end,
    },

    -- better folding
    {
      'https://github.com/kevinhwang91/nvim-ufo',
      event = 'VeryLazy',
      dependencies = 'kevinhwang91/promise-async',
      config = function()
        vim.o.foldcolumn = '1' -- '0' is not bad
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

        -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

        -- Option 3: treesitter as a main provider instead
        -- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
        -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
        require('ufo').setup({
          provider_selector = function(bufnr, filetype, buftype)
            return { 'treesitter', 'indent' }
          end
        })
      end
    },

    -- fixes indentation problems with bullet lists
    {
      'https://github.com/dkarter/bullets.vim',
      ft = 'markdown',
    },

    -- treesitter playground, show syntax tree
    {
      'https://github.com/nvim-treesitter/playground',
      cmd = 'TSPlaygroundToggle',
    },

    -- github integration
    {
      'https://github.com/pwntester/octo.nvim',
      cmd = 'Octo',
      config = true,
    },

    -- note taking
    {
      'https://github.com/renerocksai/telekasten.nvim',
      cmd = 'Telekasten',
      config = function()
        local home = vim.fn.expand("~/zettelkasten")

        require('telekasten').setup({
          home = home,

          -- if true, telekasten will be enabled when opening a note within the configured home
          take_over_my_home = true,

          -- auto-set telekasten filetype: if false, the telekasten filetype will not be used
          --                               and thus the telekasten syntax will not be loaded either
          auto_set_filetype = true,

          -- dir names for special notes (absolute path or subdir name)
          dailies   = home .. '/' .. 'daily',
          weeklies  = home .. '/' .. 'weekly',
          templates = home .. '/' .. 'templates',

          -- image (sub)dir for pasting
          -- dir name (absolute path or subdir name)
          -- or nil if pasted images shouldn't go into a special subdir
          image_subdir = "img",

          -- markdown file extension
          extension = ".md",

          -- Generate note filenames. One of:
          -- "title" (default) - Use title if supplied, uuid otherwise
          -- "uuid" - Use uuid
          -- "uuid-title" - Prefix title by uuid
          -- "title-uuid" - Suffix title with uuid
          new_note_filename = "title",
          -- file uuid type ("rand" or input for os.date()")
          uuid_type = "%Y%m%d%H%M",
          -- UUID separator
          uuid_sep = "-",

          -- following a link to a non-existing note will create it
          follow_creates_nonexisting = true,
          dailies_create_nonexisting = true,
          weeklies_create_nonexisting = true,

          -- skip telescope prompt for goto_today and goto_thisweek
          journal_auto_open = false,

          -- template for new notes (new_note, follow_link)
          -- set to `nil` or do not specify if you do not want a template
          template_new_note = home .. '/' .. 'templates/new_note.md',

          -- template for newly created daily notes (goto_today)
          -- set to `nil` or do not specify if you do not want a template
          template_new_daily = home .. '/' .. 'templates/daily.md',

          -- template for newly created weekly notes (goto_thisweek)
          -- set to `nil` or do not specify if you do not want a template
          template_new_weekly = home .. '/' .. 'templates/weekly.md',

          -- image link style
          -- wiki:     ![[image name]]
          -- markdown: ![](image_subdir/xxxxx.png)
          image_link_style = "markdown",

          -- default sort option: 'filename', 'modified'
          sort = "filename",

          -- integrate with calendar-vim
          plug_into_calendar = true,
          calendar_opts = {
            -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
            weeknm = 4,
            -- use monday as first day of week: 1 .. true, 0 .. false
            calendar_monday = 1,
            -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
            calendar_mark = 'left-fit',
          },

          -- telescope actions behavior
          close_after_yanking = false,
          insert_after_inserting = true,

          -- tag notation: '#tag', ':tag:', 'yaml-bare'
          tag_notation = "#tag",

          -- command palette theme: dropdown (window) or ivy (bottom panel)
          command_palette_theme = "ivy",

          -- tag list theme:
          -- get_cursor: small tag list at cursor; ivy and dropdown like above
          show_tags_theme = "ivy",

          -- when linking to a note in subdir/, create a [[subdir/title]] link
          -- instead of a [[title only]] link
          subdirs_in_links = true,

          -- template_handling
          -- What to do when creating a new note via `new_note()` or `follow_link()`
          -- to a non-existing note
          -- - prefer_new_note: use `new_note` template
          -- - smart: if day or week is detected in title, use daily / weekly templates (default)
          -- - always_ask: always ask before creating a note
          template_handling = "smart",

          -- path handling:
          --   this applies to:
          --     - new_note()
          --     - new_templated_note()
          --     - follow_link() to non-existing note
          --
          --   it does NOT apply to:
          --     - goto_today()
          --     - goto_thisweek()
          --
          --   Valid options:
          --     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
          --              all other ones in home, except for notes/with/subdirs/in/title.
          --              (default)
          --
          --     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
          --                    except for notes with subdirs/in/title.
          --
          --     - same_as_current: put all new notes in the dir of the current note if
          --                        present or else in home
          --                        except for notes/with/subdirs/in/title.
          new_note_location = "smart",

          -- should all links be updated when a file is renamed
          rename_update_links = true,

          vaults = {
            vault2 = {
              -- alternate configuration for vault2 here. Missing values are defaulted to
              -- default values from telekasten.
              -- e.g.
              -- home = "/home/user/vaults/personal",
            },
          },

          -- how to preview media files
          -- "telescope-media-files" if you have telescope-media-files.nvim installed
          -- "catimg-previewer" if you have catimg installed
          media_previewer = "telescope-media-files",

          -- A customizable fallback handler for urls.
          follow_url_fallback = nil,
        })
      end,
    },

    -- -- editorconfig integration
    -- { 'https://github.com/editorconfig/editorconfig-vim' },

    -- -- use vscode's container definitions in nvim
    -- { 'https://github.com/jamestthompson3/nvim-remote-containers' },

    -- measure startup time
    {
      'https://github.com/dstein64/vim-startuptime',
      cmd = "StartupTime",
    },

    -- translate text
    {
      'https://github.com/potamides/pantran.nvim',
      cmd = 'Pantran',
      config = {
        default_engine = 'deepl',
        engines = { deepl = { default_target = 'de' } },
      },
    },

    -- enhanced inc/dec
    {
      'https://github.com/monaqa/dial.nvim',
      keys = {
        {
          "+",
          function()
            return require("dial.map").inc_normal()
          end,
          expr = true,
          desc = 'Dial Increment',
        },
        {
          "-",
          function()
            return require("dial.map").dec_normal()
          end,
          expr = true,
          desc = 'Dial Decrement',
        },
      },
      config = function()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group {
          default = {
            augend.integer.alias.decimal,
            augend.integer.alias.hex,
            augend.date.alias["%Y/%m/%d"],
            augend.constant.alias.alpha,
            augend.constant.alias.Alpha,
            augend.constant.alias.bool,
          },
        }
      end
    },



    -- Basics #################################

    -- Lua functions
    { 'https://github.com/nvim-lua/plenary.nvim' },

    -- fix CursorHold performance
    {
      'https://github.com/antoinemadec/FixCursorHold.nvim',
      lazy = false,
    },



    -- Layout and Windows #####################

    -- helpers to close buffers, used by bufferline
    {
      'https://github.com/kazhala/close-buffers.nvim',
      event = 'VeryLazy',
      config = true,
    },

    -- Icon font
    {
      'https://github.com/kyazdani42/nvim-web-devicons',
      event = 'VeryLazy',
      config = true,
    },

    -- File Explorer
    {
      'https://github.com/kyazdani42/nvim-tree.lua',
      keys = {
        { '<leader>N', '<CMD>NvimTreeToggle<CR>', desc = 'Toggle Nvim Tree' },
        { '<leader>n', '<CMD>NvimTreeFindFile<CR>', desc = 'Find File in Nvim Tree' },
      },
      config = {
        filters = {
          dotfiles = true,
        },
        git = {
          ignore = false,
        },
        view = {
          mappings = {
            list = {
              { key = { 'cd' }, action = 'cd' },
            }
          },
          width = 50,
        },
        renderer = {
          special_files = {},
        },
      },
    },

    -- Start screen
    {
      'https://github.com/goolord/alpha-nvim',
      lazy = false,
      config = function()
        local startify = require('alpha.themes.startify')
        startify.section.header.val = {
          [[                                                     ]],
          [[                                                     ]],
          [[                                                     ]],
          [[                                                     ]],
          [[                                                     ]],
          [[                                                     ]],
        }
        require('alpha').setup(startify.config)
      end
    },

    -- Status bar
    {
      'https://github.com/nvim-lualine/lualine.nvim',
      event = 'VeryLazy',
      config = {
        options = {
          disabled_filetypes = {
            statusline = { 'NvimTree' },
          },
        },
      },
    },

    -- nightfox theme
    {
      'https://github.com/EdenEast/nightfox.nvim',
      lazy = false,
      priority = 1000,
      build = ':NightfoxCompile',
      config = function()
        local nightfox = require('nightfox')
        nightfox.setup({
          options = {
            styles = {
              comments = 'italic',
              keywords = 'bold',
            },
          }
        })
        if os.getenv("THEME") == "light" then
          vim.cmd('colorscheme dayfox')
        else
          vim.cmd('colorscheme nordfox')
        end
      end
    },

    -- buffers as tabs
    {
      'https://github.com/akinsho/bufferline.nvim',
      event = 'VeryLazy',
      config = {
        options = {
          offsets = { {
            filetype = 'NvimTree',
            text = 'File Explorer',
            highlight = 'Directory',
            text_align = 'left'
          } }
        }
      },
    },

    -- popup messages
    {
      'https://github.com/rcarriga/nvim-notify',
      config = function() vim.notify = require('notify') end,
    },



    -- Moving Around ################################

    -- Jump in text
    {
      'https://github.com/ggandor/leap.nvim',
      keys = { 's', 'S', 'gs', { 'x', mode = 'v' }, { 'X', mode = 'v' } },
      config = function()
        require('leap').add_default_mappings()
      end,
    },

    -- Find, Filter, Preview, Pick
    { 'https://github.com/nvim-telescope/telescope.nvim' },

    -- use telescope to select options
    {
      'https://github.com/nvim-telescope/telescope-ui-select.nvim',
      event = 'VeryLazy',
      config = function()
        require('telescope').setup {
          extensions = {
            ['ui-select'] = { require('telescope.themes').get_dropdown {} }
          }
        }
        -- To get ui-select loaded and working with telescope, you need to call load_extension, somewhere after setup function:
        require('telescope').load_extension('ui-select')
      end
    },



    -- Misc ########################################

    -- Tabularize
    {
      'https://github.com/godlygeek/tabular',
      cmd = 'Tabularize',
    },

    -- Seamless jumping between vim and tmux
    {
      'https://github.com/christoomey/vim-tmux-navigator',
      lazy = false,
    },

    -- Changes Vim working directory to project root
    {
      'https://github.com/airblade/vim-rooter',
      event = 'VeryLazy',
    },

    -- shows what to type after a prefix
    {
      'https://github.com/folke/which-key.nvim',
      config = true,
    },

    -- Show and remove unwanted whitespaces
    { 'https://github.com/zakharykaplan/nvim-retrail',
      event = 'BufReadPost',
      config = {
        hlgroup = 'Substitute',
        filetype = {
          strict = false,
        },
        trim = {
          blanklines = true,
        }
      },
    },

    -- smooth scrolling
    {
      'https://github.com/karb94/neoscroll.nvim',
      event = 'BufReadPost',
      config = {
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
      },
    },

    -- open url or word as search in browser
    {
      'https://github.com/tyru/open-browser.vim',
      keys = {
        { 'gx', '<plug>(openbrowser-smart-search)', desc = 'Open URL Under Cursor' },
        { 'gx', '<plug>(openbrowser-smart-search)', mode = 'v', desc = 'Open selection in DDG' },
      },
    },


    -- Coding #########################################

    -- Nvim Treesitter configurations and abstraction layer
    {
      'https://github.com/nvim-treesitter/nvim-treesitter',
      dependencies = {
        -- Text objects like functions and variables
        { 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
      },
      build = ':TSUpdate',
      config = function()
        require('nvim-treesitter.configs').setup {
          ensure_installed = {
            'bash', 'clojure', 'cmake', 'css', 'dockerfile', 'fennel', 'go', 'graphql', 'haskell', 'html', 'http',
            'java', 'javascript', 'jsdoc', 'json', 'json5', 'kotlin', 'lua', 'make', 'markdown', 'markdown_inline', 'nix',
            'python', 'regex', 'ruby', 'rust', 'scss', 'svelte', 'todotxt', 'toml', 'tsx', 'typescript', 'vim', 'vue',
            'yaml',
          },
          highlight = {
            enable = true,
          },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<A-s>',
              node_incremental = '<A-d>',
              -- scope_incremental = 'grc',
              node_decremental = '<A-e>',
            },
          },
          indent = {
            enable = true
          },
          matchup = {
            enable = true,
          },
          textobjects = {
            select = {
              enable = true,

              -- Automatically jump forward to textobj, similar to targets.vim
              lookahead = true,

              -- TODO: check if these are useful
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ab'] = '@block.outer',
                ['ib'] = '@block.inner',
                ['ap'] = '@parameter.outer',
                ['ip'] = '@parameter.inner',
                ['ac'] = '@call.outer',
                ['ic'] = '@call.inner',
                ['ai'] = '@item',
              },
            },
          },
        }
      end,
    },

    -- extends %
    {
      'https://github.com/andymass/vim-matchup',
      event = 'BufReadPost',
    },

    -- Comments
    {
      'https://github.com/numToStr/Comment.nvim',
      keys = { 'gc', { 'gc', mode = 'v' } },
      config = true,
    },

    -- Colorize hex colors
    {
      'https://github.com/NvChad/nvim-colorizer.lua',
      event = 'BufReadPre',
      config = true,
    },

    -- Highlight, list and search todo comments
    {
      'https://github.com/folke/todo-comments.nvim',
      event = 'BufReadPost',
      config = true,
    },

    -- Markdown
    {
      'https://github.com/preservim/vim-markdown',
      ft = 'markdown',
    },

    -- Refactoring
    {
      'https://github.com/ThePrimeagen/refactoring.nvim',
    },

    -- Preview markdown, requires live-preview and pandoc to be installed
    {
      'https://github.com/davidgranstrom/nvim-markdown-preview',
      ft = 'markdown',
    },

    -- split or join blocks powered by treesitter
    {
      'https://github.com/Wansmer/treesj',
      cmd = { 'TSJToggle', 'TSJJoin', 'TSJSplit' },
      config = { use_default_keymaps = false },
    },

    -- easily surround with brackets
    {
      'https://github.com/kylechi/nvim-surround',
      keys = { 'ys', 'cs', 'ds' },
      config = true,
    },

    -- Insert matching quote, brackets, etc.
    {
      'https://github.com/windwp/nvim-autopairs',
      event = 'BufReadPre',
      config = function()
        require('nvim-autopairs').setup({ fast_wrap = {} })
        -- https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
        -- If you want insert `(` after select function or method item
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on(
          'confirm_done',
          cmp_autopairs.on_confirm_done()
        )
      end
    },

    -- Send line to tmux
    {
      'https://github.com/jpalardy/vim-slime',
      event = 'VeryLazy',
      config = function()
        vim.cmd([[
          let g:slime_target = "tmux"
          let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
          let g:slime_dont_ask_default = 1
        ]])
      end
    },

    -- indentation guides
    {
      'https://github.com/lukas-reineke/indent-blankline.nvim',
      event = 'BufReadPre',
      config = { show_current_context = true },
    },



    -- LSP ############################################

    -- LSP support
    -- TODO: better lazy
    {
      'https://github.com/neovim/nvim-lspconfig',
      event = 'VeryLazy',
      dependencies = {
        -- LSP signature hint as you type
        { 'https://github.com/ray-x/lsp_signature.nvim' },
        -- JSON schema awareness, gives LSP completions for e.g. package.json
        { 'https://github.com/b0o/schemastore.nvim' },
      },
      config = function()
        local lspconfig = require('lspconfig')

        local function on_attach(client, buffer)
          -- Set autocommands conditional on server_capabilities
          if client.server_capabilities.documentHighlightProvider then
            local group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
            vim.api.nvim_create_autocmd('CursorHold',
              { buffer = buffer, callback = vim.lsp.buf.document_highlight, group = group, })
            vim.api.nvim_create_autocmd('CursorMoved',
              { buffer = buffer, callback = vim.lsp.buf.clear_references, group = group, })
          end

          require('lsp_signature').on_attach({
            hint_enable = false,
            floating_window_above_cur_line = false,
          }, buffer)
        end

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        lspconfig.sumneko_lua.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' },
              },
            },
          },
        })

        lspconfig.jsonls.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        })

        lspconfig.pylsp.setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })

        lspconfig.tsserver.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { -- see https://github.com/typescript-language-server/typescript-language-server/issues/411
            'typescript-language-server',
            '--stdio',
            '--tsserver-path',
            'tsserver'
          },
        })

        lspconfig.yamlls.setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })

        lspconfig.rnix.setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })


        -- nicer symbols
        local sign = function(opts)
          vim.fn.sign_define(opts.name, {
            texthl = opts.name,
            text = opts.text,
            numhl = ''
          })
        end

        sign({ name = 'DiagnosticSignError', text = '✘' })
        sign({ name = 'DiagnosticSignWarn', text = '▲' })
        sign({ name = 'DiagnosticSignHint', text = '⚑' })
        sign({ name = 'DiagnosticSignInfo', text = '' })

        -- disable virtual text for diagnostics
        vim.diagnostic.config({
          virtual_text = false,
        })
      end,
    },

    -- The neovim language-server-client UI
    -- TODO: better lazy
    {
      'https://github.com/glepnir/lspsaga.nvim',
      event = 'VeryLazy',
      config = function()
        require('lspsaga').init_lsp_saga({
          code_action_lightbulb = {
            enable = true,
            sign = false,
            enable_in_insert = true,
            sign_priority = 20,
            virtual_text = true,
          },
        })
      end,
    },

    -- LSP bridge for linters and others
    -- TODO: better lazy
    {
      'https://github.com/jose-elias-alvarez/null-ls.nvim',
      event = 'VeryLazy',
      config = function()
        local null_ls = require('null-ls')

        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
        local formatting = null_ls.builtins.formatting
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
        local diagnostics = null_ls.builtins.diagnostics
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
        local code_actions = null_ls.builtins.code_actions

        local eslintConfig = {
          condition = function(utils)
            return utils.root_has_file({
              '.eslintrc.cjs',
              '.eslintrc.js',
              '.eslintrc.json',
              '.eslintrc.yaml',
              '.eslintrc.yml',
            })
          end
        }

        local prettierConfig = {
          condition = function(utils)
            return utils.root_has_file('.prettierrc')
          end
        }

        null_ls.setup({
          debug = false,
          sources = {
            -- formatting.black.with({ extra_args = { "--fast" } }),
            -- formatting.stylua,
            -- diagnostics.flake8
            formatting.eslint_d.with(eslintConfig),
            diagnostics.eslint_d.with(eslintConfig),
            code_actions.eslint_d.with(eslintConfig),

            formatting.prettier.with(prettierConfig),
          },
        })
      end,
    },


    -- Show LSP progress
    -- TODO: better lazy
    {
      'https://github.com/j-hui/fidget.nvim',
      event = 'VeryLazy',
      config = true,
    },

    -- Nicer diagnostics
    {
      'https://github.com/folke/trouble.nvim',
      cmd = 'Trouble',
      config = true,
    },



    -- Debugging ######################################

    {
      'https://github.com/mfussenegger/nvim-dap',
      cmd = { 'DapContinue', 'DapStepOver', 'DapStepInto', 'DapStepOut', 'DapToggleBreakpoint', },
      dependencies = {
        { 'https://github.com/theHamsta/nvim-dap-virtual-text' },
        { 'https://github.com/rcarriga/nvim-dap-ui' },
      },
      config = function()
        local dap = require('dap')

        for _, language in ipairs({ "typescript", "javascript" }) do
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require 'dap.utils'.pick_process,
              cwd = "${workspaceFolder}",
            }
          }
        end

        dap.adapters.python = {
          type = 'executable';
          command = 'python';
          args = { '-m', 'debugpy.adapter' };
        }

        dap.configurations.python = {
          {
            -- The first three options are required by nvim-dap
            type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
            request = 'launch';
            name = 'Launch current file';

            -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

            program = '${file}'; -- This configuration will launch the current file if used.
            pythonPath = function()
              -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
              -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
              -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
              local cwd = vim.fn.getcwd()
              if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                return cwd .. '/venv/bin/python'
              elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                return cwd .. '/.venv/bin/python'
              else
                return 'python'
              end
            end;
          },
        }


        require('nvim-dap-virtual-text').setup()


        local dapui = require('dapui')
        dapui.setup()

        dap.listeners.after.event_initialized['dapui_config'] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated['dapui_config'] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited['dapui_config'] = function()
          dapui.close()
        end
      end,
    },
    -- DAP for java
    -- TODO: lazy
    { 'https://github.com/mfussenegger/nvim-jdtls' },

    -- DAP for JS
    -- TODO: lazy
    {
      'https://github.com/mxsdev/nvim-dap-vscode-js',
      config = {
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
      }
    },
    -- TODO: lazy
    {
      'https://github.com/microsoft/vscode-js-debug',
      build = 'npm install --legacy-peer-deps && npm run compile',
    },



    -- Git ############################################

    -- git decoration for buffers
    {
      'https://github.com/lewis6991/gitsigns.nvim',
      event = 'BufReadPre',
      config = true,
    },

    -- create github permalink via <leader>gy
    {
      'https://github.com/ruifm/gitlinker.nvim',
      config = true,
    },



    -- Completion ########################################

    {
      'https://github.com/hrsh7th/nvim-cmp',
      event = 'VeryLazy',
      dependencies = {
        { 'https://github.com/hrsh7th/cmp-nvim-lsp' },
        { 'https://github.com/hrsh7th/cmp-buffer' },
        { 'https://github.com/hrsh7th/cmp-path' },
        { 'https://github.com/hrsh7th/cmp-cmdline' },
        { 'https://github.com/saadparwaiz1/cmp_luasnip' },
        -- vscode-like pictograms for neovim lsp completion items
        { 'https://github.com/onsails/lspkind-nvim' },
      },
      config = function()
        local cmp = require('cmp')
        local lspkind = require('lspkind')
        local luasnip = require('luasnip')


        cmp.setup({
          formatting = {
            format = lspkind.cmp_format({
              mode = 'symbol_text',
              maxwidth = 50,
            })
          },
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          }),
          sources = { -- the order below defines the order in the completion popup
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'buffer', option = { keyword_pattern = [[\k\+]] } },
            -- { name = 'tmux' }, disable, causes too much problems
            { name = 'path' },
          },
          window = {
            documentation = cmp.config.window.bordered(),
          }
        })

        -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline('/', {
          sources = {
            { name = 'buffer' }
          },
          mapping = cmp.mapping.preset.cmdline({}),
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          }),
          mapping = cmp.mapping.preset.cmdline({}),
        })
      end,
    },



    -- Snippets ##########################################

    {
      'https://github.com/L3MON4D3/LuaSnip',
      dependencies = {
        { 'https://github.com/rafamadriz/friendly-snippets' },
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
          '<CMD>source ~/dotfiles/nvim/lua/pogopaule/plugins/luasnip.lua<CR><CMD>lua require("notify")("Snippets reloaded")<CR>')

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
    ]]       , {
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
    ]]       , {
              i(1), c(2, { t 'it', t 'test' }), i(3), c(4, { t 'async ', t '' }), i(0)
            })
          ),
          s('test',
            fmt([[
      {}('{}', {}() => {{
        {}
      }});
    ]]       , {
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
  ]]       , { i(1), i(2), i(3) })
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
  ]]       , { i(1) })
          )
        })
      end,
    },
  }, lazy_config)
