#!/bin/bash 

# Copyright (c) 2015 Audiowho <audiowho@audiowho.com>

# Permission  is  hereby granted, free of charge, to any person ob-
# taining a copy of  this  software  and  associated  documentation
# files  (the "Software"), to deal in the Software without restric-
# tion, including without limitation the rights to use, copy, modi-
# fy, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is  fur-
# nished to do so, subject to the following conditions:
#
# The  above  copyright  notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF  ANY  KIND,
# EXPRESS  OR  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE  AND  NONIN-
# FRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER  IN  AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN  THE
# SOFTWARE.

# Script para convertir un PDF a un fichero TEX eliminando los
# saltos de línea innecesarios. Además aplica correcciones a la
# puntuación y otras cosas.
#
# Para más información:
# https://github.com/Bigomby/audiowho-novelas

TEMP=temp.tex
OUTPUT=output.tex

# Se convierte el PDF a texto
pdftotext -nopgbrk $1 $TEMP

# Se eliminan posibles líneas en blanco
perl -p -i -e 's/^\s*$//g' $TEMP

# Se configura la primera línea cómo nombre del capítulo
read -r FIRSTLINE<$TEMP
sed -i "1s/.*/\\\chapter{$FIRSTLINE}/" $TEMP

# Se eliminan los saltos de líneas innecesarios.
perl -p -i -e 's/\.$/.\n\n/g' $TEMP
perl -p -i -e 's/\?$/?\n\n/g' $TEMP
perl -p -i -e 's/\!$/!\n\n/g' $TEMP
perl -00p -i -e 's/\n(?=.)/ /g' $TEMP

# Corrige el tamaño de la raya de diálogo
perl -p -i -e 's/-{1,2}/---/g' $TEMP
perl -p -i -e 's/–/---/g' $TEMP

# Corrige la posición de la raya de diálogo
perl -p -i -e 's/(?<=.)---(?!\.)/ ---/g' $TEMP
perl -p -i -e 's/\s---\s/ ---/g' $TEMP

# Se pasa a formato TEX
pandoc -o $OUTPUT $TEMP

# Limpieza
rm $TEMP