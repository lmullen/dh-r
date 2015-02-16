HTML_FILES := $(patsubst %.Rmd, %.html ,$(wildcard *.Rmd))

all : html jekyll

html : $(HTML_FILES)

%.html : %.Rmd
	R --slave -e "set.seed(100);rmarkdown::render('$<')"

.PHONY: jekyll
jekyll : 
	jekyll build

.PHONY: clean
clean :
	$(RM) $(HTML_FILES)
	rm -rf public/*

