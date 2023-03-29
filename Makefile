all: run

example.java exampleJNI.java example_wrap.c: example.i
	swig -java example.i

example.o example_wrap.o: example.c example.h example_wrap.c
	gcc -I /usr/lib/jvm/default-java/include -I /usr/lib/jvm/default-java/include/linux -fpic -c example.c example_wrap.c

libexample.so: example.o example_wrap.o
	gcc -shared example.o example_wrap.o -o libexample.so

main.class: main.java example.java
	javac main.java

run: main.class libexample.so
	java -Djava.library.path=$(pwd) main

clean:
	rm -f *.o *.so *.class example.java exampleJNI.java example_wrap.c