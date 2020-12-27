/*Programa Contador de palabras*/
%{ 
#include<stdio.h> 
#include<string.h> 
int i = 0; 
%} 
  
/* Sección de reglas*/
%% 
([a-zA-Z0-9])*    {i++;} /* Regla para contar las palabras*/
  
"\n" {printf("%d\n", i); i = 0;} 
%% 
  
int yywrap(void){} 
  
int main() 
{    
    // Función que ejecuta el análisis
    yylex(); 
  
    return 0; 
} 
