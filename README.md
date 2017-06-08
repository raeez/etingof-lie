# amstex-template


Project template for the management and build of large AmSTeX LaTeX projects.

## prereqs
- GNU coreutils, basic latex installation, pf2htmlex (included as git submodule)

## basic properties
- configured for use with vim-latex-suite (see https://github.com/vim-latex/vim-latex)
- builds with GNU make (see Makefile)
- build targets are { tar, pdf, html }

## common build rules
- make { q, qc, qa, pdf, html, tar, install-pdf, install-html }

## config
See beginning of Makefile for configuration variables / flags

## TODO
- check cross platform compatability (at present only tested on darwin)
- improve dependency management with intermediate build targets
- documentation esp. { TEXMAIN, TEXSUITEMAIN, pdf2htmlex }
- investigate latexmk
- improve on $(KILL) blindly using -rf
