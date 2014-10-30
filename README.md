# Audiowho Novelas

Este repositorio contiene las fuentes que se han usado en Audiowho para el montaje
de las novelas que hemos traducido en Audiowho.

La traduccón la realizan nuestros traductores y en este repositorio puedes
encontrar los documentos en LaTeX que usamos para su montaje en ePub y PDF.

## Cómo construir novelas

### Requisitos

En primer lugar para poder generarlas debemos tener instalados los siguiente paquetes:

- imagemagick (Para las portadas)
- jq (Para parsear ls metadatos)
- texlive-latex-base (Para generar el PDF)
- texlive-latex-recommended (Para generar el PDF)
- texlive-fonts-recommended (Para generar el PDF)
- texlive-lang-spanish (Para generar el PDF)
- pandoc (Para genera el ePub)
- calibre (Para la edición de metadatos del ePub)
- xvfb (Para que ebook-polish funcione sin servidor X)

Para Ubuntu 14.04 puedes ejecutar el comando:

```
apt-get install imagemagick jq texlive-latex-base texlive-latex-recommended texlive-fonts-recommended texlive-lang-spanish pandoc calibre xvfb
```

### Generación de novelas

#### PDF

```
make pdf
```

#### ePub

```
make epub
```

Puedes generar ambos simplemente con:

```
make
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