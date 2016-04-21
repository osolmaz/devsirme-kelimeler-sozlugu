# Makefile for the LaTeX boilerplate
# (c) @hos 2015
#
# Find the main latex files using technology
SOURCE := main.tex
# SOURCE := $(shell egrep -l '^[^%]*\\begin\{document\}' *.tex)
# SOURCE := $(shell egrep -l '^[^%]*\\begin\{document\}' *.tex | head -n 1)
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
all: $(PDF)
#
#
%.pdf: %.tex
	@xelatex $<
	@echo $@ done.
#
# Use imagemagick to convert raster images to EPS
#
%.eps: %.png
	convert $< $@
#
%.eps: %.tif
	convert $< $@
#
%.eps: %.jpg
	convert $< $@
#
# Make the project depend on all TeX related files in the directory
# This will ensure rebuilding when they change
#
$(DVI): $(ALL)
#
dvi: $(DVI)
ps: $(PS)
pdf: $(PDF)
#
fig: $(EPSFIG)
#
show:
	gv $(MAIN)
#
show-dvi:
	xdvi -watchfile 2 $(DVI)&
#
edit:   show-dvi
	$(EDITOR) $(SOURCE)
#
edit-all: show-dvi
	$(EDITOR) $(SOURCE) $(ALL)
#
clean:
	@rm -f *.ps *.dvi *.pdf *~ *.log *.aux *.toc
