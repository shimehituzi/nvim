-- 設定全体の読み込み順を一元管理する。
-- 順序が重要: options はプラグインより先、keymaps はプラグインの後
-- (プラグインが定義する既定マップをここで上書きするため)
require('config.options')
require('config.lazy')
require('config.keymaps')
require('config.autocmds')
