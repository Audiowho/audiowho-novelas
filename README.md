# Audiowho Novelas

<p align="center">
  <img width="25%" src="https://raw.githubusercontent.com/Bigomby/audiowho-novelas/master/include/images/sello.png"/>
</p>

Este repositorio contiene el script `audiowho-build.sh` para generar las novelas de Audiowho y también las fuentes que se han usado en Audiowho para el montaje de las novelas que hemos traducido. Sólo están las novelas más recientes, que son las que han sido editadas usando el sistema de generación automática.

Próximamente reeditaremos las antigüas para que puedan ser construidas usando el nuevo sistema.

## Sistema de generación automática

El sistema de generación automática de novelas se compone de los siguientes archivos:

- `audiowho-build.sh`: Script que se usa para generar la novela.
- `tools`: Utilidades para la edición.
- `include/`: Carpeta con el siguiente contenido:
  - `base.tex`: Fichero que se usa como base. Contiene el preámbulo de LaTeX, la página de título y el índice de contenidos.
  - `style.css`: Se usa como hoja de estilos para el fichero ePub.

Todo lo que se encuentra en la carpeta `include` se copia al directorio donde se construye la novela, por lo que si se necesita un archivo para el montaje común se puede incluir en esta carpeta. Por ejemplo, el sello de Audiowho se encuentra dentro de la carpeta `include/images/` ya que se necesita cada vez que se construye una novela.

A continuación se verá qué estructura deben tener las novelas y cómo se utiliza el script.

## Estructura de las novelas

Las novelas se encuentran en formato LaTeX y deben tener la siguiente estructura para ser compatibles con el script:

```bash
titulo-de-la-novela/
├── docs
│   ├── caps
│   │   ├── file01.tex
│   │   ├── file02.tex
│   │   ├── file03.tex
│   │   └── ...
│   ├── post
│   │   ├── file01.tex
│   │   ├── file02.tex
│   │   ├── file03.tex
│   │   └── ...
│   └── pre
│       ├── file01.tex
│       ├── file02.tex
│       ├── file03.tex
│       └── ...
├── images
│   └── cover.jpg
└── metadata.json
```

El archivo `metadata.json` debe tener el siguiente contenido:

```json
{
    "title": "Título de la novela",
    "author": "Autor de la novela",
    "publisher": "Editorial de la novela",
    "isbn": "ISBN de la novela",
    "date": "Fecha en formato dd/mm/aaaa"
}
```

El título de la novela debe ir preferentemente sin mayúsculas ni espacios. El script creará un documento final con la siguiente estructura:

1. Portada con la imagen `images/cover.jpg`
2. Página de título con los metadatos obtenidos de `metadata.json`
3. Ficheros `.tex` dentro de la carpeta `pre`
4. Índice de contenidos
5. Ficheros `.tex` dentro de la carpeta `caps`
6. Ficheros `.tex` dentro de la carpeta `post`

## Requisitos

Los siguientes requisitos son para un equipo con Ubuntu 14.04 instalado.

- imagemagick (Para las portadas)
- jq (Para parsear ls metadatos)
- texlive-latex-base (Para generar el PDF)
- texlive-latex-recommended (Para generar el PDF)
- texlive-fonts-recommended (Para generar el PDF)
- texlive-lang-spanish (Para generar el PDF)
- pandoc (Para genera el ePub)
- calibre (Para la edición de metadatos del ePub)

Comando para instalar los requisitos en Ubuntu 14.04:

> apt-get install imagemagick jq texlive-latex-base texlive-latex-recommended texlive-fonts-recommended texlive-lang-spanish pandoc calibre

## Generación de novelas

Una vez nos hemos asegurado de que nuestra novela tiene la estructura adecuada y que tenemos instalado todos los paquetes necesarios ya podemos ejecutar el script:

```bash
Uso: ./audiowho-build.sh OPCIONES

Este script se usa para generar las novelas traducidas por AudioWho.

OPCIONES:
   -h      Muestra la ayuda
   -p      Genera un PDF
   -e      Genera un ePub
   -d      Directorio de la novela a construir
   -l      Lista las novelas de un directorio
   -a      Genera todas las novelas de un directorio
   -v      Modo verbose

Ejemplo: ./audiowho-build.sh -v -p -e -d novelas/titulo-de-la-novela
```

Si todo funciona correctamente, el script debe crear una carpeta llamada `build` en el mismo directorio en el que se encuentra . Dentro de esta carpeta creará una carpeta por cada novela con los ficheros PDF y ePub.

---

# Audiowho

<p align="center">
  <img src="http://www.audiowho.com/wp-content/uploads/2013/07/cabecera3.png"/>
</p>

## ¿Qué es Audiowho?

