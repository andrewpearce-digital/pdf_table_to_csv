# pdf_table_to_csv
capture tables in a pdf and output a csv.

## This project uses

[tesseract-ocr](https://github.com/tesseract-ocr/tesseract)
[tabula](https://github.com/tabulapdf/tabula-java)
[pdftools](https://github.com/ropensci/pdftools)
[ghostscript](https://www.ghostscript.com/)

## What does it do
Takes a file in files folder and triese process.sh script takes an s3 URL as input, which points to a pdf.
Image only pdfs are converted to images, run through tesseract OCR and then converted back into a pdf with an image and a text layer.
Pdfs with a text layer are run through tabula-java which guesses where tables are, and converts them to a csv file.

## How to use pdf_table_to_csv

###Build the container
```
docker build . --tag pdf_table_to_csv
```

###To Run

Put any files you want to process in a `./files` folder.
```
mkdir -p ./files 
# Copy PDF files to the files folder
docker run --rm -v ${PWD}/files:/files -u $(id -u ${USER}):$(id -g ${USER}) valveless/pdf_table_to_csv example.pdf
```

