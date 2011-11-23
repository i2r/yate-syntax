" Yet Another Template Engine Syntax for Vim
" Language: Yet Another Template Engine
" Maintainer: Igor Spisivtsev (gexsmail@gmail.com)
" GIT: https://github.com/lork/yate-syntax
" Last Change: 23.11.2011
" Version: 0.3
" Попытка реализовать подсветку синтаксиса для шаблонизатора yate Нопа.
" Yet Another Template Engine (yate) page: http://github.com/pasaran/yate
" TODO: подсвечивать
"       [x] комментарии
"       [x] переменные (см. yateName)
"       [x] html
"       [x] jPath (сейчас точно правильно работает?)
"       [x] «ключевые слова» (сейчас все?)
"       [x] моды
"       [x] xml-атрибуты
"       [ ] спецсимволы (операций сравнения и т.п.)
"       [x] скобки
"       [ ] функции

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case ignore
set iskeyword+=-


syn include @HTML           syntax/html.vim
syn region  yateBlock       start="{" end="}" fold transparent contains=@HTML, yateBlock, yateKeyword, yateBraket, yatePredicat, yateLineComment, yateBlockComment, yateName, yateMode, yateJPath, yateJPathNode, yateJPathNodeA, yateJPathRoot, yateTextNode, yateAttr, yateInlineBlock, yateBraces, yateParens
syn region  yateTextNode    contained start=+"+ end=+"+ contains=yateJPath, yateJPathNode, yateJPathNodeA, yateJPathRoot, yateBraces, yateParens

" TODO: влезть в html-атрибуты и подсветить их содержимое
" syn match   htmlValue       contained "=[\t ]*[^'" \t>][^ \t>]*"hs=s+1   contains=javaScriptExpression,@htmlPreproc,yateInlineBlock
" syn region  yateInlineBlock contained start="{ " end=" }"hs=s+1

syn match   yateName        "[a-zA-Z0-9\-_]"
syn match   yateMode        "#[A-Za-z_@][A-Za-z0-9_@-]*" contains=yateModeStart
syn match   yateAttr        "@[A-Za-z_][A-Za-z0-9_-]*" contains=yateAttrStart
syn match   yateModeStart   contained "#"
syn match   yateAttrStart   contained "@"
syn match   yateJPathRoot   "/"
syn match   yateJPathNode   "\s\.\s"
syn match   yateJPathNodeA  "\.\*"
syn match   yateJPath       "\.[A-Za-z][A-Za-z0-9_-]\{0,\}"
syn keyword yateKeyword     match function func apply key if for

" TODO: переопределить подсветку внутри тегов ссылок, тегов <b> и т.п.
" Подсветка внутри тегов-ссылок
" syn region  yatehtmlLink    start="<a\>\_[^>]*\<href\>" end="</a>"me=e-4 contains=@Spell,htmlTag,htmlEndTag,htmlSpecialChar,htmlPreProc,htmlComment,javaScript,@htmlPreproc,yateBlock,yateName

syn keyword yateCommentTodo     contained TODO TBD XXX FIXME
syn match   yateLineComment     "\/\/.*"  contains=@Spell,yateCommentTodo
syn match   yateCommentSkip     "^[ \t]*\*\($\|[ \t]\+\)"
syn region  yateBlockComment    start="/\*" end="\*/"  contains=@Spell,yateCommentTodo

syn match	yateBraces          contained "[{}\[\]]"
syn match	yateParens          contained "[()]"

" Define the default highlighting.
command -nargs=+ HLink hi def link <args>

HLink yateCommentTodo   Todo
HLink yateLineComment   Comment
HLink yateBlockComment  Comment

HLink yateBraces        Comment
HLink yateParens        Comment

HLink yateName          Type
HLink yateKeyword       Define
HLink yateAttr          Define
HLink yateAttrStart     Comment
HLink yateMode          HelpNote
HLink yateModeStart     Comment

HLink yateJPath         Repeat
HLink yateJPathRoot     Repeat
HLink yateJPathNode     Repeat
HLink yateJPathNodeA    Repeat

HLink yateTextNode      Normal

" FIXME: не работает нифига
" HLink yateInlineBlock   Todo

delcommand HLink


let b:current_syntax = "yate"
syn sync minlines=50
