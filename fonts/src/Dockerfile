FROM ubuntu:18.04

WORKDIR /mnt

RUN apt-get update && apt-get install -y python-fontforge fontforge

COPY icons icons
COPY generate.py generate.py
RUN python generate.py

CMD cp icons.ttf /fonts/icons.ttf
