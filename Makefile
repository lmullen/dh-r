HTML_FILES := $(patsubst %.Rmd, public/%.html ,$(wildcard *.Rmd))
INCLUDE_FILES := $(wildcard include/*.html)
LIBS_FILES := $(wildcard libs/*)

all : public/build html

html : $(HTML_FILES)

public/%.html : %.Rmd $(INCLUDE_FILES)
	R --slave -e "set.seed(100);rmarkdown::render('$(<F)', output_dir = 'public')"

public/build : $(INCLUDE_FILES) $(LIBS_FILES)
	mkdir -p public/
	cp -r libs public/
	cp -r screenshots public/
	touch public/build

.PHONY : deploy
deploy :
	rsync --progress --delete -avz \
		--exclude='.git' \
		public/* reclaim:~/public_html/lincolnmullen.com/projects/dh-r/

.PHONY : clean
clean :
	rm -f $(HTML_FILES)
	rm -rf public/*

