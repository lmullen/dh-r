HTML_FILES := $(patsubst %.Rmd, %.html ,$(wildcard *.Rmd))
INCLUDE_FILES := $(wildcard include/*.html)

all : html public/build

html : $(HTML_FILES)

%.html : %.Rmd $(INCLUDE_FILES)
	R --slave -e "set.seed(100);rmarkdown::render('$<')"

public/build : $(HTML_FILES) $(INCLUDE_FILES)
	mkdir -p public/
	cp *.html public/
	cp -r *_files public/
	cp -r libs public/
	cp -r screenshots public/
	touch public/build

.PHONY : packrat
packrat :
	R --slave -e "packrat::restore()"

.PHONY : clean
clean :
	rm -f $(HTML_FILES)
	rm -rf *_files/
	rm -rf public

