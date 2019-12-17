FROM ubuntu:18.04

LABEL name="Hideto Higashi <higashi.hideto@gmail.com>" \
      version="0.1"

#RUN  echo "$HTTP_PROXY, $HTTPS_PROXY"

RUN apt-get update -qq \
    && apt-get upgrade -qq \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y texlive-latex-recommended \
        texlive-lang-cjk texlive-lang-japanese texlive-fonts-extra texlive-luatex texlive-xetex \
        wget curl default-jre python3-dev python3-pip graphviz locales librsvg2-bin unzip fonts-noto-cjk \
    && apt-get clean

RUN mkdir -p /root/.fonts/
COPY fonts/LUCON.TTF /root/.fonts/
RUN fc-cache -fv

RUN echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen
ENV LANG=ja_JP.UTF-8

ARG PANDOC_VER="2.9"
RUN wget --no-check-certificate https://github.com/jgm/pandoc/releases/download/${PANDOC_VER}/pandoc-${PANDOC_VER}-1-amd64.deb -O ./pandoc-${PANDOC_VER}-1-amd64.deb
RUN dpkg -i pandoc-${PANDOC_VER}-1-amd64.deb
RUN pip3 install pandocfilters

ARG EISVOGEL_VER="1.3.1"
RUN wget --no-check-certificate https://github.com/Wandmalfarbe/pandoc-latex-template/releases/download/v${EISVOGEL_VER}/Eisvogel-${EISVOGEL_VER}.zip -O ./Eisvogel-${EISVOGEL_VER}.zip
RUN unzip Eisvogel-${EISVOGEL_VER}.zip
RUN mkdir -p /root/.pandoc/templates \
    && cp eisvogel.tex /root/.pandoc/templates/

COPY plantuml/plantuml.py /usr/local/bin/

ARG PLANTUML_VER="1.2019.13"
RUN curl -sSL http://sourceforge.net/projects/plantuml/files/plantuml.${PLANTUML_VER}.jar/download > /usr/local/bin/plantuml.jar \
    && chmod +x /usr/local/bin/plantuml.py

VOLUME /workspace
WORKDIR /workspace
