/*Código Lex para contar palabras, líneas, espacios y tabulaciones de un texto dado*/
  
%{ 
#include<stdio.h> 
#include<string.h> 

int  sc=0, tc=0, wc=0,lc=0; /*Contadores globales*/
%} 
  
/*Seccion de reglas*/
%% 
([a-zA-Z0-9])*    {
	wc++;
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
  

int main() 
{ 
	  extern FILE *yyin, *yyout; 
  
    // yyin apunta al archivo Input.txt y lo abre en modo lectura
    yyin = fopen("Input.txt", "r"); 
    
    // yylex comienza el análisis del texto
    yylex(); 
    
    //Una vez finaliza el análisis imprimimos el resultado
    printf("\nNo. espacios=%d", sc); 
    printf("\nNo. tabulaciones=%d", tc); 
    printf("\nNo. palabras=%d", wc); 
    printf("\nNo. lineas=%d\n", lc); 
    
    return 0; 
} 
