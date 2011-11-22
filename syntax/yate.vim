" Yet Another Template Engine Syntax for Vim
" Language: Yet Another Template Engine
" Maintainer: Igor Spisivtsev (gexsmail@gmail.com)
" GIT: https://github.com/lork/yate-syntax
" Last Change: 22.11.2011
" Version: 0.2
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
"       [ ] скобки
"       [ ] функции

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case ignore
set iskeyword+=-


syn include @HTML           syntax/html.vim
syn region  yateBlock       start="{" end="}" fold transparent contains=@HTML, yateBlock, yateKeyword, yateBraket, yatePredicat, yateLineComment, yateBlockComment, yateName, yateMode, yateJPath, yateJPathNode, yateJPathNodeA, yateJPathRoot, yateTextNode, yateAttr, yateInlineBlock
syn region  yateTextNode    contained start=+"+ end=+"+ contains=yateJPath, yateJPathNode, yateJPathNodeA, yateJPathRoot

" TODO: влезть в html-атрибуты и подсветить их содержимое
" syn region  yateInlineBlock matchgroup=htmlValue start="{ " end=" }"hs=s+1

syn match   yateName        "[a-zA-Z0-9\-_]"
syn match   yateMode        "#[A-Za-z_@][A-Za-z0-9_@-]*"
syn match   yateAttr        "@[A-Za-z_][A-Za-z0-9_-]*"
syn match   yateJPathRoot   "/"
syn match   yateJPathNode   "\s\.\s"
syn match   yateJPathNodeA  "\.\*"
syn match   yateJPath       "\.[A-Za-z][A-Za-z0-9_-]\{0,\}"
syn keyword yateKeyword     match function apply key if for

" TODO: переопределить подсветку внутри тегов ссылок, тегов <b> и т.п.
" Подсветка внутри тегов-ссылок
" syn region  yatehtmlLink    start="<a\>\_[^>]*\<href\>" end="</a>"me=e-4 contains=@Spell,htmlTag,htmlEndTag,htmlSpecialChar,htmlPreProc,htmlComment,javaScript,@htmlPreproc,yateBlock,yateName

syn keyword yateCommentTodo     contained TODO TBD XXX FIXME
syn match   yateLineComment     "\/\/.*"  contains=@Spell,yateCommentTodo
syn match   yateCommentSkip     "^[ \t]*\*\($\|[ \t]\+\)"
syn region  yateBlockComment    start="/\*" end="\*/"  contains=@Spell,yateCommentTodo


" Define the default highlighting.
command -nargs=+ HLink hi def link <args>

HLink yateName          Type
HLink yateKeyword       Define
HLink yateAttr          Define

HLink yateCommentTodo   Todo
HLink yateLineComment   Comment
HLink yateBlockComment  Comment

HLink yateMode          HelpNote
HLink yateJPath         Repeat
HLink yateJPathRoot     Repeat
HLink yateJPathNode     Repeat
HLink yateJPathNodeA    Repeat

" FIXME: не работает нифига
HLink yateTextNode      Normal
HLink yateInlineBlock   Todo

delcommand HLink


let b:current_syntax = "yate"
syn sync minlines=10
