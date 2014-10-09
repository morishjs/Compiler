%{
#include <iostream>
#include <stdio.h>
int yylex(void);
void yyerror(const char*);
using namespace std;
extern int lineno;
#define YYERROR_VERBOSE 1
%}

%token DEF NUMBER ID EXTERN COMMENT MINUS PLUS
%start program
%locations

%%

program : topList;
topList : top ';'|topList top ';';
top : definition|external|expression;
definition : DEF prototype expression;
prototype : identifier '('')'|identifier'('identifierList')';
identifier : ID;
identifierList : identifier|identifierList ',' identifier;
expression : numberExpr|variableExpr|binaryExpr|callExpr|'('expression')';
numberExpr : NUMBER| PLUS NUMBER|MINUS NUMBER;
variableExpr : identifier;
binaryExpr : expression PLUS expression|expression MINUS expression|expression'*'expression;
callExpr : identifier '('')'|identifier'('expressionList')';
expressionList : expression|expressionList','expression;
external : EXTERN prototype;

%%

void yyerror(const char* s)
{
	cout<<"FAIL!"<<endl;
	cout<<"ERROR: line "<<lineno<<endl;
	cout<<s<<endl;
	
}

int main()
{
 if(yyparse() == 0) std::cout<<"PASS!"<<std::endl;

}
