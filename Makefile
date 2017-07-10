DVIPS = dvips
LATEX = latex
PDFLATEX = pdflatex -shell-escape
BIBTEX = bibtex
PROJECT = atlastpx_sw_article
EDITOR = emacs # nebo jiny oblibeny editor
GV = gv # nebo ghostview

all: $(PROJECT).tex
	$(PDFLATEX) $(PROJECT).tex
edit:
	$(EDITOR) $(PROJECT).tex &

ref:	$(PROJECT).tex
	$(PDFLATEX) $(PROJECT).tex
	bibtex $(PROJECT)
	$(PDFLATEX) $(PROJECT).tex
	$(PDFLATEX) $(PROJECT).tex

bib:
	$(BIBTEX) $(PROJECT)

gv: $(PROJECT).ps
	$(GV) $< &

acr: $(PROJECT).pdf
	acroread $< &

final: final.pdf

final.pdf: $(PROJECT).pdf
	ps2pdf \
	-dPDFSETTINGS=/printer \
	-dCompatibilityLevel=1.4 -dCompressPages=true \
	-dUseFlateCompression=true -dSubsetFonts=true -dEmbedAllFonts=true \
	-dProcessColorModel=/DeviceGray -dDetectBlends=true -dOptimize=true \
	-dColorImageFilter=/FlateEncode \
	-dAutoFilterColorImages=false -dAntiAliasColorImages=false \
	-dColorImageDownsampleThreshold=1.50000 \
	-dGrayImageFilter=/FlateEncode -dAutoFilterGrayImages=false \
	-dAntiAliasGrayImages=false -dGrayImageDownsampleThreshold=1.50000 \
	-dDownsampleMonoImages=true -dMonoImageResolution=1200 \
	-dMonoImageDownsampleType=/Average -dMonoImageFilter=/FlateEncode \
	-dAutoFilterMonoImages=false -dAntiAliasMonoImages=false \
	-dMonoImageDownsampleThreshold=1.50000 \
	-dEPSCrop=true \
	$(PROJECT).pdf final.pdf

# PDFko lze vytvorit primo pomoci pdflatexu, ktery vklada obrazky ve formatu PDF
$(PROJECT).pdf: *.tex
	$(PDFLATEX) $<

# nebo konverzi z postscriptu. Tato moznost zase akceptuje jen postscriptove obrazky.
#$(PROJECT).pdf: *.ps
#	ps2pdf -s PAPERSIZE=a4 $<

# Odkomentujte/zakomentujte podle potreby.

$(PROJECT).ps: *.tex
	$(LATEX) $<

	
clean:
	rm -f *.log *.aux *.bbl *.blg *.lof *.lot *.dvi *.toc *.out *~ *.ps *.ilg *.nlo
