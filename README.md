# pdf_table_to_csv
capture tables in a pdf and output a csv.

## This project uses

[tesseract-ocr](https://github.com/tesseract-ocr/tesseract)
[tabula](https://github.com/tabulapdf/tabula-java)
[pdftools](https://github.com/ropensci/pdftools)
[ghostscript](https://www.ghostscript.com/)

## What does it do
The process.sh script takes an s3 URL as input, which points to a pdf.

The pdf is checked to see if it is an image only or text pdf.

Image only pdfs are converted to images, run through tesseract OCR and then converted back into a pdf with an image and a text layer.

Pdfs with a text layer are run through tabula-java which guesses where tables are, and converts them to a csv file.

The final csv will be uploaded to an s3 bucket.
