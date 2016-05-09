SOURCE := main.tex
#
ALL    := $(wildcard *.tex *.sty)
DVI    := $(SOURCE:.tex=.dvi)
PSF    := $(SOURCE:.tex=.ps)
PDF    := $(SOURCE:.tex=.pdf)
#
# Select all figures under /fig
# The convention is that all figure files that are to be used in the project
# have to start with the prefix "fig"
#
# Define rules for all source files.
# latex => dvi => ps => pdf
#
pdf: $(PDF)
#
#
%.pdf: %.tex
	xelatex $<

generate-all: kip2kok

kip2kok:
	farsoarap_sozluk.py data/vezinler.yaml generated/kipten_koke.tex

edit: show-dvi
	$(EDITOR) $(SOURCE) $(ALL)
#
clean:
	@rm -f *.ps *.dvi *.pdf *~ *.log *.aux *.toc
