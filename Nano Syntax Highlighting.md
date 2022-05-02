# Nano Syntax Highlighting

Nano by default is pretty lacking in the syntax highlighting department. Luckily there is a GitHub repo ([serialhex](https://github.com/serialhex) / [nano-highlight](https://github.com/serialhex/nano-highlight)) collecting syntax highlighting files for additional languages.

Clone the git repo

``` sh
git clone git://github.com/serialhex/nano-highlight.git `~/.nano`
```

Enable syntax highlighting for all languages by editing `~/.nanorc`

``` sh
# Enable syntax highlighting for all languages
include "~/.nano/*.nanorc"
```
