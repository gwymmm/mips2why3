# Install Latex

Install the whole package

    apt-get install texlive-full

Loads 5G of data but you don't have to install new packages all the time.

A Latex IDE is useful.

    apt-get install texmaker

# Compile Latex with Bibliography

Here the bibliography is in file bibli.bib and is declared in main.tex '\bibliography{bibli.bib}'.
Then compilation can be done as follows (main.tex is the Latex main file).

    pdflatex main.tex
    bibtex main
    pdflatex main.tex
    pdflatex main.tex
