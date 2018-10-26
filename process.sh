#! /bin/sh

if [ $# -lt 1 ]
then echo -e "No PDF or image provided. "
    exit 1
fi

# Download file from s3
object=${1##*/}
aws s3 cp $1 $object

type="$(file --mime-type  -b "$object")"

if [ $type != 'application/pdf' ]; then
    echo -e "file not a pdf"
    rm $object
    exit 1
fi

# Setup variables
y=${object%.*}
filename=${y##*/}
unique_id=$(md5sum "$object" | awk '{ print $1 }')

# Setup workspace
mkdir -p run
mkdir -p run/$unique_id
mv $object run/$unique_id/$object

# OCR Image PDF
if pdffonts run/$unique_id/$object | grep yes; then
    ./tesseract.sh run/$unique_id run/$unique_id/$filename
fi

# Extract table data to csv
java -jar java/tabula-1.0.2-jar-with-dependencies.jar run/$unique_id/$object -o run/$unique_id/"$filename".csv -p all -g

# Push file to S3
aws s3 cp run/$unique_id/"$filename".csv $BUCKET"$filename".csv

# clean up
rm -rf run/$unique_id/
