" Disable netrw as it interferes with NvimTree
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Set terminal colors
set termguicolors 

" Initialize vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" Basic plugins
Plug 'junegunn/fzf.vim'              " Fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'morhetz/gruvbox'                " Color scheme
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' } " Syntax highlighting
Plug 'neovim/nvim-lspconfig'          " Language Server Protocol configurations
Plug 'hrsh7th/nvim-cmp'               " Autocompletion framework
Plug 'hrsh7th/cmp-nvim-lsp'           " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'             " Buffer completions
Plug 'hrsh7th/cmp-path'               " Path completions
Plug 'hrsh7th/cmp-cmdline'            " Command line completions
Plug 'L3MON4D3/LuaSnip'               " Snippet engine
Plug 'saadparwaiz1/cmp_luasnip'       " Snippet completions
Plug 'lewis6991/gitsigns.nvim'        " Git signs in the gutter
Plug 'nvim-lua/plenary.nvim'          " Common utilities for Neovim
Plug 'windwp/nvim-autopairs'          " Auto-pair brackets
Plug 'nvim-lualine/lualine.nvim'      " Status line
Plug 'nvim-tree/nvim-web-devicons'    " Optional: file icons
Plug 'nvim-tree/nvim-tree.lua'        " NvimTree file manager
Plug 'github/copilot.vim'
Plug 'nvim-treesitter/playground'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }


" Initialize plugin system
call plug#end()

" General settings
set number                        " Show line numbers
"set relativenumber                  Show relative line numbers
set nowrap                        " Don't wrap lines
set tabstop=4                     " Number of spaces that a <Tab> counts for
set shiftwidth=4                  " Number of spaces to use for each step of (auto)indent
set expandtab                     " Use spaces instead of tabs
set clipboard=unnamedplus         " Use system clipboard
set noswapfile
set nobackup
set encoding=UTF-8
set cursorline
set softtabstop=4
set showmatch
set ignorecase
set cc=80 
set smartindent
set splitright


syntax on                         " Enable syntax highlighting
colorscheme catppuccin              " Set color scheme


" Disable the default Tab key mapping for accepting suggestions
let g:copilot_no_tab_map = v:true

" Map F2 to accept suggestions

imap <silent><script><expr> <F2> copilot#Accept("\<CR>")





" Key mappings
" Keymaps for LSP
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
nnoremap <silent> gD :lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>f :lua vim.lsp.buf.format({ async = true })<CR>
nnoremap <silent> <leader>e :lua vim.diagnostic.open_float()<CR>
nnoremap <silent> [d :lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d :lua vim.diagnostic.goto_next()<CR>



nnoremap <C-p> :FZF<CR>
" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

nnoremap <leader>gc :G<CR>
nnoremap <leader>gcl :Gclog<CR>
" Move 1 more lines up or down in normal and visual selection modes.
nnoremap K :m .-2<CR>==
nnoremap J :m .+1<CR>==
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
nnoremap <F1> :Telescope lsp_document_symbols<CR>

" Map F5 to save the current file
nnoremap <F5> :w<CR>

" Map F6 to start writing :vsplit
nnoremap <F6> :vsplit 

" Map F7 to start writing :e src/
nnoremap <F7> :e src/

" Map F8 to start writing :e test/
nnoremap <F8> :e test/

" Map F9 to open file manager
nnoremap <F9> :NvimTreeToggle<CR>

nnoremap <F12> :set relativenumber!<CR>

" NvimTree configuration
lua << EOF
require('nvim-tree').setup {
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
    side = "left"
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}
EOF

" Autocompletion settings
lua << EOF
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },
})
EOF

autocmd VimEnter * NvimTreeOpen




" LSP settings
lua << EOF
require('lspconfig').pyright.setup{} -- Example for Python (install the pyright server)
EOF

lua << EOF
local lspconfig = require('lspconfig')
lspconfig.ts_ls.setup{}
EOF


" Enable Git signs
lua << EOF
require('gitsigns').setup()
EOF

" Enable autopairs
lua << EOF
require('nvim-autopairs').setup{}
EOF

" Status line
lua << EOF
require('lualine').setup{
  options = { theme = 'gruvbox' }
}
EOF

