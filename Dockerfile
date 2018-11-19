FROM ubuntu:18.04

RUN apt-get update -qq && apt-get upgrade -qq && \
    apt-get install -y wget && \
    wget -q https://github.com/jgm/pandoc/releases/download/2.4/pandoc-2.4-1-amd64.deb && \
    dpkg -i pandoc-2.4-1-amd64.deb && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y texlive-latex-recommended \
    texlive-lang-cjk texlive-lang-japanese texlive-fonts-extra texlive-luatex texlive-xetex && \
    apt-get clean

VOLUME /workspace
WORKDIR /workspace
