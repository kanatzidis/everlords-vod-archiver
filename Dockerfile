FROM ubuntu:18.04

RUN apt-get update && apt-get install -y ffmpeg awscli wget jq zsh curl

RUN mkdir -p /var/bin/everlords-archiver

ADD save-vod.sh /var/bin/everlords-archiver

WORKDIR /var/bin/everlords-archiver

RUN wget https://github.com/ArneVogel/concat/releases/download/v0.2.4/concat_ubuntu

CMD ["./save-vod.sh"]
