#!/bin/sh

rsync --checksum --delete -avz _book/* reclaim:~/public_html/dh-r/ \
	--exclude Mullen-ComputationalHistoricalThinking.pdf \
	--exclude Mullen-ComputationalHistoricalThinking.epub \
	--exclude Mullen-ComputationalHistoricalThinking.mobi
