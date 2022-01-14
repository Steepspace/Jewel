#!/usr/bin/env bash

mkdir -p PDFsets

while IFS= read -r line; do
  file_name=$(basename $line)
  if [ ! -f PDFsets/$file_name ]
  then
      wget -O PDFsets/$file_name $line
      if [ $? -ne 0 ]
      then
          echo "ERROR in downloading $line"
          break
      fi
  fi
done < lhapdf_link.txt
