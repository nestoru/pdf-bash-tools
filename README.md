pdf-bash-tools
==============

Some bash scripts that leverage on existing pdf tools. Script names should be self exaplanatory with the exception perhaps of pdfmark.sh which allows to change metadata in pdfs (example provided to add bookmarks).

Dependencies
============
xpdf and ghostscript. They are available for Linux, Unix, OS X and probably Windows. In MAC OS X you just:

    brew install xpdf
    brew install ghostscript
    
Installation
============
After installing dependencies just clone the project:

    git clone https://github.com/nestoru/pdf-bash-tools.git


Usage
=====
Enter the directory and run the scripts without params to confirm you get the help for each of them, for example:

    cd pdf-bash-tools/
    ./find_pdf_pages_containing_regex.sh 
    ./extract_pdf_pages.sh 
    ./extract_pdf_pages_containing_regex.sh 
    ./pdfmark.sh

Example 1
=========
Run the below commands and note how the original sample file has 5 names and cities. The name "Jorge" is repeated in two pages. As we pull only those pages that contain the name "Jorge" the result is a shorter file containing only 2 pages.

    rm -f  /tmp/names_and_cities_jorge.pdf
    ./extract_pdf_pages_containing_regex.sh samples/names_and_cities.pdf /tmp/names_and_cities_jorge.pdf "Jorge"
    open /tmp/names_and_cities_jorge.pdf 

Example 2
=========
Run the below commands and note how even though encrypted with password "test", we are still able to produce a final pdf file. If you want that file encrypted then just run gs with proper flags as you can see explained inside the extract_pdf_pages.sh script:

    rm -f  /tmp/names_and_cities_jorge.pdf
    ./extract_pdf_pages_containing_regex.sh samples/names_and_cities_encrypted.pdf /tmp/names_and_cities_jorge.pdf "Jorge" test
    open /tmp/names_and_cities_jorge.pdf 

Example 3
=========
Run the below commands and note how the resulting files (obtained from encrypted and not encrypted source pdf files) contain bookmarks. The echo lines basically build a pdfmark (http://partners.adobe.com/public/developer/en/acrobat/sdk/pdf/pdf_creation_apis_and_specs/pdfmarkReference.pdf) to insert bookmarks in the source pdf. I have also added a test for filenames containing spaces.

    rm -f  /tmp/names_and_cities_bookmarked.pdf
    rm -f  /tmp/names_and_cities_decrypted_and_bookmarked.pdf
    echo '[/PageMode /UseOutlines /DOCVIEW pdfmark' > /tmp/pdfmark
    echo '[ /Page 1 /Title (Nestor Urquiza) /OUT pdfmark' >> /tmp/pdfmark
    echo '[ /Page 2 /Title (Jorge Ruiz) /OUT pdfmark' >> /tmp/pdfmark
    echo '[ /Page 3 /Title (Mark Johnson) /OUT pdfmark' >> /tmp/pdfmark
    echo '[ /Page 4 /Title (Jorge Gacia) /OUT pdfmark' >> /tmp/pdfmark
    echo '[ /Page 5 /Title (Jristo Jristov) /OUT pdfmark' >> /tmp/pdfmark
    ./pdfmark.sh samples/names_and_cities.pdf /tmp/names_and_cities_bookmarked.pdf /tmp/pdfmark
    open /tmp/names_and_cities_bookmarked.pdf
    cp samples/names_and_cities.pdf "/tmp/names and cities.pdf"
    rm -f  "/tmp/names and cities bookmarked.pdf"
    ./pdfmark.sh "/tmp/names and cities.pdf" "/tmp/names and cities bookmarked.pdf" /tmp/pdfmark
    open "/tmp/names and cities bookmarked.pdf"
    ./pdfmark.sh samples/names_and_cities_encrypted.pdf /tmp/names_and_cities_decrypted_and_bookmarked.pdf /tmp/pdfmark test
    open /tmp/names_and_cities_decrypted_and_bookmarked.pdf 

Example 4
=========
Run the below:

    ./find_pdf_pages_containing_regex.sh --printmatch samples/names_and_cities.pdf "Jo[^ ]*"

Assert the result is the page and the exact match separated by comma:

    2,Jorge
    3,Johnson
    4,Jorge
    
Example 5
=========
Build your own example ;-) Just kidding. Look at the names_and_cities2.pdf file which includes an apostrophe in the name. Of course you will need to be careful with quotation and escaping. Try to go through the different examples above with the new file to find out the changes you will need. Yes this is homework, not kidding.

