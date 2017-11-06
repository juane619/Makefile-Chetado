# Makefile-Chetado
Linux Makefile

Makefile generalizado con compilación separada. 
Directorios: bin, include, src, obj, lib, doc.

- INSTRUCCIONES:
  Solo añadir los nombres de los ficheros .o en la sección de objetos del Makefile correspondientes a los archivos .cpp depositados en el directorio <src> que se tengan, tanto de los que se tengan .h asociados a ellos como de los que no.
  
Ejemplo:  src/prueba.cpp src/circulo.cpp    Añadiriamos prueba.o y circulo.o a la seccion de OBJETOS.
          include/circulo.h

El Makefile autocomprueba las dependencias de cada .cpp y re-compila al hacer "make" si modificamos cualquier .cpp o cualquier .h.

Gran ayuda para compilar rapido añadiendo solo los nombres .o y ejecutando "make".
