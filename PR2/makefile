
# Makefile
# Compila la práctica de lex para el análisis de un texto. 
 
./a.out: lex.yy.c
	cc $< -lfl

lex.yy.c: codigo.l
	lex $<

clean: 
	rm a.out lex.yy.c
