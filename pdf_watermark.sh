#!/bin/bash -e
# /opt/scripts/pdf_watermark.sh
# @author: Nestor Urquiza
# @date: 20180323
# @description: Creates a temporary pdfmark and merges it with the input pdf to produce a watermark with a custom text
#

USAGE="Usage: `basename $0` <pdf_from_file> <pdf_to_file> <watermark> [password]"
 
if [ $# -lt "3" ] 
then
    echo $USAGE
    exit 1 
fi

pdf_from_file=$1
pdf_to_file=$2
watermark=$3
password=$4

#tmpfile=$(mktemp /tmp/pdf_watermark.XXXXXX)
tmpfile=mark.ps

font="/Helvetica-Bold 72 selectfont"
color=".75 setgray"
angle=45


! read -d '' pdf_mark <<EOF
<<
   /EndPage
   {
     2 eq { pop false }
     {
         gsave      
         /Helvetica 18 selectfont
         .85 setgray 130 70 moveto 50 rotate (${watermark}) show
         grestore
         true
     } ifelse
   } bind
>> setpagedevice
EOF

echo  "$pdf_mark" > "$tmpfile" 

./pdfmark.sh "$pdf_from_file" "$pdf_to_file" "$tmpfile" "$password"
rm "$tmpfile"
