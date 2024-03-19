-- Intall lazylazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Fixes Notify opacity issues
vim.o.termguicolors = true

require('lazy').setup {
  {
    'jackMort/ChatGPT.nvim',
    config = function()
      require('chatgpt').setup {
        api_key_cmd = 'op read op://Personal/OpenAI-nvim-key/apikey --no-newline',
      }
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'folke/trouble.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
  -- {
  -- 'Exafunction/codeium.vim',
  -- config = function()
  --   -- Change '<C-g>' here to any keycode you like.
  --   vim.keymap.set('i', '<C-e>', function()
  --     return vim.fn['codeium#Accept']()
  --   end, { expr = true, silent = true })
  --   vim.keymap.set('i', '<C-n>', function()
  --     return vim.fn['codeium#CycleCompletions'](1)
  --   end, { expr = true, silent = true })
  --   vim.keymap.set('i', '<C-p>', function()
  --     return vim.fn['codeium#CycleCompletions'](-1)
  --   end, { expr = true, silent = true })
  --   vim.keymap.set('i', '<C-x>', function()
  --     return vim.fn['codeium#Clear']()
  --   end, { expr = true, silent = true })
  -- end,
  -- },
  'onsails/lspkind.nvim',
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  'preservim/vim-pencil',
  {
    'sourcegraph/sg.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',

    keys = {
      { '<leader>on', '<cmd>ObsidianNew<cr>', desc = 'New Obsidian note', mode = 'n' },
      { '<leader>oo', '<cmd>ObsidianSearch<cr>', desc = 'Search Obsidian notes', mode = 'n' },
      { '<leader>os', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Quick Switch', mode = 'n' },
      { '<leader>ob', '<cmd>ObsidianBacklinks<cr>', desc = 'Show location list of backlinks', mode = 'n' },
      { '<leader>ot', '<cmd>ObsidianTemplate<cr>', desc = 'Follow link under cursor', mode = 'n' },
    },
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  'folke/zen-mode.nvim',
  'David-Kunz/gen.nvim',
  'tpope/vim-dadbod',
  'tpope/vim-obsession',
  'kristijanhusak/vim-dadbod-ui',
  'kristijanhusak/vim-dadbod-completion',
  {
    'xiyaowong/transparent.nvim',
    config = function()
      require('transparent').setup {
        extra_groups = { -- table/string: additional groups that should be cleared
          -- In particular, when you set it to 'all', that means all available groups
          -- example of akinsho/nvim-bufferline.lua
          'NvimTreeNormal',
        },
        exclude_groups = {}, -- table: groups you don't want to clear
      }
    end,
  },
  -- Tree
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    requires = {
      'nvim-tree/nvim-web-devicons',
    },

    config = function()
      require('nvim-tree').setup()
      print 'nvim-tree config loaded'

      vim.keymap.set('n', '<leader>v', function()
        return require('nvim-tree.api').tree.toggle()
      end, { noremap = true })
    end,
  },
  -- Database
  {
    'tpope/vim-dadbod',
    opt = true,
    requires = {
      'kristijanhusak/vim-dadbod-ui',
      'kristijanhusak/vim-dadbod-completion',
    },
    config = function()
      require('config.dadbod').setup()
    end,
  },

  'ThePrimeagen/git-worktree.nvim',
  'tpope/vim-surround',
  'xiyaowong/nvim-transparent',
  {
    'numToStr/FTerm.nvim',
    config = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      require('FTerm').setup {
        blend = 5,
        dimensions = {
          height = 0.90,
          width = 0.90,
          x = 0.5,
          y = 0.5,
        },
      }
    end,
  },

  {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {
        width = 120, -- Width of the floating window
        height = 15, -- Height of the floating window
        border = { '↖', '─', '┐', '│', '┘', '─', '└', '│' }, -- Border characters of the floating window
        default_mappings = true,
        debug = false, -- Print debug information
        opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
        resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        references = { -- Configure the telescope UI for slowing the references cycling window.
          telescope = require('telescope.themes').get_dropdown { hide_preview = false },
        },
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = true, -- Focus the floating window when opening it.
        dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
        force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = 'wipe', -- the bufhidden option to set on the floating window. See :h bufhidden
        stack_floating_preview_windows = true, -- Whether to nest floating windows
        preview_window_title = { enable = true, position = 'left' }, -- Whether
      }
    end,
  },

  {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('trouble').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },

  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    lazy = false,
    config = function()
      require('todo-comments').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },

  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup {
        background_colour = '#000000',
        enabled = false,
      }
    end,
  },

  {
    'folke/noice.nvim',
    config = function()
      require('noice').setup {
        -- add any options here
        routes = {
          {
            filter = {
              event = 'msg_show',
              any = {
                { find = '%d+L, %d+B' },
                { find = '; after #%d+' },
                { find = '; before #%d+' },
                { find = '%d fewer lines' },
                { find = '%d more lines' },
              },
            },
            opts = { skip = true },
          },
        },
      }
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },

  'ray-x/go.nvim',
  'ray-x/guihua.lua',
  { 'catppuccin/nvim', as = 'catppuccin' },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',
    },
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },

  { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap' } },
  'theHamsta/nvim-dap-virtual-text',
  'leoluz/nvim-dap-go',
  'mfussenegger/nvim-dap-python',

  -- Git related plugins
  'tpope/vim-fugitive',
  'lewis6991/gitsigns.nvim',

  'navarasu/onedark.nvim', -- Theme inspired by Atom
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
  'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'jmbuhr/telescope-zotero.nvim',
        dependencies = {
          { 'kkharji/sqlite.lua' },
        },
        -- default opts shown
        opts = {
          zotero_db_path = '~/Zotero/zotero.sqlite',
          better_bibtex_db_path = '~/Zotero/better-bibtex.sqlite',
        },
      },
    },
  },
  'nvim-telescope/telescope-symbols.nvim',
  -- 'ThePrimeagen/harpoon',

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },
  {
    'folke/twilight.nvim',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        python = { 'isort', 'black' },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      }
      require('which-key').register {
        L = {
          name = 'ChatGPT',
          c = { '<cmd>ChatGPT<CR>', 'ChatGPT' },
          e = { '<cmd>ChatGPTEditWithInstruction<CR>', 'Edit with instruction', mode = { 'n', 'v' } },
          g = { '<cmd>ChatGPTRun grammar_correction<CR>', 'Grammar Correction', mode = { 'n', 'v' } },
          t = { '<cmd>ChatGPTRun translate<CR>', 'Translate', mode = { 'n', 'v' } },
          k = { '<cmd>ChatGPTRun keywords<CR>', 'Keywords', mode = { 'n', 'v' } },
          d = { '<cmd>ChatGPTRun docstring<CR>', 'Docstring', mode = { 'n', 'v' } },
          a = { '<cmd>ChatGPTRun add_tests<CR>', 'Add Tests', mode = { 'n', 'v' } },
          o = { '<cmd>ChatGPTRun optimize_code<CR>', 'Optimize Code', mode = { 'n', 'v' } },
          s = { '<cmd>ChatGPTRun summarize<CR>', 'Summarize', mode = { 'n', 'v' } },
          f = { '<cmd>ChatGPTRun fix_bugs<CR>', 'Fix Bugs', mode = { 'n', 'v' } },
          x = { '<cmd>ChatGPTRun explain_code<CR>', 'Explain Code', mode = { 'n', 'v' } },
          r = { '<cmd>ChatGPTRun roxygen_edit<CR>', 'Roxygen Edit', mode = { 'n', 'v' } },
          l = { '<cmd>ChatGPTRun code_readability_analysis<CR>', 'Code Readability Analysis', mode = { 'n', 'v' } },
        },
        { prefix = '<leader>' },
      }
    end,
  },
}
