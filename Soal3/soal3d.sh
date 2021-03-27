#!/bin/bash

d=$(date  "+%m%d%Y")

zip -m -P $d -r Koleksi.zip . -i "*.jpg" "*.log"
rm -d \Kucing*
rm -d \Kelinci*
