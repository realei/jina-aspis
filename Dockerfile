# Use an official Python runtime as a parent image
#FROM python:3.7.6-alpine
FROM openblog:python3.7.6-base
LABEL maintainer="wanglei.okay@gmail.com"

# set work directory
WORKDIR /usr/src/openblog/

# Set environment varibles
# Prevents Python from writing pyc files to disc (python3 -B)
ENV PYTHONDONTWRITEBYTECODE 1
# Prevents Python from buffering stdout and stderr (python3 -u)
ENV PYTHONUNBUFFERED 1

COPY . /usr/src/openblog/

# install psycopg2 dependencies
#RUN apk update \
#    && apk add postgresql-dev gcc python3-dev musl-dev

# install Pillow
#RUN apk add --no-cache jpeg-dev zlib-dev
#RUN apk add --no-cache --virtual .build-deps build-base linux-headers \
#    && pip install Pillow

RUN pip install --upgrade pip
# Install any needed packages specified in requirements.txt
RUN pip install -r ./requirements.txt
RUN pip install gunicorn

# create the openblog user
RUN addgroup -S openblog && adduser -S openblog -G openblog
RUN chown -R openblog:openblog /usr/src/openblog/ 
#USER openblog

# run entrypoint.sh
ENTRYPOINT ["/usr/src/openblog/entrypoint.sh"]

