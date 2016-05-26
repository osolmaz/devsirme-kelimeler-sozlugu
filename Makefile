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
	xelatex --shell-escape $<

generate-all: kip2kok kok2kip

kip2kok:
	farsoarap_gen_kip.py data/vezinler.yaml generated/kipten_koke.tex

kok2kip:
	farsoarap_gen_kok.py data/vezinler.yaml generated/kokten_kipe.tex

edit:
	emacs $(SOURCE) $(ALL)&
#
clean:
	@rm -f *.ps *.dvi *.pdf *~ *.log *.aux *.toc
