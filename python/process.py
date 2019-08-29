import argparse
import mimetypes
import os
import sys
import locale
import ghostscript
import pytesseract
import tabula


class PDFConverter:
    file_path = ''
    ghostscript_output_png_file_paths = []
    tesseract_output_pdf_file_path = ''
    tabula_output_csv_file = ''

    def __init__(self, pdf_file):
        self.file_path = os.path.relpath(
            "./files")+"/"+pdf_file
        self.check_pdf_mime_type()

    def check_pdf_mime_type(self):
        file_mime_type = mimetypes.MimeTypes().guess_type(self.file_path)[
            0]
        if file_mime_type == "application/pdf":
            print(file_mime_type)
        else:
            print("file is not a pdf type")
            exit(1)

    def check_pdf_text_layer(self):
        text_layer = True
        if text_layer:
            return True

    def ghostscript_process(self):
        args = [
            "-dNOPAUSE", "-dBATCH",
            "-sDEVICE=png16m",
            "-dGraphicsAlphaBits=4",
            "-dTextAlphaBits=4",
            "-r600",
            "-sOutputFile=" + "./files" + sys.argv[1] + ".page_%d.png",
            "-f",  sys.argv[2]
        ]

        # arguments have to be bytes, encode them
        encoding = locale.getpreferredencoding()
        args = [a.encode(encoding) for a in args]

        ghostscript.Ghostscript(*args)

    def tesseract_process(self):
        custom_oem_psm_config = r'--psm 6'
        pdf = pytesseract.image_to_pdf_or_hocr(
            'test.png',
            extension='pdf',
            config=custom_oem_psm_config
        )

    def tabula_process(self):
        tabula.convert_into_by_batch(
            "input_directory",
            output_path='',
            output_format='csv',
            pages='all',
            guess=True,
            spreadsheet=True,
            multiple_tables=True
        )


def main():
    parser = argparse.ArgumentParser(
        description="Convert tables in PDF files to CSV files.")

    parser.add_argument("pdf_file", nargs='?', default="example.pdf", type=str,
                        help="Path to config file produced by terraform")

    args = parser.parse_args()

    work = PDFConverter(args.pdf_file)
    if work.check_pdf_text_layer():
        print("start ghostscript process")
        work.ghostscript_process()
        print("start tesseract process")
        work.tesseract_process()
        print("start tabula process")
        work.tabula_process()


if __name__ == "__main__":
    main()
