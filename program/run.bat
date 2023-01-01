
bison --yacc -dv parser.y
flex lex.l
gcc -o solve parser.tab.c lex.yy.c