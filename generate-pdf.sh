#!/bin/bash

cd _pdf || exit

ruby generate_latex.rb

# Remove existing output._pdf file and compile LaTeX to generate new output._pdf
rm -f normanholz-cv.pdf


# Compile LaTeX twice to ensure all references and citations are resolved
for i in {1..2}; do
    pdflatex output.tex
done



mv ./output.pdf ../assets/pdf/normanholz-cv.pdf

# Remove any remaining files with the name "output."
rm -f ./output.*
