HTML_FILES := $(patsubst %.Rmd, %.html ,$(wildcard *.Rmd))
INCLUDE_FILES := $(wildcard include/*.html)

all : html jekyll

html : $(HTML_FILES)

%.html : %.Rmd $(INCLUDE_FILES)
	R --slave -e "set.seed(100);rmarkdown::render('$<')"

.PHONY : jekyll
jekyll :
	jekyll build
	rm public/*.Rmd

.PHONY : packrat
packrat :
	R --slave -e "packrat::restore()"

.PHONY : clean
clean :
	$(RM) $(HTML_FILES)
	rm -rf public/*

