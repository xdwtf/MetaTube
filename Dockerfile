FROM python:3.9-alpine

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

FFMPEG=/usr/bin

RUN \
    apk update && \
    apk add --no-cache python3-dev libffi-dev gcc musl-dev make ffmpeg libmagic && \
    mkdir -p /config && \
    pip3 install -r /config/requirements.txt && \
    apk del --purge python3-dev libffi-dev gcc musl-dev make && \
    mkdir -p $DOWNLOADS

COPY . .
#ENTRYPOINT ["/usr/local/bin/python3", "config/metatube.py"]

RUN chmod +x start.sh
CMD ./start.sh