lua << EOF
require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
      on_attach = "default",
      hijack_cursor = false,
      auto_reload_on_write = true,
      disable_netrw = false,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      root_dirs = {},
      prefer_startup_root = false,
      sync_root_with_cwd = false,
      reload_on_bufenter = false,
      respect_buf_cwd = false,
      select_prompts = false,
      sort = {
        sorter = "name",
        folders_first = true,
        files_first = false,
      },
      view = {
        centralize_selection = false,
        cursorline = true,
        debounce_delay = 15,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        width = 30,
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        full_name = false,
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        hidden_display = "none",
        symlink_destination = true,
        highlight_git = "none",
        highlight_diagnostics = "none",
        highlight_opened_files = "none",
        highlight_modified = "none",
        highlight_hidden = "none",
        highlight_bookmarks = "none",
        highlight_clipboard = "name",
        indent_markers = {
          enable = false,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          web_devicons = {
            file = {
              enable = true,
              color = true,
            },
            folder = {
              enable = false,
              color = true,
            },
          },
          git_placement = "before",
          modified_placement = "after",
          hidden_placement = "after",
          diagnostics_placement = "signcolumn",
          bookmarks_placement = "signcolumn",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
            hidden = false,
            diagnostics = true,
            bookmarks = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "󰆤",
            modified = "●",
            hidden = "󰜌",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      update_focused_file = {
        enable = false,
        update_root = {
          enable = false,
          ignore_list = {},
        },
        exclude = false,
      },
      system_open = {
        cmd = "",
        args = {},
      },
      git = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        disable_for_dirs = {},
        timeout = 400,
        cygwin_support = false,
      },
      diagnostics = {
        enable = false,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      modified = {
        enable = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      filters = {
        enable = true,
        git_ignored = true,
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        no_bookmark = false,
        custom = {},
        exclude = {},
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {
          "/.ccls-cache",
          "/build",
          "/node_modules",
          "/target",
        },
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "shadow",
            style = "minimal",
          },
        },
        open_file = {
          quit_on_open = false,
          eject = true,
          resize_window = true,
          window_picker = {
            enable = true,
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      trash = {
        cmd = "gio trash",
      },
      tab = {
        sync = {
          open = false,
          close = false,
          ignore = {},
        },
      },
      notify = {
        threshold = vim.log.levels.INFO,
        absolute_path = true,
      },
      help = {
        sort_by = "key",
      },
      ui = {
        confirm = {
          remove = true,
          trash = true,
          default_yes = false,
        },
      },
      experimental = {
        actions = {
          open_file = {
            relative_path = false,
          },
        },
      },
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
    } -- END_DEFAULT_OPTS
EOF






" Treesitter configurations
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- List of parsers to install
  ensure_installed = { "c", "lua", "python", "javascript", "html", "css", "bash", "go" }, -- Add languages you use
  highlight = {
    enable = true,                 -- false will disable the whole extension
  },
}
EOF

lua require('templates')

lua << EOF
local templates = require('templates')

-- Function to insert text at the current cursor position
_G.insert_text = function(text)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))  -- Get current cursor position
    local current_line = vim.api.nvim_get_current_line()       -- Get the current line content
    local indent = current_line:match("^(%s*)")                -- Get leading whitespace

    -- Split the text into lines
    local lines = vim.split(text, "\n")

    -- Handle the first line separately to insert at the cursor's current position
  lines[1] = current_line:sub(1, col) .. " " .. lines[1] .. current_line:sub(col + 1)

    -- Prepend the original indentation to each subsequent line
    for i = 2, #lines do
        lines[i] = indent .. lines[i]
    end

    -- Set the text in the buffer at the current cursor position
    vim.api.nvim_buf_set_lines(0, row - 1, row, false, lines)
end

-- Map keys to insert templates
vim.api.nvim_set_keymap('n', '<leader>pt', ':lua insert_text(require("templates").python_try_except())<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pi', ':lua insert_text(require("templates").python_if_statement())<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pr', ':lua insert_text(require("templates").python_request_statement())<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pf', ':lua insert_text(require("templates").python_for_statement())<CR>', { noremap = true, silent = true })
EOF




lua << EOF
vim.diagnostic.config({
    virtual_text = false,
})
EOF


lua << EOF
-- Toggle virtual text for diagnostics using F11
vim.api.nvim_set_keymap('n', '<F10>', ':lua ToggleDiagnostics()<CR>', { noremap = true, silent = true })

_G.ToggleDiagnostics = function()
  local current_value = vim.diagnostic.config().virtual_text
  if current_value then
    vim.diagnostic.config({ virtual_text = false })
    print("Diagnostics virtual text disabled")
  else
    vim.diagnostic.config({ virtual_text = true })
    print("Diagnostics virtual text enabled")
  end
end
EOF



" Initialize the variable to track Copilot status
let g:copilot_enabled = 1  " Start with Copilot enabled

" Define a function to toggle Copilot
function! ToggleCopilot()
    if g:copilot_enabled
        let g:copilot_enabled = 0
        Copilot disable
        echo "Copilot Disabled"
    else
        let g:copilot_enabled = 1
        Copilot enable
        echo "Copilot Enabled"
    endif
endfunction

" Map Leader + cop to toggle Copilot
nnoremap <Leader>cop :call ToggleCopilot()<CR>


lua << EOF
require'lspconfig'.gopls.setup{}
EOF