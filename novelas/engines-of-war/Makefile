all: pdf epub clean

pdf: caps.tex notas.tex
	-pdflatex -output-directory=build docs/base.tex 
	-pdflatex -output-directory=build docs/base.tex 

epub: caps.tex notas.tex
	-pandoc docs/base.tex -o build/base.epub

caps.tex: $(wildcard docs/caps/*.tex)
	ls docs/caps/*.tex | awk '{printf "\\input{%s}\n", $$1}' > docs/caps.tex

notas.tex: $(wildcard docs/notas/*.tex)
	ls docs/notas/*.tex | awk '{printf "\\input{%s}\n", $$1}' > docs/notas.tex

clean: 
	-rm build/*.log
	-rm build/*.aux
	-rm build/*.toc
	-rm build/*.out
	-rm docs/caps.tex
	-rm docs/notas.tex