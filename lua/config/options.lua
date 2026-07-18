local opt = vim.opt

opt.clipboard = 'unnamedplus'
opt.completeopt = 'menu,menuone,noselect'
opt.conceallevel = 3 -- 太字・斜体の * マークアップを隠す
opt.confirm = true
opt.expandtab = true
opt.fileencoding = 'utf-8' -- statusline の encoding 表示に使われる
-- foldopen / foldclose は Nerd Font のグリフ (画面上では見えにくいが必須)
opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
  vert = '┃',
  vertleft = '┃',
  vertright = '┃',
  verthoriz = '┿',
}
opt.fixeol = false
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.formatoptions = 'jcroqlnt'
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.ignorecase = true
opt.inccommand = 'nosplit'
opt.laststatus = 3
opt.list = true
opt.mouse = 'a'
opt.number = true
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = false
opt.scrolloff = 4
opt.shadafile = 'NONE'
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- hit-enter プロンプトを減らす
opt.showmode = false -- モードは statusline に表示されるため
opt.sidescrolloff = 8
opt.signcolumn = 'yes' -- テキストが横にずれないよう常時表示
opt.smartcase = true
opt.smartindent = true
opt.smoothscroll = true
opt.softtabstop = 2
opt.splitbelow = true
opt.splitkeep = 'screen'
opt.splitright = true
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.undolevels = 10000
opt.updatetime = 100 -- gitsigns 等プラグインの反応速度に影響
opt.virtualedit = 'block'
opt.wildmode = 'longest:full,full'
opt.winminwidth = 5
opt.wrap = false
opt.writebackup = false

-- gopls が宣言する gotmpl filetype は nvim 未登録のため補う (checkhealth vim.lsp の警告対策)
vim.filetype.add({ extension = { gotmpl = 'gotmpl' } })
