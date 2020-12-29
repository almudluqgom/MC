//*****************************************************************************//
//																			   //
//	PRÁCTICA 2 MODELOS DE COMPUTACIÓN                                          //
//																			   //
//	CODIFICADOR-DECODIFICADOR LEX											   //
//																			   //
//	ALMUDENA LUQUE GÓMEZ													   //
//	IGNACIO YUSTE LÓPEZ														   //
//																			   //
//*****************************************************************************//

%{ 
    #include<stdio.h> 
    #include<string.h> 
    #include<stdlib.h>
    #include<ctype.h>
    
    const char cod_numeros[5]= {'o','i','u','e','a'};	//A-4 E-3 I-1 O-0 U-2

    char letra;
    int contador = 0;
    FILE *yyout, *yyin;

    int decodificar;
%}

%%
[aeiouAEIOU] {
	int i;
	int encontrado = 0;
	
	for(i=0; i<5 && encontrado==0; i++){
		encontrado = cod_numeros[i] == tolower(yytext[0]);
	}

	char char_cod = i-1 +'0';
	fputc(char_cod, yyout);
}

[^aeiouAEIOU01234\t\n\b] {
	
	if(!decodificar){
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

/*
-REGLAS LEX:

	1ºRegla: [aeiouAEIOU] 
		Codifica/Descodifica las vocales y los escribe en el fichero de salida

	2ºRegla: [^aeiouAEIOU01234\t\n\b] 
		Codifica/Descodifica cualquier caracter excepto vocales, números, espacios, tabuladores y saltos de línea
		y los escribe en el fichero de salida

	3ºRegla: [0-4]
		Codifica/Descodifica los números y los escribe en el fichero de salida

	4º,5º,6º Reglas: \b \t \n
		Introduce los espacios, tabuladores y saltos de linea sin modificar en el fichero de salida

*/

int main(int argc, char** argv){ 

	if(argc!=4){
		printf("ERROR: El formato es ArchivoEntrada ArchivoSalida 0(codificar)/1(decodificar)\n");
		exit(0);
	}

	yyin = fopen(argv[1], "r");
	
	if(yyin==NULL){
		printf("ERROR: El archivo %s no se abrió correctamente\n", argv[1]);
		exit(0);	
	} 

	yyout = fopen(argv[2],"w");

	if(yyout==NULL){
		printf("ERROR: El archivo %s no se abrió correctamente\n", argv[2]);
		exit(0);	
	}

	decodificar = atoi(argv[3]);

	//Codificar/decodificar archivo
	yylex(); 

	if(decodificar)
		printf("El archivo ha sido descodificado\n");
	else
		printf("El archivo ha sido codificado\n");
	
	return 0;
}
