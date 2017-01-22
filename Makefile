_book/index.html : $(wildcard *.Rmd) DESCRIPTION _before.R _output.yml book.bib ga.html $(wildcard images/*) style.css toc.css
	./build.sh

deploy :
	./deploy.sh

clobber :
	Rscript -e "options(bookdown.clean_book = TRUE); bookdown::clean_book()"

wordcount : _book/index.html
	mkdir -p wordcounts
	wc -w _book/*.md > wordcounts/wc-$(shell date +%Y-%m-%dT%H:%M:%S%z).txt

