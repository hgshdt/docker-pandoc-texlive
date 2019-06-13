# docker-pandoc-texlive

[![badge](https://images.microbadger.com/badges/image/hideto1976/docker-pandoc-texlive.svg)](https://microbadger.com/images/hideto1976/docker-pandoc-texlive "Get your own image badge on microbadger.com")

## Usage

### Build

`$ docker build -t hgshdt/docker-pandoc-texlive .`

### Run

#### Example: Convert Markdown to PDF

```sh
$ docker run -it --rm -v `pwd`:/workspace hgshdt/docker-pandoc-texlive pandoc 01.md 02.md -f markdown -o output.pdf -V documentclass=ltjarticle -V classoption=a4paper -V geometry:margin=20mm -V CJKmainfont=IPAexGothic -V mainfont=IPAexGothic -V sansfont=IPAexGothic --pdf-engine=lualatex --template eisvogel.tex --listings --number-sections --toc --toc-depth=2 --filter plantuml.py
Created directory plantuml-images
...
```

```sh
$ docker run -it --rm -v `pwd`:/workspace hgshdt/docker-pandoc-texlive pandoc README.md -f markdown -o output.pdf -V documentclass=ltjarticle -V classoption=a4paper -V geometry:margin=20mm -V CJKmainfont='Noto Sans CJK JP Regular' -V mainfont='Noto Sans CJK JP Regular' -V sansfont='Noto Sans CJK JP Regular' -V monofont='Lucida Console' --pdf-engine=lualatex --template eisvogel.tex --listings --number-sections --toc --toc-depth=2 --filter plantuml.py
Created directory plantuml-images
...
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
