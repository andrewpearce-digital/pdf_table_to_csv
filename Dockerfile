# Use an official Python runtime as a parent image
FROM alpine:3.7

# Set the working directory to /app
WORKDIR /app

# Install dependencies
RUN apk --no-cache add \
         msttcorefonts-installer \
         fontconfig \
         openjdk8-jre \
         file \ 
         python \
         poppler-utils \
         tesseract-ocr \
         ghostscript \
    && update-ms-fonts \
    && fc-cache -f 

RUN mkdir -p /opt \
    && wget https://github.com/tabulapdf/tabula-java/releases/download/v1.0.3/tabula-1.0.3-jar-with-dependencies.jar \
      --output-document /opt/tabula.jar

# Copy the scripts
COPY ./process.sh /app/

RUN mkdir /files
ENTRYPOINT [ "./process.sh" ]
