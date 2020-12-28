
/*Código Lex para contar palabras, líneas, espacios y tabulaciones de un texto dado*/

%{ 
#include<stdio.h> 
#include<string.h> 

/*Contadores globales*/
int  sc=0, tc=0, wc=0,lc=0;
int pbuscada=0;
char palabra[10];
%} 
  
/*Seccion de reglas*/
%% 
([a-zA-Z0-9])*    {
	wc++;
	if (strcmp(yytext, palabra) == 0)
		pbuscada++;

} // Contador de palabras

([ ])+ {
	sc++;
} // Contador de espacios

\t {
	tc++;
} // Contador de tabuladores

\n {
	lc++;
} // Contador de línea

%% 
  

int main(int argc, char ** argv) 
{ 
	strcpy(palabra,argv[1]);

	extern FILE *yyin, *yyout; 
  
    // yyin apunta al archivo Input.txt y lo abre en modo lectura
    yyin = fopen("Input.txt", "r"); 
    
    // yylex comienza el análisis del texto
    yylex(); 
    
    //Una vez finaliza el análisis imprimimos el resultado
    printf("No. espacios=%d", sc); 
    printf("\nNo. tabulaciones=%d", tc); 
  	printf("\nNo. palabras=%d", wc); 
	printf("\nNo. lineas=%d", lc);
	printf("\nNo. palabra buscada=%d", pbuscada);
	float freq = (float)pbuscada/(float)wc*100;
	printf("\nFreq. palabra buscada=%.2f%c\n",freq,'%');
    
    return 0; 
} 
