%{
void yyerror (char *s); /* for error handeling */
int yylex(); /* getting value from tokens ? */ 

#include <stdio.h> /* standard I/O routines, used in actions below */
#include <stdlib.h> /* general purpose standard library used in actions below */
#include <ctype.h> /* used for charcters, testing and mapping */

int symbols[52];/* symbols table, you know what it is cmon stop the kapp */
int symbolVal(char symbols); /* function defintion, to return the symbol value ?*/
void  updateSymbolVal(char symbol, int val); /* you what it is stop the the kapp*/
%}


%union {int num; char id;}
%start line 
%token print
%token exit_command
%token <num> number 
%token <id> identifier
%type <num> line exp term 
%type <id> assignment

%%

line 	: assignment ';'		{;}
	|exit_command ';'		{exit(EXIT_SUCCESS);} /* used from header stdlib*/
	|print exp ';'			{printf("%d\n", $2);}
	
	|line assignment ';'		{;}
	|line exit_command ';'		{exit(EXIT_SUCCESS);}
	|line print exp ';'		{printf("%d\n", $3);}
	;




assignment : identifier '=' exp {updateSymbolVal($1,$3);}

	;

exp	: term		{$$ = $1;}
	|exp '+' term	{$$ = $1 + $3;}
	|exp '-' term	{$$ = $1 - $3;}
	|exp '*' term	{$$ = $1 * $3;}
	;


term	:number		{$$ = $1;}
	|identifier	{$$ = symbolVal($1);}
	;
%%



int computeSymbolIndex(char token)
{
	int idx = -1; 
	if(islower(token)){
		idx = token - 'a' + 26;
	}else if(isupper(token)){
		idx = token - 'A';
	}
	return idx;
}

/* returns the value of a given symbol */

int symbolVal(char symbol){
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}

/* updates the value of a given symbol */
void updateSymbolVal(char symbol, int val)
{
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
}

int main (void) {
	/* init symbol table */
	int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 