Somos un grupo abierto de personas interesadas en las traducciones de cualquier
material de Doctor Who, pero sobre todo nos centramos en el Universo Expandido
de Doctor Who y sus spin-offs. Cualquiera puede unirse al grupo y colaborar de
muchas formas. Tenemos un [grupo en Trello](http://trello.com/audiowho).

## ¿Qué hacemos?

Todo lo que traducimos en audiowho está destinado al público whovian. Hecho por
y para fans. No vendemos ningún tipo de material y no tenemos ánimo de lucro
ya que no somos los propietarios intelectuales del mismo así como no somos los
responsables del uso del material que compartimos en esta web.

Para contactar con nosotros si sigues con alguna duda tienes las siguientes
posibilidades:

- A través del Foro de Doctor Who en Español en el subforo Novelas/Cómics.
- A través de nuestra [página de Facebook](https://www.facebook.com/pages/AudioWho/241987289157018).
- A través de nuestra cuenta [@audiowho](https://twitter.com/AudioWho) de Twitter.
- A través de nuestra [página de Google+](https://plus.google.com/+Audiowho/).
- Por correo a [audiowho@audiowho.com](mailto://audiowho@audiowho.com).

Responderemos lo antes posible.

## Cómo colaborar con nosotros

Puedes rellenar el [formulario de contacto](http://goo.gl/forms/YIw7yvfDCM).

## Lista de novelas traducidas

### 2012

| Novela                | Fecha de publicación  | Traductor     | Disponible  |
|-----------------------|:---------------------:|:-------------:|:-----------:|
| Niña de otro Mundo    | 15/03/12              | Audiowho      | ✘           |
| Naturaleza Humana     | 03/04/12              | Audiowho      | ✘           |
| Los Ocho Doctores     | 15/05/12              | Audiowho      | ✘           |
| La Trampa del Doctor  | 01/09/12              | Audiowho      | ✘           |
| Shada                 | 23/11/12              | Audiowho      | ✘           |

### 2013

| Novela                      | Fecha de publicación  | Traductor     | Disponible  |
|-----------------------------|:---------------------:|:-------------:|:-----------:|
| Lungbarrow                  | 06/01/13              | Audiowho      | ✘           |
| Misión a lo Desconocido     | 23/01/13              | Audiowho      | ✘           |
| Sueños del Imperio          | 23/02/13              | Audiowho      | ✘           |
| Horizontes oscuros          | 15/03/13              | Nerea         | ✘           |
| La Balanza de la Justicia   | 23/03/13              | Audiowho      | ✘           |
| Evolución                   | 23/04/13              | Audiowho      | ✘           |
| Las Arenas del Tiempo       | 23/05/13              | Audiowho      | ✘           |
| La Feria de Pesadilla       | 23/06/13              | Audiowho      | ✘           |
| Historia 101                | 23/08/13              | Audiowho      | ✘           |
| Diario de Cosas Imposibles  | 27/10/13              | Audiowho      | ✔           |
| La Mutación del Tiempo      | 23/11/13              | Audiowho      | ✔           |
| Sólo Humano                 | 29/11/13              | Audiowho      | ✔           |
| Muertos de Invierno         | 14/12/13              | Audiowho      | ✔           |
| Velo de Tristeza            | 30/12/13              | Audiowho      | ✔           |

### 2014

| Novela                      | Fecha de publicación  | Traductor     | Disponible  |
|-----------------------------|:---------------------:|:-------------:|:-----------:|
| Los días contados           | 23/04/14              | Nerea         | ✘           |
| El Décimo Planeta           | 05/04/14              | Rick          | ✘           |
| Las Garras de Weng-Chiang   | 05/04/14              | Rick          | ✘           |
| Los Juegos de Guerra        | 05/04/14              | Rick          | ✘           |
| Los embajadores de la muerte| 01/05/14              | Rick          | ✘           |
| El recuerdo de los Daleks   | 02/05/14              | Audiowho      | ✘           |
| La marca de Rani            | 25/06/14              | Rick          | ✘           |
| Voyager                     | 13/07/14              | Rick          | ✘           |
| Historias de Trenzalore     | 25/07/14              | Audiowho      | ✔           |
| La generación Dalek         | 28/08/14              | Colaboración  | ✘           |
| Máquinas de Guerra          | 02/11/14              | Nerea         | ✔           |
| Una Gran Mano para El Doctor| 02/11/14              | Audiowho      | ✔           |

### 2015

| Novela                              | Fecha de publicación  | Traductor     | Disponible   |
|-------------------------------------|:---------------------:|:-------------:|:------------:|
| The Blood Cell                      | 31/01/15              | Audiowho      | ✔            |
| La Ciudad sin Nombre                | 27/02/15              | Audiowho      | ✔            |
| La Lanza del Destino                | 27/02/15              | Audiowho      | ✔            |
| Las Raíces del Mal                  | 28/02/15              | Audiowho      | ✔            |
| En la Punta de la Lengua            | 28/02/15              | Audiowho      | ✔            |
| Algo Prestado                       | 28/02/15              | Audiowho      | ✔            |
| El Efecto Dominó                    | 10/03/15              | Audiowho      | ✔            |
| Espora                              | 10/03/15              | Audiowho      | ✔            |
| La Bestia de Babilionia             | 10/03/15              | Audiowho      | ✔            |
| El Misterio de la Cabaña Embrujada  | 10/03/15              | Audiowho      | ✔            |
| Nada en Punto                       | 10/03/15              | Audiowho      | ✔            |
| Luces Apagadas                      | 10/03/15              | Audiowho      | ✔            |
| La Rose de piedra                   | 19/07/15              | Dani Lestrange| ✔            |
| Soy un Dalek                        | 19/07/15              | Dani Lestrange| ✔            |
| Hermoso Caos                        | 19/07/15              | Audiowho      | ✔            |
| Bell Caos (catalán)                 | 19/07/15              | Dani Lestrange| ✔            |
| La venganza de los Judoon           | 19/07/15              | Dani Lestrange| ✔            |

Puedes descargar el pack de novelas con todas las novelas generadas mediante el sistema de generación automática o ir a la biblioteca donde están publicadas **todas** todas las novelas traducidas por Audiowho hasta la fecha:

- [**Pack de novelas**](https://github.com/Bigomby/audiowho-novelas/releases)
- [**Biblioteca de novelas**](http://www.audiowho.com/biblioteca-de-novelas/)


[Máquinas de Guerra]:http://www.audiowho.com/2014/11/maquinas-de-guerra/
[Historias de Trenzalore]:http://www.audiowho.com/2014/07/historias-de-trenzalore/
