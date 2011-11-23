# YATE Syntax Highlighting for VIM

Попытка реализовать подсветку синтаксиса YATE (https://github.com/pasaran/yate/wiki/syntax) в Виме.

Проверял только с темой Solarized, возможно, для других надо поменять цвета.

## Установка

Скопируйте `yate.vim` в папку `~/.vim/syntax`

Если используете Pathogen, то в папке `~/.vim/bundle` выполните

    git clone git://github.com/lork/yate-syntax.git

В `~/.vimrc` добавьте

    au BufRead,BufNewFile *.yate setf yate
