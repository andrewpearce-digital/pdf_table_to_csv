# Use an official Python runtime as a parent image
FROM alpine:3.7

# Set S3 bucket in environment variable
ENV BUCKET=s3://bucket/folder/

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install aws-cli and java (yuck!)
RUN apk --no-cache add openjdk7-jre file python py-pip poppler-utils tesseract-ocr ghostscript \
    && pip install awscli \
    && apk --purge -v del py-pip

ENTRYPOINT [ "./process.sh" ]
