FROM python:3.9-alpine

ENV VIRTUAL_ENV "/venv"
RUN python -m venv $VIRTUAL_ENV
ENV PATH "$VIRTUAL_ENV/bin:$PATH"

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y ffmpeg libmagic
RUN python -m pip install --upgrade pip

WORKDIR /metatube
RUN chmod 777 /metatube

COPY . .

RUN pip install -U -r requirements.txt

CMD ["bash", "x.sh"]
