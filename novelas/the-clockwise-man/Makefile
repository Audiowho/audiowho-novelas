HTML = $(wildcard docs/caps/*.html)
TEX = $(HTML:.html=.tex)

all: tex

tex: $(TEX)

docs/caps/%.tex: docs/caps/%.html
	@echo -e 'Building $@'
	pandoc $< -o $@

clean-html:
	rm -f docs/caps/*.html

clean-tex:
	rm -f docs/caps/*.tex
