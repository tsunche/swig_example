all: run

example.java exampleJNI.java example_wrap.cpp: example.i
	swig -c++ -cppext cpp -java example.i

example.o example_wrap.o: example.cpp example.h example_wrap.cpp
	g++ -I /usr/lib/jvm/default-java/include -I /usr/lib/jvm/default-java/include/linux -fpic -c example.cpp example_wrap.cpp

libexample.so: example.o example_wrap.o
	g++ -shared example.o example_wrap.o -o libexample.so

main.class: main.java example.java
	javac main.java

run: main.class libexample.so
	java -Djava.library.path=$(pwd) main

clean:
	rm -f *.o *.so *.class example.java exampleJNI.java example_wrap.cpp