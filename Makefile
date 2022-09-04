# put cpp in working folder, put .hpp files in ./include/ folder, and make ./obj/ fodler
# or run "make project" to automatically make all dirs and move all the files in them
GXX = g++
FLAGS = -Wall -Wextra -g -O1 -MP -MD $(INC)

DIR = $(dir $(wildcard ./*/))
INC = $(foreach Dir, $(DIR), $(patsubst %, -I%, $(Dir)))

SRC = $(wildcard *.cpp)
OBJ = $(patsubst %.cpp, obj/%.o, $(SRC))
DEPFILES = $(patsubst %.cpp, obj/%.d, $(SRC))
BIN = main

all: $(BIN)

$(BIN): $(OBJ)
	$(GXX) $^ -o $@

obj/%.o: %.cpp
	$(GXX) -c $< -o $@ $(FLAGS)

project:
	-mkdir obj
	-mkdir include
	-move *.hpp include
	-move *.o obj
	-move *.d obj

clean:
	del .\obj\*.o .\obj\*.d $(BIN).exe

-include $(DEPFILES)
