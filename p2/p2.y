%{ 
	#include<stdio.h> 
	#include<stdlib.h> 
	int yylex();
	int yyerror(const char *s);
%} 
%token num
%left '+' '-' 
%left '*' '/' 
%%
input : exp { 
		printf("%d\n",$$);
		exit(0);
	} 
exp : exp'+'exp { $$=$1+$3; } 
	| exp'-'exp{ $$=$1-$3; } 
	| exp'*'exp{ $$=$1*$3; } 
	| exp'/'exp { 
		if($3==0){
			printf("Divide by Zero error\n"); 
		        exit(0);
		} 
		else 
			$$=$1/$3;
	} 
        | '('exp')' { $$=$2; } 
        | num{ $$=$1; }; 
%% 
int yyerror(const char *s) 
{ 
	printf("error"); 
	exit(0); 
} 

int main() 
{ 
	printf("Enter an expression:\n"); 
	yyparse();
	return 0;
}
