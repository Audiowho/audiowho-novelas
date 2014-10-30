title=$(shell cat metadata.json | jq '.title')
author=$(shell cat metadata.json | jq '.author')
publisher=$(shell cat metadata.json | jq '.publisher')
isbn=$(shell cat metadata.json | jq '.isbn')
date=$(shell cat metadata.json | jq '.date')
cover="images/cover.jpg"

all: pdf epub clean

prereq:
	-mkdir build

pdf: prereq titlepage pre caps post
	-pdflatex -output-directory=build docs/base.tex
	-pdflatex -output-directory=build docs/base.tex
	mv build/base.pdf build/$(title).pdf

epub: prereq caps pre post metadata.json images/cover.jpg
	pandoc docs/base.tex -o build/base.epub
	ebook-convert build/base.epub build/base2.epub --title $(title) --authors $(author) --publisher $(publisher) --isbn $(isbn) -d $(date) --extra-css=style.css --pretty-print --epub-inline-toc --toc-title=$(title)
	ebook-polish build/base2.epub build/$(title).epub -c $(cover) -p --verbose -f -j -u

caps: $(wildcard docs/caps/*.tex)
	ls docs/caps/*.tex | awk '{printf "\\input{%s}\n", $$1}' > docs/caps.tex

pre: $(wildcard docs/pre/*.tex)
	ls docs/pre/*.tex | awk '{printf "\\input{%s}\n", $$1}' > docs/pre.tex

post: $(wildcard docs/post/*.tex)
	ls docs/post/*.tex | awk '{printf "\\input{%s}\n", $$1}' > docs/post.tex

titlepage: cover
	printf "%s\n" "\begin{titlepage}" > docs/titlepage.tex
	printf "%s\n" "% ---------------    PORTADA      ---------------- " >> docs/titlepage.tex
	printf "%s\n" "\includepdf{images/cover.pdf}" >> docs/titlepage.tex
	printf "%s\n" "\newpage" >> docs/titlepage.tex
	printf "%s\n" "% ---------------     TÍTULO      ---------------- " >> docs/titlepage.tex
	printf "%s\n" "\begin{center} " >> docs/titlepage.tex
	printf "%s\n" "\hspace{0pt}\\\\ " >> docs/titlepage.tex
	printf "%s\n" "\vspace{4cm} " >> docs/titlepage.tex
	printf "%s\n" "{\Large\bfseries $(author)}\\\\[5pt] " >> docs/titlepage.tex
	printf "%s\n" "\vspace{3cm} " >> docs/titlepage.tex
	printf "%s\n" "{\scalebox{2}{\Large\bfseries $(title)}}\\\\ " >> docs/titlepage.tex
	printf "%s\n" "\vspace{0.8cm} " >> docs/titlepage.tex
	printf "%s\n" "% ---------------    EDITORIAL      ---------------- " >> docs/titlepage.tex
	printf "%s\n" "\vfill " >> docs/titlepage.tex
	printf "%s\n" "$(publisher)\\\\ " >> docs/titlepage.tex
	printf "%s\n" "$(date) " >> docs/titlepage.tex
	printf "%s\n" "% -------------------------------------------------- " >> docs/titlepage.tex
	printf "%s\n" "\end{center} " >> docs/titlepage.tex
	printf "%s\n" "\end{titlepage} " >> docs/titlepage.tex

cover: images/cover.jpg
	convert images/cover.jpg images/cover.pdf

clean: 
	-rm build/*.log
	-rm build/*.aux
	-rm build/*.toc
	-rm build/*.out
	-rm docs/caps.tex
	-rm docs/pre.tex
	-rm docs/post.tex
	-rm docs/titlepage.tex
	-rm images/cover.pdf
	-rm build/base.epub
	-rm build/base2.epub