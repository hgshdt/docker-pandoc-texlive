FROM ubuntu:18.04

RUN apt-get update -qq \
    && apt-get upgrade -qq \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y texlive-latex-recommended \
        texlive-lang-cjk texlive-lang-japanese texlive-fonts-extra texlive-luatex texlive-xetex \
        wget curl default-jre python3-dev python3-pip graphviz locales librsvg2-bin unzip fonts-noto-cjk \
    && apt-get clean

RUN wget -q https://github.com/googlefonts/spacemono/archive/f5ebc1e1c0.zip -O spacemono.zip \
    && unzip spacemono.zip \
    && rm spacemono.zip \
    && mkdir -p /root/.fonts/ \
    && cp spacemono-f5ebc1e1c0/fonts/SpaceMono-Regular.ttf /root/.fonts/ \
    && fc-cache -fv

RUN echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen
ENV LANG=ja_JP.UTF-8

ARG PANDOC_VER="2.7.2"
RUN wget --no-check-certificate https://github.com/jgm/pandoc/releases/download/${PANDOC_VER}/pandoc-${PANDOC_VER}-1-amd64.deb -O ./pandoc-${PANDOC_VER}-1-amd64.deb
RUN dpkg -i pandoc-${PANDOC_VER}-1-amd64.deb
RUN pip3 install pandocfilters

ARG EISVOGEL_VER="1.2.2"
RUN wget --no-check-certificate https://github.com/Wandmalfarbe/pandoc-latex-template/releases/download/v${EISVOGEL_VER}/Eisvogel-${EISVOGEL_VER}.zip -O ./Eisvogel-${EISVOGEL_VER}.zip
RUN unzip Eisvogel-${EISVOGEL_VER}.zip
RUN mkdir -p /root/.pandoc/templates \
    && cp eisvogel.tex /root/.pandoc/templates/

COPY plantuml/plantuml.py /usr/local/bin/

ARG PLANTUML_VER="1.2019.5"
RUN curl -sSL http://sourceforge.net/projects/plantuml/files/plantuml.${PLANTUML_VER}.jar/download > /usr/local/bin/plantuml.jar \
    && chmod +x /usr/local/bin/plantuml.py

VOLUME /workspace
WORKDIR /workspace
