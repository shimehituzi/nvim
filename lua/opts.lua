local opt = vim.opt

opt.autoindent = true -- Enable auto indentation
opt.autoread = true -- Automatically read the file if it's changed externally
opt.backup = false -- Do not create backup files
opt.clipboard = 'unnamedplus' -- Sync with system clipboard
opt.completeopt = 'menu,menuone,noselect' -- Completion options
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.display = 'lastline' -- Display long messages on the last line
opt.expandtab = true -- Use spaces instead of tabs
opt.fenc = 'utf-8' -- Set file encoding to UTF-8
opt.fillchars = { foldopen = '', foldclose = '', fold = ' ', foldsep = ' ', diff = '╱', eob = ' ' } -- Characters to fill
opt.fixeol = false -- Do not add EOL to the last line
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.formatoptions = 'jcroqlnt' -- Automatically formatting options
opt.grepformat = '%f:%l:%c:%m' -- Format for grep command
opt.grepprg = 'rg --vimgrep' -- Use ripgrep instead of grep
opt.hidden = true -- Hide unsaved buffers in the background
opt.hlsearch = true -- Highlight search strings
opt.ignorecase = true -- Ignore case
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.incsearch = true -- Enable incremental search
opt.laststatus = 3 -- global statusline
opt.list = true -- Show some invisible characters (tabs...
opt.matchtime = 1 -- Set the display time for shown match items
opt.mouse = 'a' -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = false -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.shadafile = 'NONE' -- Disable shada file
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- Shorten messages to avoid hit-enter prompts
opt.showcmd = true -- Show partial commands during command input
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.smoothscroll = true -- Enable smooth scrolling
opt.softtabstop = 2 -- Set soft tab width to 2
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = 'screen' -- Keep the same view in split
opt.splitright = true -- Put new windows right of current
opt.swapfile = false -- Do not create a swap file
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeout = true -- Enable the use of timed waits for mapped key sequences. This affects how Vim handles key mappings.
opt.timeoutlen = 300 -- Time in milliseconds to wait for a mapped sequence to complete
opt.undolevels = 10000 -- Maximum number of undo levels
opt.updatetime = 100 -- The length of time Vim waits after you stop typing before it triggers the plugin
opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.wrapscan = true -- Searches do not stop at the end of the file
opt.writebackup = false -- Do not create a backup when writing
