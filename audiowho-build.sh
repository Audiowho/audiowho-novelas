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

# Script que genera automáticamente las novelas editadas en PDF y/o 
# en ePub. Las novelas deben estar organizadas correctamente para
# poder ser construídas.
#
# Para más información:
# https://github.com/Bigomby/audiowho-novelas

ALL=false
VERBOSE=0
PDF=0
EPUB=0
NOVELA=
NOVELAFLAG=false
DIR=
NOVELABASENAME=
BUILD=

usage()
{

cat << EOF
Uso: $0 OPCIONES

Este script se usa para generar las novelas traducidas por AudioWho.

OPCIONES:
   -h      Muestra la ayuda
   -p      Genera un PDF
   -e      Genera un ePub
   -d      Directorio de la novela a construir
   -l      Lista las novelas de un directorio
   -a      Genera todas las novelas de un directorio
   -v      Modo verbose

Ejemplo: $0 -v -p -e -d novelas/titulo-de-la-novela
EOF

}

# Genera la novela en formato PDF

pdf()
{
	echo -e "\e[1mGenerando PDF...\e[0m"

	if [ $VERBOSE -eq 1 ]
		then
			(cd $BUILD ; pdflatex base.tex)
			(cd $BUILD ; pdflatex base.tex)
		else
			(cd $BUILD ; pdflatex -halt-on-error base.tex) >/dev/null
			(cd $BUILD ; pdflatex -halt-on-error base.tex) >/dev/null

			if [ $? -eq 1 ]
				then
					echo -e "\e[91mError generando PDF.\e[0m"
					exit 1
			fi
	fi

	mv $BUILD/base.pdf "$BUILD/$title.pdf"

	(cd $BUILD ;
		rm *.aux >/dev/null
		rm *.out >/dev/null
		rm *.log >/dev/null
		rm *.toc >/dev/null		
	)
}

 
# Genera la novela en formato ePub

epub()
{
	cp tools/style.css $BUILD/

	echo -e "\e[1mGenerando ePub...\e[0m"
	(cd $BUILD ; pandoc base.tex -o base.epub)

	echo -e "\e[1mConfigurando metadatos del ePub y aplicando estilo...\e[0m"
	if [ $VERBOSE -eq 1 ]
		then
			(cd $BUILD ; ebook-convert base.epub base2.epub --title "$title" --authors "$author" --publisher "$publisher" \
				--isbn $isbn --pubdate $date --extra-css=style.css --pretty-print --epub-inline-toc --toc-title="$title")
		else
			(cd $BUILD ; ebook-convert base.epub base2.epub --title "$title" --authors "$author" --publisher "$publisher" \
				--isbn $isbn --pubdate $date --extra-css=style.css --pretty-print --epub-inline-toc --toc-title="$title") >/dev/null
	fi

	echo -e "\e[1mOptimizando ePub...\e[0m"
	if [ $VERBOSE -eq 1 ]
		then
			(cd $BUILD ; ebook-polish base2.epub "$title.epub" -c images/cover.jpg -p --verbose -f -j -u)
		else
			(cd $BUILD ; ebook-polish base2.epub "$title.epub" -c images/cover.jpg -p --verbose -f -j -u) > /dev/null
	fi

	if [ $? -eq 1 ]
		then
			echo -e "\e[91mError generando ePub.\e[0m"
			exit 1
	fi

	(cd $BUILD ;
		rm base.epub >/dev/null
		rm base2.epub >/dev/null
	)
}

 
# Parsea los metadatos de la novela 

parse()
{
	title=$(cat $BUILD/metadata.json | jq '.title')
	temp="${title%\"}"
	temp="${temp#\"}"
	title=$temp

	author=$(cat $BUILD/metadata.json | jq '.author')
	temp="${author%\"}"
	temp="${temp#\"}"
	author=$temp

	publisher=$(cat $BUILD/metadata.json | jq '.publisher')
	temp="${publisher%\"}"
	temp="${temp#\"}"
	publisher=$temp

	date=$(cat $BUILD/metadata.json | jq '.date')
	temp="${date%\"}"
	temp="${temp#\"}"
	date=$temp

	isbn=$(cat $BUILD/metadata.json | jq '.isbn')
	temp="${isbn%\"}"
	temp="${temp#\"}"
	isbn=$temp
}

# Comprueba que existe la novela

