all: pdf epub clean

pdf: pre caps post
	pdflatex -output-directory=build build/base.tex
	pdflatex -output-directory=build build/base.tex

epub: caps pre post
	pandoc build/base.tex -o build/base.epub

caps: $(wildcard docs/caps/*.tex)
	ls docs/caps/*.tex | awk '{printf "\\input{%s}\n", $$1}' > build/caps.tex

pre: $(wildcard docs/pre/*.tex)
	ls docs/pre/*.tex | awk '{printf "\\input{%s}\n", $$1}' > build/pre.tex

post: $(wildcard docs/post/*.tex)
	ls docs/post/*.tex | awk '{printf "\\input{%s}\n", $$1}' > build/post.tex

clean: 
	-rm -r build
	-rm style.css