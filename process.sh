#! /bin/sh

cd /files

# No parameters
if [ $# -lt 1 ]
then echo -e "No PDF or image provided. "
    exit 1
fi

# Check it's a PDF
type="$(file --mime-type  -b "$1")"

if [ $type != 'application/pdf' ]; then
    echo -e "file not a pdf"
    exit 1
fi

# Setup workspace
# OCR Image PDF
echo "Check for fonts"
if pdffonts $1 | grep yes; then
  echo -e "\n\n-----start ghostscript process"
  gs -dBATCH -dNOPAUSE -sDEVICE=png16m -dGraphicsAlphaBits=4 -dTextAlphaBits=4 -r600 -sOutputFile="$1.page_%d.png" "$1"
  ls -d1 *.png > tesseract_job.txt
  echo -e "\n\n-----start tesseract process"
  tesseract tesseract_job.txt $1.new --psm 6 pdf
  
fi

# Extract table data to csv
echo -e "\n\n-----start tabula"
java -jar /opt/tabula.jar $1.new.pdf --outfile "$1".csv --pages all --guess

