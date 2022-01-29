FROM python:3.9-alpine

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

RUN apk add --update ffmpeg && \
    apk add --update --virtual .build-deps python3-dev libffi-dev gcc musl-dev make libmagic && \
    pip3 install -r requirements.txt && \
    apk del --purge python3-dev libffi-dev gcc musl-dev make

COPY . .
#ENTRYPOINT ["/usr/local/bin/python3", "config/metatube.py"]

RUN chmod +x x.sh
CMD ./x.sh
