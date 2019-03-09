FROM ubuntu:18.04

RUN apt-get update -qq \
    && apt-get upgrade -qq \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y texlive-latex-recommended \
        texlive-lang-cjk texlive-lang-japanese texlive-fonts-extra texlive-luatex texlive-xetex \
        wget curl default-jre python3-dev python3-pip graphviz locales librsvg2-bin \
    && apt-get clean

RUN echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen
ENV LANG=ja_JP.UTF-8

ARG PANDOC_VER="2.7"
RUN wget --no-check-certificate https://github.com/jgm/pandoc/releases/download/${PANDOC_VER}/pandoc-${PANDOC_VER}-1-amd64.deb -O ./pandoc-${PANDOC_VER}-1-amd64.deb
RUN dpkg -i pandoc-${PANDOC_VER}-1-amd64.deb
RUN pip3 install pandocfilters

COPY pandoc-latex-template/eisvogel.tex /root/.pandoc/templates/
COPY plantuml/plantuml.py /usr/local/bin/

ARG PLANTUML_VER="1.2019.1"
RUN curl -sSL http://sourceforge.net/projects/plantuml/files/plantuml.${PLANTUML_VER}.jar/download > /usr/local/bin/plantuml.jar \
    && chmod +x /usr/local/bin/plantuml.py

VOLUME /workspace
WORKDIR /workspace
