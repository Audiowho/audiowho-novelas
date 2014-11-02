title_pre=$(shell cat metadata.json | jq '.title')
title=$(shell echo ${title_pre})

author_pre=$(shell cat metadata.json | jq '.author')
author=$(shell echo ${author_pre})

publisher_pre=$(shell cat metadata.json | jq '.publisher')
publisher=$(shell echo ${publisher_pre})

date_pre=$(shell cat metadata.json | jq '.date')
date=$(shell echo ${date_pre})

isbn_pre=$(shell cat metadata.json | jq '.isbn')

cover="images/cover.jpg"

all: pdf epub clean

prereq:
	-mkdir build
	cp docs/base.tex build/base.tex
	sed -i 's/%%TITLE%%/$(title)/g' build/base.tex
	sed -i 's/%%AUTHOR%%/$(author)/g' build/base.tex
	sed -i 's/%%PUBLISHER%%/$(publisher)/g' build/base.tex
	sed -i 's/%%DATE%%/$(date)/g' build/base.tex
	convert images/cover.jpg images/cover.pdf

pdf: prereq pre caps post
	pdflatex -output-directory=build build/base.tex
	pdflatex -output-directory=build build/base.tex
	mv build/base.pdf "build/$(title).pdf"

epub: prereq caps pre post metadata.json images/cover.jpg
	pandoc build/base.tex -o build/base.epub
	ebook-convert build/base.epub build/base2.epub --title "$(title)" --authors "$(author)" --publisher "$(publisher)" --isbn $(isbn) --date=$(date) --extra-css=style.css --pretty-print --epub-inline-toc --toc-title="$(title)"
	ebook-polish build/base2.epub build/"$(title).epub" -c $(cover) -p --verbose -f -j -u

caps: $(wildcard docs/caps/*.tex)
	ls docs/caps/*.tex | awk '{printf "\\input{%s}\n", $$1}' > build/caps.tex

pre: $(wildcard docs/pre/*.tex)
	ls docs/pre/*.tex | awk '{printf "\\input{%s}\n", $$1}' > build/pre.tex

post: $(wildcard docs/post/*.tex)
	ls docs/post/*.tex | awk '{printf "\\input{%s}\n", $$1}' > build/post.tex

clean: 
	-rm build/*.log
	-rm build/*.aux
	-rm build/*.toc
	-rm build/*.out
	-rm build/*.tex
	-rm images/cover.pdf
	-rm build/base.epub
	-rm build/base2.epub