#!/bin/bash -e
# /opt/scripts/extract_pdf_pages_containing_regex.sh
# @author: Nestor Urquiza
# @date: 20140402

 
USAGE="Usage: `basename $0` <pdf_from_file> <pdf_to_file> <regex>"
 
if [ $# -ne "3" ] 
then
    echo $USAGE
    exit 1 
fi

pdf_from_file=$1
pdf_to_file=$2
regex=$3

dirname=`dirname $0`
pages=$($dirname/find_pdf_pages_containing_regex.sh $pdf_from_file "$regex" | tr "\n" " ")
$dirname/extract_pdf_pages.sh $pdf_from_file $pdf_to_file "$pages"
