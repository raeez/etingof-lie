NOW=now # (not-)sensible default in case the next line fails
-include $(PROJ)/mkscripts/timestamp.mk
LTXDIR := $(shell kpsewhich -var-value=TEXMFHOME)

WEBDIR=notes
PROJECT=etingof-lie
TEXFLAGS=-output-directory=out -interaction=nonstopmode
TEX=pdflatex $(TEXFLAGS)
BUILDTEX=$(TEX) $(PROJECT).tex
QUICKBUILDTEX=$(TEX) $(TEXFLAGS) $(PROJECT).tex

.PHONY: all install open-pdf pdf quick quickfullpdf index clean

all: quick open

quick:
	$(QUICKBUILDTEX)

quickfull: clean
	$(QUICKBUILDTEX)
	make index
	$(QUICKBUILDTEX)

open:
	open -a Skim out/$(PROJECT).pdf

full:
	make clean
	make pdf # 1 full pass
	make pdf-pass
	make pdf-pass
	make tar
	make open

tar:
	tar cvzf out/$(PROJECT)-$(NOW).tar.gz *.tex bib Makefile sections

pdf: index
	make pdf-pass

index: pdf-pass
	-makeindex out/$(PROJECT).nlo -s nomencl.ist -o out/$(PROJECT).nls # ignore remaining errors

pdf-pass:
	-$(BUILDTEX)

install:
	-cp out/*.pdf $(PROJ)/www/raeez.com/$(WEBDIR)/
	-cp out/*.html $(PROJ)/www/raeez.com/$(WEBDIR)/

open-pdf: pdf
	open out/*.pdf

clean:
	-rm -rf *.toc *.ilg *.log *.nlo *.dvi *.aux *.tar.gz *.nlo *.nls *.nls *.out *.toc *.sta *.gla
	-rm -rf out/*.toc out/*.ilg out/*.log out/*.nlo out/*.dvi out/*.aux out/*.tar.gz out/*.nlo out/*.nls out/*.nls out/*.out out/*.toc out/*.sta out/*.gla
	-rm -rf ~/.vim/backup/*
	-rm -rf out/*
