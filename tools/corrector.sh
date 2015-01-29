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

# Script para corregir errores en los textos de las novelas.
#
# Para más información:
# https://github.com/Bigomby/audiowho-novelas

TEMP=temp
OUTPUT=$2
FLAG=false
MARK=false

error()
{
	rm $TEMP 2>/dev/null
	exit 1
}

usage()
{

cat << EOF
Uso: $0 <input> <output> [OPCIONES]

Este script se usa corregir las novelas de Audiowho.

OPCIONES:
   -h      Configura la primera línea como título de capítulo.
   -l      Arregla los saltos de línea innecesarios (usar con cuidado).
   -d      Arrela las rayas (BETA).
   -m      Marca las correcciones de la raya en color amarillo (HTML/MD)
   -b      Configura las líneas en blanco como espacios en blanco.

Ejemplo: $0 input.tex -h -l -d -b
EOF

}

# Configura la primera línea del fichero como título de capítulo
header()
{
	read -r FIRSTLINE<$TEMP
	sed -i "1s/.*/\\\chapter*{$FIRSTLINE}\n\\\addcontentsline{toc}{chapter}{$FIRSTLINE}\n/" $TEMP
}

# Corrige los saltos de línea innecesarios
breaklines()
{
	perl -p -i -e 's/\.$/.\n\n/g' $TEMP
	perl -p -i -e 's/\?$/?\n\n/g' $TEMP
	perl -p -i -e 's/\!$/!\n\n/g' $TEMP
	perl -00p -i -e 's/\n(?=.)/ /g' $TEMP
}

# Corrige la posición de la raya de diálogo
dashs()
{
	# Arregla los carácteres erróneos
	perl -p -i -e 's/---/|/g' $TEMP
	perl -p -i -e 's/--/|/g' $TEMP
	perl -p -i -e 's/—/|/g' $TEMP

	perl -p -i -e 's/\|/---/g' $TEMP

	# Arregla cuando la primera raya va precedida de un espacio
	if [ "$MARK" = true ]; then
		perl -p -i -e 's/(?<=^)---\s/<span style="background-color:rgb(255, 120, 120);">---<\/span>/g' $TEMP
	else
		perl -p -i -e 's/(?<=^)---\s/---/g' $TEMP
	fi

	# Para corregir la raya de apertura
	if [ "$MARK" = true ]; then
		perl -p -i -e 's/(?<!^)\s*---\s*(?![\.,;])/<span style="background-color:rgb(255, 120, 120);"> ---<\/span>/g' $TEMP
	else
		perl -p -i -e 's/(?<!^)\s*---\s*(?![\.,;])/ ---/g' $TEMP
	fi

	# Para corregir la raya de cierre
	if [ "$MARK" = true ]; then
		perl -p -i -e 's/(?<!^)\s*---\s*(?=[\.,;])/<span style="background-color:rgb(255, 120, 120);">---<\/span>/g' $TEMP
	else
		perl -p -i -e 's/(?<!^)\s*---\s*(?=[\.,;])/---/g' $TEMP
	fi
}

blanklines()
{
	perl -p -i -e 's/^~$/\\mbox{}/g' $TEMP
}

# Comprobamos el fichero de entrada
if [ ! -f $1 ] || [ -z "$1" ]; then
	usage
	error
fi

# Comprobamos el fichero de salida
if [ -z "$2" ]; then
	usage
	error
fi

# Operamos sobre un fichero temporal
cat $1 > $TEMP

shift 2

# Parseamos los parámetros
while getopts "mhldb" OPTION
do
	case $OPTION in
		m)
			MARK=true
			;;
		h)
			FLAG=true
			header
			;;
		l)
			FLAG=true
			breaklines
			;;
		d)
			FLAG=true
			dashs
			;;
		b)
			FLAG=true
			blanklines
			;;	
	esac
done

if [ "$FLAG" = false ]; then
	echo $FLAG
	usage
	error
fi

cat $TEMP > $OUTPUT
rm $TEMP