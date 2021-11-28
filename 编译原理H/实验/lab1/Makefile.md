```makefile
sort: sort.o
    gcc sort.o -o sort
sort.o: sort.c
	gcc -c sort.c -o sort.o
sort-64.s: sort.c 
	gcc -S sort.c -o sort-64.s
sort-32.s: sort.c
	gcc -S -m32 sort.c -o sort-32.s
sort.i: sort.c
	gcc -E sort.c -o sort.i
clean:
    rm -rf sort.o
```

```makefile
sort: sort.o
    gcc sort.o -o sort
sort.o: sort.c
	gcc -c sort-64.s -o sort.o
sort-64.s: sort.c 
	gcc -S sort.c -o sort-64.s
clean:
    rm -rf sort.o
```

```makefile
sort: sort.o
    gcc sort.o -o sort
sort.o: sort.c
	gcc -c sort.c -o sort.o
clean:
    rm -rf sort.o
```



```
gcc -S -m32 sample.c -o sample-32.s
gcc -S sample.c -o sample.s
```

