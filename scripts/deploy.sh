#!/bin/sh

rsync --checksum --delete --omit-dir-times --itemize-changes -avz \
  _book/* \
  reclaim:~/public_html/dh-r.lincolnmullen.com/ \
  | egrep -v '^\.'
