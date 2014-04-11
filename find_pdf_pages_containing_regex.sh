#!/bin/bash -e
# /opt/scripts/find_pdf_pages_containing_regex.sh
# @author: Nestor Urquiza
# @date: 20140402
 
USAGE="Usage: `basename $0` <pdf_file> <regex> [password]"

if [ $# -lt "2" ] 
then
    echo $USAGE
    exit 1 
fi

pdf_file=$1
regex=$2
password=$3
if [ -z $password ] 
then
    pdfinfo_cmd=pdfinfo
    pdftotext_cmd=pdftotext
else
    pdfinfo_cmd="pdfinfo -upw $password"
    pdftotext_cmd="pdftotext -opw $password -upw $password"
fi
pages=$($pdfinfo_cmd "$pdf_file" | grep "Pages" | grep -o "[0-9][0-9]*")
for (( page=1; page<=$pages; page++ )); do
    matches=$($pdftotext_cmd -q -f $page -l $page "$pdf_file" - | grep "$regex" || true)
    if [ -n "$matches" ]; then
        echo $page
    fi
done
