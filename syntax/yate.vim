" Yet Another Template Engine Syntax for Vim
" Language: Yet Another Template Engine
" Maintainer: Igor Spisivtsev (gexsmail@gmail.com)
" GIT: https://github.com/lork/yate-syntax
" Last Change: 23.11.2011
" Version: 0.3
" Попытка реализовать подсветку синтаксиса для шаблонизатора yate Нопа.
" Yet Another Template Engine (yate) page: http://github.com/pasaran/yate
" TODO: подсвечивать
"           [x] комментарии
"           [x] скобки
"           [x] переменные
"           [x] html
"           [x] jPath (сейчас точно правильно работает?)
"           [x] ключевые слова (все?)
"           [x] моды
"           [x] xml-атрибуты
"           [ ] спецсимволы (операций сравнения и т.п.)
"           [ ] функции
"       [ ] переопределить html'ные <a>, <b>, <strong> и т.п.
"       [ ] подсвечивать внутри html-атрибутов

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case ignore
set iskeyword+=-


syn include @HTML           syntax/html.vim
syn region  yateBlock       start="{" end="}" fold transparent contains=@HTML, yateBlock, yateKeyword, yateBraket, yatePredicat, yateLineComment, yateBlockComment, yateConstant, yateMode, yateJPath, yateJPathNode, yateJPathNodeA, yateJPathRoot, yateTextNode, yateAttr, yateBraces, yateParens
syn region  yateInlineBlock contained start="{\s" end="\s}" contains=yateJPath, yateJPathNode, yateJPathNodeA, yateJPathoot, yateBraces, yateParens
syn region  yateTextNode    start=+"+ end=+"+ contains=yateInlineBlock


syn match   yateConstant    "[a-zA-Z0-9\-_]"
syn match   yateMode        "#[A-Za-z_@][A-Za-z0-9_@-]*" contains=yateModeStart
syn match   yateAttr        "@[A-Za-z_][A-Za-z0-9_-]*" contains=yateAttrStart
syn match   yateModeStart   contained "#"
syn match   yateAttrStart   contained "@"
syn match   yateJPathRoot   "\s/"
syn match   yateJPathNode   "\s\.\s"
syn match   yateJPathNodeA  "\.\*"
syn match   yateJPath       "\.[A-Za-z][A-Za-z0-9_-]\{0,\}"
syn keyword yateKeyword     match function func apply attrs key if for

" syn match   htmlValue       contained "=[\t ]*[^'" \t>][^ \t>]*"hs=s+1   contains=javaScriptExpression,@htmlPreproc,yateInlineBlock
" syn region  yatehtmlLink    start="<a\>\_[^>]*\<href\>" end="</a>"me=e-4 contains=@Spell,htmlTag,htmlEndTag,htmlSpecialChar,htmlPreProc,htmlComment,javaScript,@htmlPreproc,yateBlock,yateConstant,yateInlineBlock

syn region  yateTextNode    start=+"+ end=+"+ contains=yateJPath, yateJPathNode, yateJPathNodeA, yateJPathRoot, yateBraces, yateParens

syn keyword yateCommentTodo     contained TODO TBD XXX FIXME
syn match   yateLineComment     "\/\/.*"  contains=@Spell,yateCommentTodo
syn match   yateCommentSkip     "^[ \t]*\*\($\|[ \t]\+\)"
syn region  yateBlockComment    start="/\*" end="\*/"  contains=@Spell,yateCommentTodo

syn match	yateBraces          contained "[{}\[\]]"
syn match	yateParens          "[()]"

" Define the default highlighting.
command -nargs=+ HLink hi def link <args>

HLink yateCommentTodo   Todo
HLink yateLineComment   Comment
HLink yateBlockComment  Comment

HLink yateBraces        Comment
HLink yateParens        Comment

HLink yateConstant      Type
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
