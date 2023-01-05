-- TODO: checkout plugins
-- https://github.com/Pocco81/DAPInstall.nvim
-- https://github.com/jose-elias-alvarez/typescript.nvim additional lsp features for typescript, mainly imports related
-- https://github.com/ms-jpq/coq_nvim alternative to vim-cmp?
-- https://github.com/ms-jpq/chadtree alternative to nvim-tree?
-- https://github.com/danymat/neogen generate annotations and documentation
-- https://github.com/ThePrimeagen/harpoon naviage favorite locations
-- https://github.com/kevinhwang91/nvim-ufo nicer folds
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
    -- TODO: lazy
    {
      'https://github.com/debugloop/telescope-undo.nvim',
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

    -- cheat.sh integration
    -- TODO: lazy
    { 'https://github.com/dbeniamine/cheat.sh-vim' },

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

    -- Code reviews in vim
    -- TODO: lazy
    {
      'https://github.com/ldelossa/gh.nvim',
      dependencies = { 'https://github.com/ldelossa/litee.nvim' }
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

    -- Popup API from vim in neovim
    -- TODO: lazy
    { 'https://github.com/nvim-lua/popup.nvim' },

    -- Lua functions
    -- TODO: lazy
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
    -- TODO: lazy
    {
      'https://github.com/kyazdani42/nvim-tree.lua',
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
        require('alpha').setup(require('alpha.themes.startify').config)
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
    -- TODO: lazy
    {
      'https://github.com/rcarriga/nvim-notify',
      config = function() vim.notify = require("notify") end,
    },



    -- Moving Around ################################

    -- Jump in text
    {
      'https://github.com/ggandor/leap.nvim',
      event = 'VeryLazy',
      config = function()
        require('leap').add_default_mappings()
      end,
    },

    -- Find, Filter, Preview, Pick
    -- TODO: lazy
    { 'https://github.com/nvim-telescope/telescope.nvim' },

    -- use telescope to select options
    -- TODO: lazy
    {
      'https://github.com/nvim-telescope/telescope-ui-select.nvim',
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
    -- TODO: lazy
    {
      'https://github.com/airblade/vim-rooter',
    },

    -- shows what to type after a prefix
    -- TODO: lazy
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
    -- TODO: better lazy
    {
      'https://github.com/tyru/open-browser.vim',
      -- keys = { 'gx', { 'gx', mode ='v' } },
      lazy = false,
      config = function()
        vim.cmd([[
      " disable netrw's gx mapping.
      let g:netrw_nogx = 1
      let g:openbrowser_default_search = 'duckduckgo'
      ]] )
      end
    },



    -- Coding #########################################

    -- Nvim Treesitter configurations and abstraction layer
    -- TODO: lazy
    {
      'https://github.com/nvim-treesitter/nvim-treesitter',
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

    -- Text objects like functions and variables
    -- TODO: lazy
    { 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },

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
    -- TODO: lazy
    {
      'https://github.com/ThePrimeagen/refactoring.nvim',
      config = true,
    },

    -- Preview markdown, requires live-preview and pandoc to be installed
    {
      'https://github.com/davidgranstrom/nvim-markdown-preview',
      ft = 'markdown',
    },

    -- JSON schema awareness, gives LSP completions for e.g. package.json
    {
      'https://github.com/b0o/schemastore.nvim',
    },

    -- TODO: lazy
    { 'https://github.com/nvim-neotest/neotest-python' },

    -- print() debugging
    -- TODO: lazy
    {
      'https://github.com/andrewferrier/debugprint.nvim',
      config = true,
    },

    -- split or join blocks powered by treesitter
    -- TODO: lazy
    {
      'https://github.com/Wansmer/treesj',
      config = { use_default_keymaps = false },
    },

    -- easily surround with brackets
    {
      'https://github.com/kylechi/nvim-surround',
      keys = { 'ys', 'cs', 'ds' },
      config = true,
    },

    -- Insert matching quote, brackets, etc.
    -- TODO: lazy
    {
      'https://github.com/windwp/nvim-autopairs',
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
    -- TODO: lazy
    { 'https://github.com/neovim/nvim-lspconfig' },

    -- The neovim language-server-client UI
    -- TODO: lazy
    { 'https://github.com/glepnir/lspsaga.nvim' },

    -- vscode-like pictograms for neovim lsp completion items
    -- TODO: lazy
    { 'https://github.com/onsails/lspkind-nvim' },

    -- LSP bridge for linters and others
    -- TODO: lazy
    { 'https://github.com/jose-elias-alvarez/null-ls.nvim' },

    -- LSP signature hint as you type
    -- TODO: lazy
    { 'https://github.com/ray-x/lsp_signature.nvim' },

    -- Show LSP progress
    -- TODO: lazy
    {
      'https://github.com/j-hui/fidget.nvim',
      config = true,
    },

    -- Nicer diagnostics
    -- TODO: lazy
    {
      'https://github.com/folke/trouble.nvim',
      config = true,
    },

    -- LSP and DAP for java
    -- TODO: lazy
    { 'https://github.com/mfussenegger/nvim-jdtls' },



    -- Debugging ######################################

    -- TODO: lazy
    { 'https://github.com/mfussenegger/nvim-dap' },
    -- TODO: lazy
    { 'https://github.com/rcarriga/nvim-dap-ui' },
    -- TODO: lazy
    {
      'https://github.com/nvim-telescope/telescope-dap.nvim',
      config = function()
        require('telescope').load_extension('dap')
      end
    },
    { 'https://github.com/theHamsta/nvim-dap-virtual-text' },
    -- TODO: lazy
    { 'https://github.com/mxsdev/nvim-dap-vscode-js' },
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

    -- Git
    -- TODO: lazy
    { 'https://github.com/tpope/vim-fugitive' },

    -- Adds Github to futitive, e.g. Gbrowse
    -- TODO: lazy
    { 'https://github.com/tpope/vim-rhubarb' },

    -- create github permalink via <leader>gy
    -- TODO: lazy
    {
      'https://github.com/ruifm/gitlinker.nvim',
      config = true,
    },



    -- Completion ########################################

    -- TODO: lazy
    { 'https://github.com/hrsh7th/nvim-cmp' },
    -- TODO: lazy
    { 'https://github.com/hrsh7th/cmp-nvim-lsp' },
    -- TODO: lazy
    { 'https://github.com/hrsh7th/cmp-buffer' },
    -- TODO: lazy
    { 'https://github.com/hrsh7th/cmp-path' },
    -- TODO: lazy
    { 'https://github.com/hrsh7th/cmp-cmdline' },
    -- TODO: lazy
    -- { 'https://github.com/andersevenrud/cmp-tmux' },



    -- Snippets ##########################################

    -- TODO: lazy
    { 'https://github.com/L3MON4D3/LuaSnip' },
    -- TODO: lazy
    { 'https://github.com/saadparwaiz1/cmp_luasnip' },
    -- TODO: lazy
    { 'https://github.com/rafamadriz/friendly-snippets' },


  }, lazy_config)
