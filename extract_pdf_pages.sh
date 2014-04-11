#!/bin/bash -e
# /opt/scripts/extract_pdf_pages.sh
# @author: Nestor Urquiza
# @date: 20140402
 
USAGE="Usage: `basename $0` <pdf_from_file> <pdf_to_file> <space_separated_page_numbers> [password]"
 
if [ $# -lt "3" ] 
then
    echo $USAGE
    exit 1 
fi

pdf_from_file=$1
pdf_to_file=$2
space_separated_page_numbers=$3
password=$4

pdf_merged_file=$(mktemp /tmp/pdf_merged_file.XXXXXXX).pdf
pdf_new_to_merge_file=$(mktemp /tmp/pdf_new_to_merge_file.XXXXXXX).pdf

if [ -z $password ]
then
    user_pwd_switch=""
    owner_pwd_switch=""
    pdf_pwd_switch=""
else
    user_pwd_switch="-sUserPassword=$password"
    owner_pwd_switch="-sOwnerPassword=$password"
    pdf_pwd_switch="-sPDFPassword=$password"
fi

for page in $space_separated_page_numbers ; do
    gs $pdf_pwd_switch -dBATCH -dNOPAUSE -q -sOutputFile=$pdf_new_to_merge_file  \
    -dFirstPage=$page -dLastPage=$page -sDEVICE=pdfwrite \
    "$pdf_from_file" 
    
    # Keep on merging to the output pdf if it exist
    if [ -f "$pdf_to_file" ]
    then
        # Merge into existing output file
        gs $pdf_pwd_switch -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite \
        -sOutputFile="$pdf_merged_file" "$pdf_to_file" "$pdf_new_to_merge_file"
        # Use the merged file as a new output file
        gs $owner_pwd_switch $user_pwd_switch -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=$pdf_to_file "$pdf_merged_file"
    else
        # Use the new to merge file as a new output file
        gs $owner_pwd_switch $user_pwd_switch -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=$pdf_to_file "$pdf_new_to_merge_file"
    fi
    # cleanup
    rm -f "$pdf_new_to_merge_file"
    rm -f "$pdf_merged_file"
done
