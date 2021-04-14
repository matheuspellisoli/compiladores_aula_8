%%
%class Lexer
%type Token
%line
%column
%{
    private Token token(Token.T type) {
        return new Token(type, yyline, yycolumn);
    }
    private Token token(Token.T type, Object val) {
        return new Token(type, val, yyline, yycolumn);
    }
%}
underline 	= [_]
alpha       = [A-Za-z]
alpha_accentuates = [áàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ]
dig         = [0-9]
id          = ({alpha} | {underline}) ({alpha} | {dig})*
inteiro_def = {dig}+
real_def    = {dig}+ "." {dig}* | {dig}* "." {dig}+
texto_def   = ({alpha} | {dig} | {underline} | {alpha_accentuates})+ 
se          = <=+
small       = [<]
large       = [>]
le          = >=+
allocation  = [:]
equal       = [==]
delimiters  = [(){}'\"\,]
concatenation 	= [&]
add 			= [+]
%%

{add}            { return token(Token.T.ADD, yytext()); }
{concatenation}	 { return token(Token.T.CONCATENATION, yytext()); }
{delimiters}  	 { return token(Token.T.DELIMITERS, yytext()); }
{allocation}  	 { return token(Token.T.ALLOCATION, yytext()); }
{le}          	 { return token(Token.T.EL, yytext()); }
{large}      	 { return token(Token.T.LARGER, yytext()); }
{equal}       	 { return token(Token.T.EQUAL, yytext()); }
{small}       	 { return token(Token.T.SMALL, yytext()); }
{se}          	 { return token(Token.T.SE, yytext()); }
real          	 { return token(Token.T.REAL_CHAVE, yytext()); }
inteiro       	 { return token(Token.T.INTEIRO_CHAVE, yytext()); }
texto			 { return token(Token.T.TEXTO_CHAVE, yytext()); }
executa       	 { return token(Token.T.EXECUTA, yytext()); }
imprime       	 { return token(Token.T.IMPRIME, yytext()); }
retorna       	 { return token(Token.T.RETORNA, yytext()); }
se            	 { return token(Token.T.SE, yytext()); }
senao         	 { return token(Token.T.SENAO, yytext()); }
relop         	 { return token(Token.T.RELOP, yytext()); }
define		  	 { return token(Token.T.DEFINE, yytext()); }
programa      	 { return token(Token.T.PROGRAMA, yytext()); }
fimprograma   	 { return token(Token.T.FIMPROGRAMA, yytext()); }
declara       	 { return token(Token.T.DECLARA, yytext()); }
{inteiro_def}     	 { return token(Token.T.INTEIRO, new Integer(yytext())); }
{real_def}        	 { return token(Token.T.REAL, new Double(yytext())); }
{id}          	 { return token(Token.T.ID, yytext()); }
{texto_def}       	 { return token(Token.T.TEXTO, yytext()); }
[ \t\n\r]+    	 { /* do nothing */ }
<<EOF>>       	 { return token(Token.T.EOF); }
.             	 { System.out.printf("error: unexpected char |%s|\n", yytext());}