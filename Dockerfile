FROM python:3.9.1-buster

ENV VIRTUAL_ENV "/venv"
RUN python -m venv $VIRTUAL_ENV
ENV PATH "$VIRTUAL_ENV/bin:$PATH"

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y ffmpeg libmagic1
RUN python -m pip install --upgrade pip

COPY requirements.txt /requirements.txt
RUN cd /
RUN pip3 install -U -r requirements.txt

WORKDIR /metatube
RUN chmod 777 /metatube

COPY x.sh /x.sh

CMD ["bash", "/x.sh"]
