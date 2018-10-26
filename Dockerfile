# Use an official Python runtime as a parent image
FROM alpine:3.7

# Set S3 bucket in environment variable
ENV BUCKET=s3://bucket/folder/

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install dependencies
RUN apk --no-cache add openjdk7-jre file python py-pip poppler-utils tesseract-ocr ghostscript \
    && pip install awscli \
    && apk --purge -v del py-pip \
    && mkdir java \
    && wget https://github.com/tabulapdf/tabula-java/releases/download/v1.0.2/tabula-1.0.2-jar-with-dependencies.jar \
    && mv tabula-1.0.2-jar-with-dependencies.jar java/tabula.jar

ENTRYPOINT [ "./process.sh" ]
