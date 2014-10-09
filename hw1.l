%{
#include <iostream>
#include "hw2.tab.h"
using namespace std;
int lineno = 1;
char* yyval;
%}
%x COMMENT
%option yylineno

%%
def	{yyval = yytext;return DEF;}		 	//	{/*cout<<"def"<<endl;*/}
extern 	{yyval = yytext;return EXTERN;}
[\-]	{return MINUS;}
[\+]	{return PLUS;}
[a-z]+[a-z0-9]*	 {yyval = yytext;return ID;}		//id
(([0-9]+)|([0-9]*\.[0-9]+)) {yyval = yytext;return NUMBER;}		//number
#([^\n])* {BEGIN COMMENT;}
<COMMENT>\n {BEGIN 0;}
[ \t]+ ;
\n {yyval = yytext;lineno++;}	
[^\n] {yyval = yytext;return yytext[0];}	//all symbol
%%
