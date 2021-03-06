local utils = require("modules.utils")

local function set_globals()
  vim.g.mapleader = " "
  vim.g.neoformat_basic_format_trim = true
  vim.g.diagnostic_enable_virtual_text = true
end

local function set_options()
  local options = {
    -- path = vim.o.path .. "," .. vim.env.PWD,
    autoread = true,
    hidden = true,
    ignorecase = true,
    inccommand = "split",
    incsearch = true,
    laststatus = 2,
    listchars = [[eol:$,tab:>-,trail:~,extends:>,precedes:<]],
    modeline = true,
    shada = [[!,'500,<50,s10,h]],
    showcmd = true,
    showmode = false,
    smartcase = true,
    splitbelow = true,
    splitright = true,
    startofline = false,
    termguicolors = true,
    textwidth = 88,
    title = true,
    titlestring = "%{join(split(getcwd(), '/')[-2:], '/')}",
    viminfo = [[!,'300,<50,s10,h]],
    wildignorecase = true,
    wildmenu = true,
    wildmode = "list:longest",
    updatetime = 500,
    expandtab = true,
    autoindent = true,
    smartindent = true,
    shortmess = vim.o.shortmess .. "c",
    scrolloff = 12,
    completeopt = "menuone,noinsert,noselect",
    swapfile = false,
    ttyfast = true,
    autowrite = true,
    cursorline = true,
  }

  vim.o.clipboard = vim.o.clipboard .. "unnamedplus"
  vim.wo.relativenumber = true
  vim.wo.number = true
  vim.bo.shiftwidth = 4
  vim.bo.softtabstop = 4

  for k, v in pairs(options) do
    vim.o[k] = v
  end
end

local function set_colors()
  require("colorbuddy").colorscheme("gruvbox")
end

FILETYPE_HOOKS = {
  lua = function()
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.tabstop = 2

    vim.g.neoformat_lua_luaformat = {
      exe = "lua-format",
      args = {"-c " .. vim.fn.expand("~/.config/nvim/lua/.lua-format")},
    }
    vim.g.neoformat_enabled_lua = {"luaformat"}
  end,
  go = function()
    local opts = {noremap = true}
    local mappings = {
      {"n", "<leader>lk", [[<Cmd>call go#lsp#Restart()<CR>]], opts},
      {"n", "<leader>l", [[<Cmd>GoMetaLinter<CR>]], opts},
    }
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.tabstop = 4

    -- disable vim-go snippet engine
    vim.g.go_snippet_engine = ""

    -- vim-go vars
    vim.g.go_fmt_command = "goimports"
    vim.g.go_list_type = "quickfix"
    vim.g.go_addtags_transform = "camelcase"
    vim.g.go_metalinter_enabled = {}
    vim.g.go_metalinter_autosave_enabled = {}
    vim.g.go_doc_popup_window = true

    for _, map in pairs(mappings) do
      vim.api.nvim_buf_set_keymap(0, unpack(map))
    end
  end,
  viml = function()
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
  html = function()
    vim.g.neoformat_enabled_html = {}
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
  end,
  proto = function()
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
  yaml = function()
    vim.g.neoformat_enabled_yaml = {}
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
  sh = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
  end,
}

set_globals()
set_options()
set_colors()

local opts = {noremap = true}
local mappings = {
  {"n", "<leader>ev", [[<Cmd>edit $HOME/.config/nvim/lua/init.lua<CR>]], opts},
  {"n", "<leader>sv", [[<Cmd>source $HOME/.config/nvim/lua/init.lua<CR>]], opts},
  {"n", "<leader>up", [[<Cmd>PackerSync<CR>]], opts},
  {"n", "<leader>\\", [[<Cmd>noh<CR>]], opts},
  {"n", "<tab>", [[<Cmd>b#<CR>]], opts},
  {"n", "<c-p>", [[<Cmd>Telescope find_files<CR>]], opts},
  {"n", "<c-f>", [[<Cmd>Telescope live_grep<CR>]], opts},
  {"n", "<c-l>", [[<Cmd>LuaTreeToggle<CR>]], opts},
  {"n", "<c-right>", [[<Cmd>tabnext<CR>]], opts},
  {"n", "<c-left>", [[<Cmd>tabprevious<CR>]], opts},
  {"n", "<leader>w", [[<C-w>w]], opts},
  {"n", "<leader>su", [[<Cmd>%s/original_string/new_string/g]], opts},
  {"n", "<leader>sb", [[<Cmd>cfdo %s/original_string/new_string/g]], opts},
  {"n", "<leader>mp", [[<Cmd>Glow<CR>]], opts},
  {"n", "<S-Up>", [[<Cmd>m-2<CR>]], opts},
  {"i", "<S-Up>", [[<Cmd>m-2<CR>]], opts},
  {"n", "<S-Down>", [[<Cmd>m+<CR>]], opts},
  {"i", "<S-Down>", [[<Cmd>m+<CR>]], opts},
}

for _, map in pairs(mappings) do
  vim.api.nvim_set_keymap(unpack(map))
end

local autocmds = {
  general = {
    {"BufWritePre", "*", [[Neoformat]]},
    {"BufWritePost init.vim nested source $MYVIMRC"},
    {
      "BufReadPost",
      "*",
      [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]],
    },
  },
}

for filetype, _ in pairs(FILETYPE_HOOKS) do
  autocmds["LuaFileTypeHook_" .. utils.escape_keymap(filetype)] =
    {{"FileType", filetype, ("lua FILETYPE_HOOKS[%q]()"):format(filetype)}};
end

utils.nvim_create_augroups(autocmds)
