# docker-pandoc-texlive

## Usage

### Build

```sh
$ docker build -t docker-pandoc-texlive .
```

### GitHub Container Registry

#### Push image

```sh
$ echo $CR_PAT | docker login ghcr.io -u hgshdt --password-stdin
$ docker tag docker-pandoc-texlive ghcr.io/hgshdt/docker-pandoc-texlive
$ docker push ghcr.io/hgshdt/docker-pandoc-texlive
```

#### Pull image

```sh
$ docker pull ghcr.io/hgshdt/docker-pandoc-texlive
```

### Run

#### Example: Convert Markdown to PDF

```sh
$ docker run -it --rm -v `pwd`:/workspace \
ghcr.io/hgshdt/docker-pandoc-texlive \
pandoc \
README.md \
-f markdown \
-o output.pdf \
-V documentclass=ltjarticle \
-V classoption=a4paper \
-V geometry:margin=20mm \
-V CJKmainfont='Noto Sans CJK JP Regular' \
-V mainfont='Noto Sans CJK JP Regular' \
-V sansfont='Noto Sans CJK JP Regular' \
-V monofont='Lucida Console' \
--pdf-engine=lualatex \
--template eisvogel.tex \
--listings \
--number-sections \
--toc \
--toc-depth=2 \
--filter plantuml.py
```

## Others

### Example: Title YAML

```yaml
---
title: TITLE
subtitle: SUBTITLE
date: "yyyy/mm/dd"
titlepage: false
titlepage-text-color: "000000"
titlepage-color: "efefef"
toc-own-page: false
...
```

### Exmple: PlantUML

```plantuml
Alice -> Bob: Authentication Request
Bob --> Alice: Authentication Response

Alice -> Bob: Another authentication Request
Alice <-- Bob: another authentication Response
```
