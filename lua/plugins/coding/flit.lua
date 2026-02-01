return {
  'ggandor/flit.nvim',
  dependencies = {
    { url = 'https://codeberg.org/andyg/leap.nvim' },
    { 'tpope/vim-repeat' },
  },
  config = function() require('flit').setup() end,
}
