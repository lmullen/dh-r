BOOKFILES := $(wildcard *.Rmd) DESCRIPTION _before.R _output.yml book.bib ga.html $(wildcard images/*) style.css toc.css _bookdown.yml

_book/index.html : $(BOOKFILES)
	./build.sh
	wc -w _book/*.md > wordcounts/wc-$(shell date +%Y-%m-%dT%H:%M:%S%z).txt
	./wordcount-analysis.R

deploy :
	./deploy.sh

clobber :
	Rscript -e "options(bookdown.clean_book = TRUE); bookdown::clean_book()"

