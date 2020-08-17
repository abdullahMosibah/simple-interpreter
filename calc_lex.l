%{
#include "calc_yacc.tab.h"
void yyerror(char *);
int yylex(); 

%} 

%%
"print"		{return print;} 
"exit"		{return exit_command;}
[a-zA-Z]	{yylval.id = yytext[0] ; return identifier;}
[0-9]+		{yylval.num = atoi(yytext); return number;}
[ \n\t]		;
[-+*=;]	{return yytext[0];}
.	{ECHO;  yyerror (" unexpected charcter");}

%%

int yywrap(void){return 1;} 
