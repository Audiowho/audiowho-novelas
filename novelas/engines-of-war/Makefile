all: pdf epub

pdf: docs/base.tex
	pdflatex -output-directory=build docs/base.tex
	pdflatex -output-directory=build docs/base.tex

epub: docs/base.tex
	pandoc docs/base.tex -o build/base.epub

clean: 
	-rm build/*.log
	-rm build/*.aux
	-rm build/*.toc
	-rm build/*.out