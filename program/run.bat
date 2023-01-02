@echo off
set str=%1
@echo on
flex lex.l
bison -d parser.y
gcc -o parser lex.yy.c parser.tab.c ast.c semanticAnalysis.c
parser %str%