BOOKFILES := $(wildcard *.Rmd) DESCRIPTION _before.R _output.yml book.bib ga.html $(wildcard images/*) style.css toc.css _bookdown.yml

all : _book/index.html _book/Mullen-ComputationalHistoricalThinking.pdf

_book/index.html : $(BOOKFILES)
	./build.sh

_book/Mullen-ComputationalHistoricalThinking.pdf : $(BOOKFILES) preamble.tex
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"

deploy :
	./deploy.sh

clobber :
	Rscript -e "options(bookdown.clean_book = TRUE); bookdown::clean_book()"

wordcount : _book/index.html
	mkdir -p wordcounts
	wc -w _book/*.md > wordcounts/wc-$(shell date +%Y-%m-%dT%H:%M:%S%z).txt

