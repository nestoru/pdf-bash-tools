pdf-bash-tools
==============

Some bash scripts that leverage on existing pdf tools. Script names should be self exaplanatory.

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

Example
=======
Run the below commands and note how the original sample file has 5 names and cities. The name "Jorge" is repeated in two pages. As we pull only those pages that contain the name "Jorge" the result is a shorter file containing only 2 pages.

    open /tmp/names_and_cities_jorge.pdf 
    ./extract_pdf_pages_containing_regex.sh samples/names_and_cities.pdf /tmp/names_and_cities_jorge.pdf "Jorge"
    open /tmp/names_and_cities_jorge.pdf 



