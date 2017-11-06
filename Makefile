#FICHERO MAKEFILE CHETADO(GENERALIZADO) COMENTADO. COMPILACION SEPARADA.

#PHONY indica a make que no cree el archivo especificado.
.PHONY: clean tgz zip

#DIRECTORIOS
BIN= bin
SRC= src
OBJ= obj
LIB= lib
INC= include
###

#NOMBRE EJECUTABLE
TARGET= practica3

# OPCIONES COMPILACION
CC = gcc
CFLAGS= -g -I$(INC)
Cxx= g++
FLAGSERRORES= -Wall -Wextra -pedantic
CXXFLAGS=  -std=c++11 -O2 -Wall 
LIBS= -lGL -lGLU -lglut
###

#INCLUDES Y EJECUTABLE
INCLUDES= -I$(INC)
EXE= $(BIN)/$(TARGET)
###

#FICHEROS OBJETO DEPENDIENTES DE UN .h
OBJECTS= $(OBJ)/practica3.o $(OBJ)/escena.o $(OBJ)/ejes.o $(OBJ)/punto3d.o \
 $(OBJ)/objeto3d.o $(OBJ)/cubo.o $(OBJ)/tetraedro.o $(OBJ)/cara.o $(OBJ)/piramide.o \
$(OBJ)/file_ply_stl.o $(OBJ)/model_ply.o $(OBJ)/model_rev.o $(OBJ)/model_bar.o \
$(OBJ)/model_jer.o


#DEPENDENCIAS AUTOMATICAS A PARTIR DE LOS .o
#(sustituimos .o por .dep de todos los objetos)
DEPS= $(OBJECTS:.o=.dep)

#REGLA POR DEFECTO
all: $(EXE)

#Creamos ejecutable a partir de todos los .o
#($^ se refiere a TODAS las dependencias)
$(EXE): $(OBJECTS)
	@echo "-- Linking $@ --"
	@$(CXX) $(CXXFLAGS) $^ -o $@ $(LIBS)
	@echo "-- Link and compilation finished --"

#CREAMOS .o DE LOS ARCHIVOS QUE SI DEPENDEN DE UN .h (importante orden)
$(OBJ)/%.o: $(SRC)/%.cpp $(INC)/%.h
	clear
	@echo "\nCompiling $< ..."
	@$(CXX) $(CXXFLAGS) $(INCLUDES) -o $@ -c $<

#CREAMOS .o DE LOS ARCHIVOS QUE NO DEPENDEN DE UN .h (importante orden)
$(OBJ)/%.o: $(SRC)/%.cpp
	clear
	@echo "\nCompiling $< ..."
	@$(CXX) $(CXXFLAGS) $(INCLUDES) -o $@ -c $<


#CREAMOS LOS ARCHIVOS CON LAS DEPENDENCIAS
#($< se refiere a la primera dependencia; $@ se refiere al objetivo)
$(OBJ)/%.dep: $(SRC)/%.cpp $(INC)/%.h
	@mkdir -p obj/ bin/	
	@$(CXX) -MM $(CXXFLAGS) $(INCLUDES) $< > $@

#INCLUIMOS DEPENDENCIAS
-include $(DEPS)

clean:
	@clear	
	@-rm -f $(OBJECTS) $(DEPS) *.tgz *.zip
	@-rm -f $(EXE)
	@echo "---------------------------------\nLimpiados *.o *.dep y binarios\n---------------------------------"	

#COMPRIMIDO Y LIMPIEZA RAR
tgz:	clean
	-tar -zcf $(TARGET).tgz *
	@echo "---------------------------------\nComprimido en tgz\n---------------------------------"


#COMPRIMIDO Y LIMPIEZA ZIP
zip:	clean
	-zip -sf- $(TARGET).zip -r *
	@echo "---------------------------------\nComprimido en ZIP\n---------------------------------"
