# A Makefile to re-project and simplify shapefiles.

SIMPLIFY_PERCENTAGE := 2.5
REPROJECTION_CODE   := EPSG:4326

SIMPLIFIED  := $(patsubst shp/%.shp, shp_out/%.shp, $(wildcard shp/*.shp))
REPROJECTED := $(patsubst shp/%.shp, temp/%.shp, $(wildcard shp/*.shp))

all : $(SIMPLIFIED)
.SECONDARY : $(REPROJECTED)

shp_out/%.shp : temp/%.shp
	@echo "Simplifying $*"
	mkdir -p shp_out
	mapshaper $^ auto-snap -simplify $(SIMPLIFY_PERCENTAGE)% -o force $@

temp/%.shp : shp/%.shp
	@echo "Reprojecting $*"
	mkdir -p temp
	ogr2ogr -t_srs $(REPROJECTION_CODE) $@ $^

clean :
	rm -f temp/*

clobber : clean
	rm -f shp_out/*
