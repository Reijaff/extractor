FROM cincan/binwalk

USER root

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget python3-pip git build-essential liblzma-dev liblzo2-dev zlib1g-dev unrar-free

RUN python3 -m pip install python-magic


RUN adduser --disabled-password --gecos '' --home /home/extractor extractor

WORKDIR /home/extractor

RUN git clone https://gitlab.com/reijaff/extractor.git
RUN ln -s /home/extractor/extractor/extractor.py /usr/bin/extractor

ENTRYPOINT ["extractor"]
