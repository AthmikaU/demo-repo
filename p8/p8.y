%{ 
	#include <stdio.h> 
	#include <stdlib.h> 
	int yylex();
	void yyerror(const char *);
	extern int yylval;
	int id=0, dig=0, key=0, op=0; 
%}
%token DIGIT ID KEY OP 
%% 
input: DIGIT input { dig++; } 
	| ID input { id++; } 
	| KEY input { key++; } 
	| OP input {op++;} 
	| DIGIT { dig++; } 
	| ID { id++; } 
	| KEY { key++; } 
	| OP { op++;} 
	; 
%% 
#include <stdio.h> 
extern int yylex(); 
extern int yyparse(); 
extern FILE *yyin; 

int main() { 
	FILE *myfile = fopen("p8.c", "r"); 
	if (!myfile) {
		printf("I can't open sam_input.c!"); 
		return -1; 
	} 
	yyin = myfile; 
	do { 
		yyparse(); 
	} while (!feof(yyin)); 
	printf("numbers = %d\nKeywords = %d\nIdentifiers = %d\noperators = %d\n", dig, key,id, op); 
} 

void yyerror(const char *s) { 
	printf("EEK, parse error! Message: %s\n", s); 
	exit(-1); 
}
