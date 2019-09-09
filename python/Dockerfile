# Use an official Python runtime as a parent image
FROM python:3.7-alpine
# FROM alpine:3.7

# Set the working directory to /app
WORKDIR /app

# Install dependencies
RUN apk --no-cache add \
  msttcorefonts-installer \
  fontconfig \
  openjdk8-jre \
  file \ 
  poppler-utils \
  zlib-dev \
  ghostscript-dev \
  jpeg-dev \
  gcc \
  g++ \
  tesseract-ocr \
  ghostscript \
  && rm -rf /var/cache/apk/* \
  && update-ms-fonts \
  && fc-cache -f 


RUN mkdir -p /opt \
  && wget https://github.com/tabulapdf/tabula-java/releases/download/v1.0.3/tabula-1.0.3-jar-with-dependencies.jar \
  --output-document /opt/tabula.jar

RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

# Install python dependencies
COPY ./python/requirements.txt /app/
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

RUN cp /usr/lib/libgs.so.9 /usr/lib/libga.so

# Copy the scripts
COPY ./python/process.py /app/

RUN mkdir /files
# ENTRYPOINT [ "./process.py" ]
