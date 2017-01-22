_book/index.html : $(wildcard *.Rmd) DESCRIPTION _before.R _output.yml book.bib ga.html $(wildcard images/*) style.css toc.css
	./build.sh

deploy :
	./deploy.sh

clobber :
	Rscript -e "options(bookdown.clean_book = TRUE); bookdown::clean_book()"
