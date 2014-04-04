#!/bin/bash -e
# /opt/scripts/extract_pdf_pages.sh
# @author: Nestor Urquiza
# @date: 20140402
 
USAGE="Usage: `basename $0` <pdf_from_file> <pdf_to_file> <space_separated_page_numbers>"
 
if [ $# -ne "3" ] 
then
    echo $USAGE
    exit 1 
fi

pdf_from_file=$1
pdf_to_file=$2
space_separated_page_numbers=$3

pdf_merged_file=$(mktemp /tmp/pdf_merged_file.XXXXXXX)
touch "$pdf_to_file"

for page in $space_separated_page_numbers ; do
    gs -dBATCH -dNOPAUSE -q -sOutputFile=-  \
    -dFirstPage=$page -dLastPage=$page -sDEVICE=pdfwrite \
    $pdf_from_file \
    | gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite \
    -sOutputFile="$pdf_merged_file" "$pdf_to_file" - \
    && mv "$pdf_merged_file" "$pdf_to_file"

done