check()
{
	
	if [ ! -f $NOVELA/metadata.json ]
		then
			echo -e "\e[91mNo existe el fichero \"metadata.json\" para la novela o no existe la novela.\e[0m"
			exit 1
	fi

	mkdir -p $BUILD

	cp -r $NOVELA/* $BUILD
	if [ $? -eq 1 ]
		then
			echo -e "\e[91mError al intentar leer los datos de la carpeta $NOVELA.\e[0m"
	fi

	cp -r tools/* $BUILD
	if [ $? -eq 1 ]
		then
			echo -e "\e[91mError al intentar leer los datos de la carpeta \"tools\".\e[0m"
	fi
}

# Limpia los ficheros inútiles resultantes del proceso

clean()
{
	echo -e "\e[1mLimpiando...\e[0m"
	(cd $BUILD ;
		rm metadata.json >/dev/null
		rm style.css >/dev/null
		rm *.tex >/dev/null
		rm -r images >/dev/null
		rm -r docs >/dev/null
	)
}

# Lista las novelas disponibles

list()
{
	echo 
	echo -e "\e[32m\e[1mNovelas disponibles:\e[0m"
	echo 
	for file in $(cd $DIR ; ls -d */)
		do
			if [ -f $DIR/$file/metadata.json ]
				then
					echo -e "\e[94m\e[1m\t$file\e[0m"
			fi
	done
	echo
}

# Genera la novela 

generate()
{
	NOVELABASENAME=$(basename $NOVELA)
	BUILD="build/$NOVELABASENAME"
	check $NOVELA
	parse

	echo 
	echo -e "Construyendo: \e[32m\e[1m$NOVELABASENAME\e[0m"
	echo 
	echo -e "\e[1mTÍTULO:\e[0m	\e[94m$title\e[0m"
	echo -e "\e[1mAUTOR:\e[0m 	\e[94m$author\e[0m"
	echo -e "\e[1mISBN:\e[0m 	\e[94m$isbn\e[0m"
	echo -e "\e[1mFECHA:\e[0m 	\e[94m$date\e[0m"
	echo 

	if [ $PDF -eq 0 ] && [ $EPUB -eq 0 ]
		then
			echo -e "\e[91mNo se ha seleccionado ningún formato para construir.\e[0m"
			exit 1
	fi

	# Se sustituyen los valores obtenidos en el fichero para la construcción
	sed -i "s/%%TITLE%%/$title/g" $BUILD/base.tex 2>/dev/null
	sed -i "s/%%AUTHOR%%/$author/g" $BUILD/base.tex 2>/dev/null
	sed -i "s/%%PUBLISHER%%/$publisher/g" $BUILD/base.tex 2>/dev/null
	sed -i "s:%%DATE%%:$date:g" $BUILD/base.tex 2>/dev/null

	if [ $? -eq 1 ]
		then
			echo -e "\e[91mError al insertar los metadatos.\e[0m"
			exit 1
	fi

	# Se fusionan los diferentes apartados en tres ficheros (pre, caps y post)
	(cd $BUILD ; ls docs/caps/*.tex | awk '{printf "\\input{%s}\n", $$1}' > caps.tex)
	if [ $? -eq 1 ]
		then
			echo -e "\e[33mError al generar \"caps.tex\".\e[0m"
			touch $BUILD/caps.tex
	fi

	(cd $BUILD ; ls docs/pre/*.tex | awk '{printf "\\input{%s}\n", $$1}' > pre.tex)
	if [ $? -eq 1 ]
		then
			echo -e "\e[33mError al generar \"pre.tex\".\e[0m"
			echo " " > touch $BUILD/pre.tex
	fi

	(cd $BUILD ; ls docs/post/*.tex | awk '{printf "\\input{%s}\n", $$1}' > post.tex)
	if [ $? -eq 1 ]
		then
			echo -e "\e[33mError al generar \"post.tex\".\e[0m"
			touch $BUILD/post.tex
	fi


	# Se convierte la portada a PDF
	if [ ! -f $BUILD/images/cover.jpg ]
		then
			echo -e "\e[33mNo existe portada para la novela seleccionada.\e[0m"
			echo "NO COVER" | pandoc -o $BUILD/images/cover.pdf -
		else
			convert $BUILD/images/cover.jpg $BUILD/images/cover.pdf
	fi

	if [ $PDF -eq 1 ]
		then pdf
	fi

	if [ $EPUB -eq 1 ]
		then epub
	fi

	clean

	echo 
}

while getopts “hped:vl:a:” OPTION
do
    case $OPTION in
        h)
            usage
            exit
            ;;
        p)
			PDF=1
			;;
		e)
			EPUB=1
			;;
        v)
            VERBOSE=1
            ;;
        d)
			NOVELAFLAG=true 
			NOVELA=$OPTARG
			;;
		l)
			DIR=$OPTARG
			list
			exit
			;;
		a)
			ALL=true
			DIR=$OPTARG
			;;
        ?)
            usage
            exit 1
            ;;
     esac
done

if [ "$ALL" = false ]
	then
		if [ "$NOVELAFLAG" = false ]
			then
	    		usage
	    		exit 1
		fi
		generate
	else
		for file in $(cd $DIR ; ls -d */)
			do
				if [ -f $DIR/$file/metadata.json ]
					then
						NOVELA="$DIR/$file"
						generate
				fi
		done
fi