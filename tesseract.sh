
echo "start tesseract process"
mkdir -p $1/png/
gs -dBATCH -dNOPAUSE -sDEVICE=png16m -dGraphicsAlphaBits=4 -dTextAlphaBits=4 -r600 -sOutputFile="$1/png/page_%d.png" "$2.pdf"
ls -d1 $1/png/* >> $1/tesseract_job.txt
tesseract $1/tesseract_job.txt $2 --psm 6 pdf
