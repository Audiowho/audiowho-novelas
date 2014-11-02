# Audiowho Novelas

Este repositorio contiene las fuentes que se han usado en Audiowho para el montaje
de las novelas que hemos traducido.

La traduccón la realizan nuestros traductores y en este repositorio puedes
encontrar los documentos en LaTeX que usamos para su montaje en ePub y PDF.

## Cómo construir novelas

### Requisitos

Los siguientes requisitos son para un equipo con Ubuntu 14.04 instalado. En primer lugar para poder generarlas debemos tener instalados los siguiente paquetes:

- imagemagick (Para las portadas)
- jq (Para parsear ls metadatos)
- texlive-latex-base (Para generar el PDF)
- texlive-latex-recommended (Para generar el PDF)
- texlive-fonts-recommended (Para generar el PDF)
- texlive-lang-spanish (Para generar el PDF)
- pandoc (Para genera el ePub)
- calibre (Para la edición de metadatos del ePub)

Para Ubuntu 14.04 puedes ejecutar el comando:

> apt-get install imagemagick jq texlive-latex-base texlive-latex-recommended texlive-fonts-recommended texlive-lang-spanish pandoc calibre

### Generación de novelas

#### PDF y ePub
```
make
```

#### PDF
```
make pdf
```

#### ePub
```
make epub
```

---

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
- Historias de Trenzalore [25/7/14]
- *La generación Dalek [28/8/14]*

*Las novelas en cursiva son colaboraciones, no han sido traducidas por el equipo de Audiowho, pero puedes descargarlas de nuestra web*
