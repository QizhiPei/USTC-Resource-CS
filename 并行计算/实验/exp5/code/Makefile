CC = g++
CCFLAGS = -I . -O2 -fopenmp
LDFLAGS = # -lopenblas

all:  quicksort

quicksort: quick_sort.cpp
	${CC} ${CCFLAGS} quick_sort.cpp -o quicksort ${LDFLAGS}

clean:
	rm  quicksort
