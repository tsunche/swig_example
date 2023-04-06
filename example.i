%module example
%{
/* Put header files here or function declarations like below */
/* 裡的字串直接無腦丟進 example_wrap.c */
#include "example.h"
%}

%include "example.h"
