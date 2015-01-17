#!/bin/bash

echo "**************************************************************************"
echo "*          Herramienta de construcción de novelas de AudioWho            *"
echo "**************************************************************************"
echo 

echo "Novelas disponibles"
echo "1. The Blood Cell"
echo
echo "Selecciona la novela a construir"

read novela

echo "Preparando novela..."
mkdir -p build
cd novelas
cd the-blood-cell
mkdir -p build
cp ../../tools/Makefile .
cp ../../tools/style.css .
cp ../../tools/base.tex build/base.tex


# Se obtienen los metadatos del archivo JSON "metadata.json"
echo "Leyendo datos de la novela..."

title=$(cat metadata.json | jq '.title')
temp="${title%\"}"
temp="${temp#\"}"
title=$temp

author=$(cat metadata.json | jq '.author')
temp="${author%\"}"
temp="${temp#\"}"
author=$temp

publisher=$(cat metadata.json | jq '.publisher')
temp="${publisher%\"}"
temp="${temp#\"}"
publisher=$temp

date=$(cat metadata.json | jq '.date')
temp="${date%\"}"
temp="${temp#\"}"
date=$temp

isbn=$(cat metadata.json | jq '.isbn')
temp="${isbn%\"}"
temp="${temp#\"}"
isbn=$temp

cover="images/cover.jpg"

echo 
echo "Datos de la novela a construir:"
echo 
echo "TÍTULO:	$title"
echo "AUTOR:	$author"
echo "ISBN:	$isbn"
echo "FECHA:	$date"

echo 
echo "Configurando los metadatos de la novela..."

# Se sustituyen los valores obtenidos en el fichero para la construcción
sed -i "s/%%TITLE%%/$title/g" build/base.tex
sed -i "s/%%AUTHOR%%/$author/g" build/base.tex
sed -i "s/%%PUBLISHER%%/$publisher/g" build/base.tex
sed -i "s:%%DATE%%:11/9/2014:g" build/base.tex

# Se convierte la portada a PDF
echo "Generando portada..."
convert images/cover.jpg images/cover.pdf

# Construcción del PDF
echo "Construyendo PDF..."
make pdf >/dev/null
mv build/base.pdf "../../build/$title.pdf"

# Construcción del ePub
echo "Construyendo epub..."
make epub >/dev/null
echo "Configurando metadatos del ePub y aplicando estilo..."
ebook-convert build/base.epub build/base2.epub --title "$title" --authors "$author" --publisher "$publisher" --isbn $isbn --pubdate $date --extra-css=style.css --pretty-print --epub-inline-toc --toc-title="$title" >/dev/null
echo "Optimizando ePub..."
ebook-polish build/base2.epub ../../build/"$title.epub" -c $cover -p --verbose -f -j -u >/dev/null

echo "Limpiando..."
make clean >/dev/null
rm Makefile >/dev/null
echo "¡Terminado!"
echo