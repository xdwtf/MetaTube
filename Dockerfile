FROM python:3.9-alpine

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

COPY . .
RUN \
    apk update && \
    apk add --no-cache python3-dev libffi-dev gcc musl-dev make ffmpeg libmagic && \
    pip3 install -r requirements.txt && \
    apk del --purge python3-dev libffi-dev gcc musl-dev make && \


#ENTRYPOINT ["/usr/local/bin/python3", "config/metatube.py"]

RUN chmod +x start.sh
CMD ./start.sh
