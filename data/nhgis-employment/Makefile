TOPOJSON    := $(patsubst shp/%.shp, out/%.shp, $(wildcard shp/*.shp))
REPROJECTED := $(patsubst shp/%.shp, temp/%.shp, $(wildcard shp/*.shp))

all : $(TOPOJSON)
.SECONDARY : $(REPROJECTED)

out/%.shp : temp/%.shp
	mkdir -p out
	mapshaper $^ auto-snap -simplify 1.0% -o force $@

temp/%.shp : shp/%.shp
	mkdir -p temp
	ogr2ogr -t_srs EPSG:4326 $@ $^

clobber : 
	rm -f temp/*
	rm -f out/*
