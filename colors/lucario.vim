" Lucario - The best colorful flat theme ever
" Author: Raphael Amorim
"
" GitHub project: https://github.com/raphamorim/lucario

set background=dark
highlight clear

set t_Co=256

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "lucario"

hi Cursor       cterm=NONE guifg=#2b3e50 guibg=#f8f8f2
hi Visual       ctermfg=NONE ctermbg=16 cterm=NONE guifg=NONE guibg=#19242f gui=NONE
hi CursorLine   ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi CursorColumn ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#78909c gui=italic
hi ColorColumn  ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi LineNr       ctermfg=223 ctermbg=NONE cterm=NONE guifg=#929ba1 guibg=NONE gui=NONE
hi VertSplit    ctermfg=60 ctermbg=60 cterm=NONE guifg=#5f99cb guibg=NONE gui=NONE
hi MatchParen   ctermfg=203 ctermbg=NONE cterm=underline guifg=#ff6541 guibg=NONE gui=underline
hi StatusLine   ctermfg=231 ctermbg=60 cterm=bold guifg=#f8f8f2 guibg=NONE gui=bold
hi StatusLineNC ctermfg=231 ctermbg=60 cterm=NONE guifg=#f8f8f2 guibg=NONE gui=NONE
hi Pmenu        ctermfg=16 ctermbg=24 cterm=NONE guifg=NONE guibg=#19242f gui=NONE
hi PmenuSel     ctermfg=16 ctermbg=45 cterm=NONE guifg=NONE guibg=#66747f gui=NONE
hi IncSearch    ctermfg=23 ctermbg=186 cterm=NONE guifg=#2b3e50 guibg=#f5f499 gui=NONE
hi Search       ctermfg=23 ctermbg=186 cterm=NONE guifg=#2b3e50 guibg=#d8e4f8 gui=underline
hi Directory    ctermfg=177 ctermbg=NONE cterm=NONE guifg=#ca94ff guibg=NONE gui=NONE
hi Folded       ctermfg=68 ctermbg=23 cterm=NONE guifg=#5c98cd guibg=NONE gui=bold
hi NormalFloat  guifg=#f8f8f2 guibg=#546e7a

" Colors for tabs in cterm
hi TabLineFill  ctermfg=12
hi TabLine      ctermfg=17 ctermbg=11 cterm=NONE
hi TabLineSel   ctermfg=8 ctermbg=14 cterm=NONE

hi Normal       ctermfg=231 ctermbg=NONE cterm=NONE guifg=#f8f8f2 guibg=NONE gui=NONE
hi Boolean      ctermfg=177 ctermbg=NONE cterm=NONE guifg=#ca94ff guibg=NONE gui=NONE
hi Character    ctermfg=177 ctermbg=NONE cterm=NONE guifg=#ca94ff guibg=NONE gui=NONE
hi Comment      ctermfg=44 ctermbg=NONE cterm=NONE guifg=#5c98cd guibg=NONE gui=NONE
hi Conditional  ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ff6541 guibg=NONE gui=NONE
hi Constant     ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Define       ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ff6541 guibg=NONE gui=NONE
hi DiffAdd      ctermfg=231 ctermbg=64 cterm=bold guifg=#f8f8f2 guibg=#478815 gui=bold
hi DiffDelete   ctermfg=88 ctermbg=NONE cterm=NONE guifg=#8c0c10 guibg=NONE gui=NONE
hi DiffChange   ctermfg=231 ctermbg=23 cterm=NONE guifg=#f8f8f2 guibg=#26446c gui=NONE
hi DiffText     ctermfg=231 ctermbg=24 cterm=bold guifg=#f8f8f2 guibg=#204a87 gui=bold
hi ErrorMsg     ctermfg=231 ctermbg=197 cterm=NONE guifg=#f8f8f0 guibg=#f92672 gui=NONE
hi WarningMsg   ctermfg=231 ctermbg=197 cterm=NONE guifg=#f8f8f0 guibg=#f92672 gui=NONE
hi Float        ctermfg=177 ctermbg=NONE cterm=NONE guifg=#ca94ff guibg=NONE gui=NONE
hi Function     ctermfg=71 ctermbg=NONE cterm=NONE guifg=#72c05d guibg=NONE gui=NONE
hi Identifier   ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=italic
hi Keyword      ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ff6541 guibg=NONE gui=NONE
hi Label        ctermfg=186 ctermbg=NONE cterm=NONE guifg=#e6db74 guibg=NONE gui=NONE
hi NonText      ctermfg=74 ctermbg=NONE cterm=NONE guifg=#61bbc8 guibg=NONE gui=NONE
hi Number       ctermfg=177 ctermbg=NONE cterm=NONE guifg=#ca94ff guibg=NONE gui=NONE
hi Operator     ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ff6541 guibg=NONE gui=NONE
hi PreProc      ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ff6541 guibg=NONE gui=NONE
hi Parameter    ctermfg=214 ctermbg=NONE cterm=NONE guifg=#ffab28 guibg=NONE gui=italic
hi Special      ctermfg=231 ctermbg=NONE cterm=NONE guifg=#f8f8f2 guibg=NONE gui=NONE
hi SpecialKey   ctermfg=74 ctermbg=59 cterm=NONE guifg=#61bbc8 guibg=#405160 gui=NONE
hi Statement    ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ff6541 guibg=NONE gui=NONE
hi StorageClass ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=italic
hi String       ctermfg=186 ctermbg=NONE cterm=NONE guifg=#e6db74 guibg=NONE gui=NONE
hi Tag          ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ff6541 guibg=NONE gui=NONE
hi Title        ctermfg=231 ctermbg=NONE cterm=bold guifg=#f8f8f2 guibg=NONE gui=bold
hi Todo         ctermfg=68 ctermbg=NONE cterm=inverse,bold guifg=#5c98cd guibg=NONE gui=inverse,bold
hi Type         ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Underlined   ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline


