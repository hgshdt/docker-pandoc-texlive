# docker-pandoc-texlive

## Usage

### Build

```
$ docker build -t hgshdt/pandoc-texlive .
```

### Run 

#### Example: Convert Markdown to PDF

```
$ docker run -it --rm -v `pwd`:/workspace hgshdt/pandoc-texlive pandoc 01.md 02.md -f markdown -o output.pdf -V documentclass=ltjarticle -V classoption=a4paper -V geometry:margin=20mm -V CJKmainfont=IPAexGothic -V mainfont=IPAexGothic -V sansfont=IPAexGothic --pdf-engine=lualatex --template eisvogel.tex --listings --number-sections --toc --toc-depth=2 --filter plantuml.py
```

## Others

### Use Template 

Use pandoc-latex-template(Eisvogel).
Change `secnumdepth` from 3 to 5.

```
%
% TOC depth and 
% section numbering depth
%
\setcounter{tocdepth}{3}
$if(numbersections)$
%\setcounter{secnumdepth}{3}
\setcounter{secnumdepth}{5}
$endif$
```

### Example: Title YAML

```
---
title: TITLE
subtitle: SUBTITLE
date: "yyyy/mm/dd"
titlepage: "true"
titlepage-text-color: "000000"
titlepage-color: "efefef"
toc-own-page: "true"
...
```

### Exmple: PlantUML

```plantuml
Alice -> Bob: Authentication Request
Bob --> Alice: Authentication Response

Alice -> Bob: Another authentication Request
Alice <-- Bob: another authentication Response
```
