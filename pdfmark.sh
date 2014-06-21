#!/bin/bash -e
# /opt/scripts/pdfmark.sh
# @author: Nestor Urquiza
# @date: 20140501
# @description: Accepts a pdfmark file. See http://partners.adobe.com/public/developer/en/acrobat/sdk/pdf/pdf_creation_apis_and_specs/pdfmarkReference.pdf
#               Then it applies the metadata to the input pdf file generating the resulting output file

USAGE="Usage: `basename $0` <pdf_from_file> <pdf_to_file> <pdfmark_file> [password]"
 
if [ $# -lt "3" ] 
then
    echo $USAGE
    exit 1 
fi

pdf_from_file=$1
pdf_to_file=$2
pdfmark_file=$3
password=$4

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

gs $pdf_pwd_switch -dBATCH -dNOPAUSE -q -sOutputFile="$pdf_to_file" \
    -sDEVICE=pdfwrite "$pdf_from_file" "$pdfmark_file"