" Ruby
hi rubyClass                    ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ff6541 guibg=NONE gui=NONE
hi rubyFunction                 ctermfg=71 ctermbg=NONE cterm=NONE guifg=#72c05d guibg=NONE gui=NONE
hi rubyInterpolationDelimiter   ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubySymbol                   ctermfg=177 ctermbg=NONE cterm=NONE guifg=#ca94ff guibg=NONE gui=NONE
hi rubyConstant                 ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=italic
hi rubyStringDelimiter          ctermfg=186 ctermbg=NONE cterm=NONE guifg=#e6db74 guibg=NONE gui=NONE
hi rubyBlockParameter           ctermfg=214 ctermbg=NONE cterm=NONE guifg=#ffab28 guibg=NONE gui=italic
hi rubyInstanceVariable         ctermfg=81 ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyInclude                  ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ff6541 guibg=NONE gui=NONE
hi rubyGlobalVariable           ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyRegexp                   ctermfg=186 ctermbg=NONE cterm=NONE guifg=#e6db74 guibg=NONE gui=NONE
hi rubyRegexpDelimiter          ctermfg=186 ctermbg=NONE cterm=NONE guifg=#e6db74 guibg=NONE gui=NONE
hi rubyEscape                   ctermfg=177 ctermbg=NONE cterm=NONE guifg=#ca94ff guibg=NONE gui=NONE
hi rubyControl                  ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ff6541 guibg=NONE gui=NONE
hi rubyClassVariable            ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyOperator                 ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ff6541 guibg=NONE gui=NONE
hi rubyException                ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ff6541 guibg=NONE gui=NONE
hi rubyPseudoVariable           ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyRailsUserClass           ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=italic
hi rubyRailsARAssociationMethod ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi rubyRailsARMethod            ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi rubyRailsRenderMethod        ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi rubyRailsMethod              ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE

" eRuby
hi erubyDelimiter   ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi erubyComment     ctermfg=68 ctermbg=NONE cterm=NONE guifg=#5c98cd guibg=NONE gui=NONE
hi erubyRailsMethod ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE

" HTML
hi htmlTag          ctermfg=15 ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag       ctermfg=15 ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlTagName      ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlArg          ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar  ctermfg=177 ctermbg=NONE cterm=NONE guifg=#ca94ff guibg=NONE gui=NONE

" JavaScript
hi javaScriptFunction      ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=italic
hi javaScriptRailsFunction ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi javaScriptBraces        ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE

" YAMl
hi yamlKey              ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ff6541 guibg=NONE gui=NONE
hi yamlAnchor           ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlAlias            ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlDocumentHeader   ctermfg=186 ctermbg=NONE cterm=NONE guifg=#e6db74 guibg=NONE gui=NONE

" CSS
hi cssURL           ctermfg=214 ctermbg=NONE cterm=NONE guifg=#ffab28 guibg=NONE gui=italic
hi cssFunctionName  ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi cssColor         ctermfg=177 ctermbg=NONE cterm=NONE guifg=#ca94ff guibg=NONE gui=NONE
hi cssPseudoClassId ctermfg=71 ctermbg=NONE cterm=NONE guifg=#72c05d guibg=NONE gui=NONE
hi cssClassName     ctermfg=71 ctermbg=NONE cterm=NONE guifg=#72c05d guibg=NONE gui=NONE
hi cssValueLength   ctermfg=177 ctermbg=NONE cterm=NONE guifg=#ca94ff guibg=NONE gui=NONE
hi cssCommonAttr    ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi cssBraces        ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE

" Python
hi pythonStatement ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=italic
hi pythonBuiltin   ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=italic

