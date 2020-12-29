
/**
    Programa reconocedor de letras
**/

%{ 
    #include<stdio.h> 
    #include<string.h> 
    #include<stdlib.h>
    #include<ctype.h>
    
    const char cod_numeros[5]= {'O','I','U','E','A'};	//A-4 E-3 I-1 O-0 U-2

    char letra;
    int contador = 0;
    char sustituto[30],aux;
    FILE *yyout, *yyin;

    int descodificar = 0;
%}

%% 
[*]{8} {
	descodificar = 1;
}

[aeiouAEIOU] {
	int i = 0;
	int encontrado = 0;
	for(; i<5 && encontrado==0; i++){
		encontrado = cod_numeros[i] == toupper(yytext[0]);
		printf("%c\n",cod_numeros[i] );
	}
	char char_cod = i - '0';
	printf("%c-",yytext[0]);
	printf("%c\n", char_cod);
	fputc(char_cod, yyout);
}

[^aeiouAEIOU01234\t\n\b] {
	
	if(!descodificar){
		char char_cod = yytext[0] + 64;
		fputc(char_cod, yyout);		
	}
	else{
		char char_cod = yytext[0] - 64;
		fputc(char_cod, yyout);
	}
}

[0-4] {
	char char_cod = cod_numeros[atoi(yytext)];
	fputc(char_cod, yyout);
}

\b {fputc('\b', yyout);}
\t {fputc('\t', yyout);}
\n {fputc('\n', yyout);}

%% 

int main(int argc, char** argv){ 

	if(argc!=3){
		printf("ERROR: El formato es ArchivoEntrada ArchivoSalida\n");
		exit(0);
	}

	yyin = fopen(argv[1], "r");
	
	if(!yyin){
		printf("ERROR: El archivo %s no se abrió correctamente\n", argv[1]);
		exit(0);	
	} 

	yyout = fopen(argv[2],"w");

	if(!yyout){
		printf("ERROR: El archivo %s no se abrió correctamente\n", argv[2]);
		exit(0);	
	}

	yylex(); 
	return 0;
}