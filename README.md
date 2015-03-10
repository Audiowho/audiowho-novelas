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

- Niña de otro Mundo [15/3/12]
- Naturaleza Humana [3/4/12]
- Los Ocho Doctores [15/5/12]
- La Trampa del Doctor [1/9/12]
- Shada [23/11/12]

### 2013

- Lungbarrow [6/1/13]
- Misión a lo Desconocido [23/1/13]
- Sueños del Imperio [23/2/13]
- *Horizontes oscuros [15/3/13]*
- La Balanza de la Justicia [23/3/13]
- Evolución [23/4/13]
- Las Arenas del Tiempo [23/5/13]
- La Feria de Pesadilla [23/6/13]
- La Mutación del Tiempo [23/11/13]
- Historia 101 [23/8/13]
- Sólo Humano [29/11/13]
- Diario de Cosas Imposibles [27/10/13]
- Muertos de Invierno [14/12/13]
- Velo de Tristeza [30/12/13]

### 2014

- *Los días contados [23/4/14]*
- *El Décimo Planeta [5/4/14]*
- *Las Garras de Weng-Chiang [5/4/14]*
- *Los Juegos de Guerra [5/4/14]*
- *Los embajadores de la muerte [1/5/14]*
- El recuerdo de los Daleks [2/5/14]
- *La marca de Rani [25/6/14]*
- *Voyager [13/7/14]*
- **[Historias de Trenzalore]** \[25/7/14\]
- *La generación Dalek [28/8/14]* 
- **[Máquinas de Guerra]** \[2/11/14\]
- **11 Doctores 11 Historias: Una Gran Mano para El Doctor**
- **11 Doctores 11 Historias: La Ciudad sin Nombre**
- **11 Doctores 11 Historias: La Lanza del Destino**
- **11 Doctores 11 Historias: Las Raíces del Mal**
- **11 Doctores 11 Historias: En la Punta de la Lengua**
- **11 Doctores 11 Historias: Algo Prestado**
- **11 Doctores 11 Historias: El Efecto Dominó**
- **11 Doctores 11 Historias: Espora**
- **11 Doctores 11 Historias: La Bestia de Babilionia**
- **11 Doctores 11 Historias: El Misterio de la Cabaña Embrujada**
- **11 Doctores 11 Historias: Nada en Punto**
- **11 Doctores 11 Historias: Luces Apagadas**
- **The Blood Cell**

Puedes descargar el pack de novelas con todas las novelas generadas mediante el sistema de generación automática o ir a la biblioteca donde están publicadas **todas** todas las novelas traducidas por Audiowho hasta la fecha:

- [**Pack de novelas**](https://github.com/Bigomby/audiowho-novelas/releases)
- [**Biblioteca de novelas**](http://www.audiowho.com/biblioteca-de-novelas/)

---

*Las novelas en cursiva son colaboraciones, no han sido traducidas por el equipo de Audiowho, pero puedes descargarlas de nuestra web.*

*Las novelas en negrita están editadas usando el sistema de generación automática de AudioWho.*


[Máquinas de Guerra]:http://www.audiowho.com/2014/11/maquinas-de-guerra/
[Historias de Trenzalore]:http://www.audiowho.com/2014/07/historias-de-trenzalore/