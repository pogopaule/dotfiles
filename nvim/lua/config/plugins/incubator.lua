return {
  -- snake_case to camelCase and more
  {
    'https://github.com/johmsalas/text-case.nvim',
    event = 'BufReadPost',
    config = function()
      require('textcase').setup({})
    end
    -- config = true,
    -- keys = {
    --   { '<leader>cu', '<CMD>lua require("textcase").current_word("to_upper_case")<CR>', desc = 'TO UPPER CASE' },
    --   { '<leader>cl', '<CMD>lua require("textcase").current_word("to_lower_case")<CR>', desc = 'to lower case' },
    --   { '<leader>cs', '<CMD>lua require("textcase").current_word("to_snake_case")<CR>', desc = 'to_snake_case' },
    --   { '<leader>cd', '<CMD>lua require("textcase").current_word("to_dash_case")<CR>', desc = 'to-dash-case' },
    --   { '<leader>cn', '<CMD>lua require("textcase").current_word("to_constant_case")<CR>', desc = 'TO_CONSTANT_CASE' },
    --   { '<leader>cd', '<CMD>lua require("textcase").current_word("to_dot_case")<CR>', desc = 'to.dot.case' },
    --   { '<leader>ca', '<CMD>lua require("textcase").current_word("to_phrase_case")<CR>', desc = 'To phrase case' },
    --   { '<leader>cc', '<CMD>lua require("textcase").current_word("to_camel_case")<CR>', desc = 'toCamelCase' },
    --   { '<leader>cp', '<CMD>lua require("textcase").current_word("to_pascal_case")<CR>', desc = 'ToPascalCase' },
    --   { '<leader>ct', '<CMD>lua require("textcase").current_word("to_title_case")<CR>', desc = 'To Title Case' },
    --   { '<leader>cf', '<CMD>lua require("textcase").current_word("to_path_case")<CR>', desc = 'to/path/case' },
    -- }
  },

  -- project wide search/replace
  {
    'https://github.com/nvim-pack/nvim-spectre',
    config = function()
      require('spectre').setup()
    end,
  },

  -- ChatGPT
  {
    'https://github.com/jackMort/ChatGPT.nvim',
    config = {
      welcome_message = '',
    },
    keys = {
      { '<leader>c', '<CMD>ChatGPT<CR>', desc = 'ChatGPT' },
    },
    dependencies = { 'https://github.com/MunifTanjim/nui.nvim' }
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
    lazy = false,
    dependencies = 'https://github.com/kevinhwang91/promise-async',
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
}