" Markdown
hi mkdHeading                 guifg=#ff6d00
hi htmlH1                     guifg=#ffa726
hi mkdNonListItemBlock        guifg=#fbe9e7
hi mkdLineBreak               guifg=NONE guibg=NONE gui=underline
hi htmlTag                    guifg=#90caf9
hi htmlEndTag                 guifg=#90caf9
hi htmlTagName                guifg=#c5cae9
hi htmlArg                    guifg=#82b1ff
hi htmlString                 guifg=#b39ddb
hi htmlValue                  guifg=#b39ddb
hi htmlSpecialChar            guifg=#b39ddb
hi htmllink                   guifg=#f48fb1
hi mkdDelimiter               guifg=#90a4ae
hi mkdListItem                guifg=#ff5722
hi mkdListItemLine            guifg=#ff9e80
hi mkdBold                    guifg=#ffd54f
hi htmlBold                   guifg=#ffd54f
hi mkdItalic                  guifg=#ffecb3
hi htmlItalic                 guifg=#ffecb3

" Tex
hi texStatement               guifg=#81c784
hi texMathMatcher             guifg=#c5e1a5
hi texMathOper                guifg=#eeff41
hi texMathDelim               guifg=#dce775
hi texMathZoneX               guifg=#ccff90
hi texMathZoneY               guifg=#ccff90
hi texSpecialChar             guifg=#b9f6ca
hi texLength                  guifg=#8bc34a

" Haskell
hi haskellBackpackStructure          guifg=#000000 gui=bold
hi haskellBackpackDependency         guifg=#000000 gui=bold
hi haskellBlock                      guifg=#a7ffeb
hi haskellIdentifier                 guifg=#84ffff gui=italic
hi haskellOperators                  guifg=#ffd180
hi haskellSeparator                  guifg=#b0bec5
hi haskellParens                     guifg=#ffffff
hi haskellRecordField                guifg=#000000 gui=bold
hi haskellWhere                      guifg=#ff8a80
hi haskellLet                        guifg=#ff8a80
hi haskellDefault                    guifg=#000000 gui=bold
hi haskellTypeSig                    guifg=#000000 gui=bold
hi HaskellDerive                     guifg=#ff8a80
hi haskellDeclKeyword                guifg=#ff8a80
hi haskellDecl                       guifg=#ff8a80
hi haskellImportKeywords             guifg=#ccff90
hi haskellForeignKeywords            guifg=#000000 gui=bold
hi haskellString                     guifg=#b9f6ca
hi haskellForeignImport              guifg=#000000 gui=bold
hi haskellType                       guifg=#82b1ff
hi haskellLineComment                guifg=#bcaaa4
hi haskellBlockComment               guifg=#bcaaa4
hi haskellPragma                     guifg=#b0bec5
hi haskellImport                     guifg=#ffffff
hi haskellKeyword                    guifg=#ff8a80
hi haskellStatic                     guifg=#000000 gui=bold
hi haskellConditional                guifg=#ff8a80
hi haskellNumber                     guifg=#b388ff
hi haskellFloat                      guifg=#b388ff
hi haskellDelimiter                  guifg=#b0bec5
hi haskellBrackets                   guifg=#ffff8d
hi haskellInfix                      guifg=#ff8a80
hi haskellBottom                     guifg=#ff8a80
hi haskellQuote                      guifg=#b9f6ca
hi haskellQuotedType                 guifg=#b9f6ca
hi haskellQuoted                     guifg=#b9f6ca
hi haskellTodo                       guifg=#000000 gui=bold
hi haskellBacktick                   guifg=#ffd180
hi haskellChar                       guifg=#b9f6ca
hi haskellLiquid                     guifg=#000000 gui=bold
hi haskellPreProc                    guifg=#000000 gui=bold
hi haskellShebang                    guifg=#000000 gui=bold
hi haskellQuasiQuote                 guifg=#000000 gui=bold
hi haskellQuasiQuoted                guifg=#000000 gui=bold
hi haskellTH                         guifg=#000000 gui=bold
hi haskellTHBlock                    guifg=#000000 gui=bold
hi haskellTHDoubleBlock              guifg=#000000 gui=bold
hi haskellTypeRoles                  guifg=#000000 gui=bold
hi haskellTypeRoleBlock              guifg=#000000 gui=bold
hi haskellForall                     guifg=#000000 gui=bold
hi haskellRecursiveDo                guifg=#000000 gui=bold
hi haskellArrowSyntax                guifg=#000000 gui=bold
hi haskellPatternKeyword             guifg=#000000 gui=bold
hi haskellAssocType                  guifg=#000000 gui=bold

" CoC
hi CocFloating guifg=#1565c0 guibg=#e3f2fd


" typescript
