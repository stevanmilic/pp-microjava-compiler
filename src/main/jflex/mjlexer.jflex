package lexer;

import java_cup.runtime.*;
//import parser.sym;
%%

%public
%class Lexer

%cup
%line
%column

%{

	private Symbol symbol(int type) {
		return new Symbol(type, yyline+1, yycolumn+1);
	}
	
	private Symbol symbol(int type, Object value) {
		return new Symbol(type, yyline+1, yycolumn+1, value);
	}

%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]

WhiteSpace = {LineTerminator} | [ \t\f]

Comment    = "//" {InputCharacter}* {LineTerminator}?

Identifier = [:jletter:][:jletterdigit:]*

IntegerLiteral = 0 | [1-9][0-9]*

SingleCharacter = [^\r\n\'\\]

%state CHARLITERAL

%%

<YYINITIAL> {

	/* keywords */
	"program"        { return symbol(sym.PROGRAM, yytext()); }
	"break"          { return symbol(sym.BREAK, yytext()); }
	"class"          { return symbol(sym.CLASS, yytext()); }
	"else"           { return symbol(sym.ELSE, yytext()); }
	"const"          { return symbol(sym.CONST, yytext()); }
	"if"             { return symbol(sym.IF, yytext()); }
	"new"            { return symbol(sym.NEW, yytext()); }
	"print"          { return symbol(sym.PRINT, yytext()); }
	"read"           { return symbol(sym.READ, yytext()); }
	"return"         { return symbol(sym.RETURN, yytext()); }
	"void"           { return symbol(sym.VOID, yytext()); }
	"for"            { return symbol(sym.FOR, yytext()); }
	"extends"        { return symbol(sym.EXTENDS, yytext()); }
	"continue"       { return symbol(sym.CONTINUE, yytext()); }
	"static"         { return symbol(sym.STATIC, yytext()); }

	/* literals */
	"true"           { return symbol(sym.BOOL_LITERAL, true); }
	"false"          { return symbol(sym.BOOL_LITERAL, false); }

	\'               { yybegin(CHARLITERAL); }

	/* separators */
	";"              { return symbol(sym.SEMICOLON, yytext()); }
	","              { return symbol(sym.COMMA, yytext()); }
	"."              { return symbol(sym.DOT, yytext()); }
	"("              { return symbol(sym.LPAREN, yytext()); }
	")"              { return symbol(sym.RPAREN, yytext()); }
	"["              { return symbol(sym.LBRACK, yytext()); }
	"]"              { return symbol(sym.RBRACK, yytext()); }
	"{"              { return symbol(sym.LBRACE, yytext()); }
	"}"              { return symbol(sym.RBRACE, yytext()); }

	/* operators */
	"+"              { return symbol(sym.PLUS, yytext()); }
	"-"              { return symbol(sym.MINUS, yytext()); }
	"*"              { return symbol(sym.MULT, yytext()); }
	"/"              { return symbol(sym.DIV, yytext()); }
	"%"              { return symbol(sym.MOD, yytext()); }
	"++"             { return symbol(sym.PLUSPLUS, yytext()); }
	"--"             { return symbol(sym.MINUSMINUS, yytext()); }

	"=="             { return symbol(sym.EQEQ, yytext()); }
	"!="             { return symbol(sym.NOTEQ, yytext()); }
	">"              { return symbol(sym.GT, yytext()); }
	"<"              { return symbol(sym.LT, yytext()); }
	">="             { return symbol(sym.GTEQ, yytext()); }
	"<="             { return symbol(sym.LTEQ, yytext()); }

	"&&"             { return symbol(sym.ANDAND, yytext()); }
	"||"             { return symbol(sym.OROR, yytext()); }

	"="              { return symbol(sym.EQ, yytext()); }
	"+="             { return symbol(sym.PLUSEQ, yytext()); }
	"-="             { return symbol(sym.MINUSEQ, yytext()); }
	"*="             { return symbol(sym.MULTEQ, yytext()); }
	"/="             { return symbol(sym.DIVEQ, yytext()); }
	"%="             { return symbol(sym.MODEQ, yytext()); }
	
	/* identifier */
	{Identifier}     { return symbol(sym.IDENTIFIER, yytext()); }

	/* integer literals */
	{IntegerLiteral} { return symbol(sym.INTEGER_LITERAL, new Integer(yytext())); }

	/* whitespaces */
	{WhiteSpace}     { /* ignore */ }

	/* comments */
	{ Comment}       { /* ignore */ }

}

<CHARLITERAL> {
	{SingleCharacter}\' { yybegin(YYINITIAL); return symbol(sym.CHAR_LITERAL, yytext().charAt(0)); }   
	
	/* escape sequences */
  "\\b"\'          { yybegin(YYINITIAL); return symbol(sym.CHAR_LITERAL, '\b'); }
  "\\t"\'          { yybegin(YYINITIAL); return symbol(sym.CHAR_LITERAL, '\t'); }
  "\\n"\'          { yybegin(YYINITIAL); return symbol(sym.CHAR_LITERAL, '\n'); }
  "\\f"\'          { yybegin(YYINITIAL); return symbol(sym.CHAR_LITERAL, '\f'); }
  "\\r"\'          { yybegin(YYINITIAL); return symbol(sym.CHAR_LITERAL, '\r'); }
  "\\\""\'         { yybegin(YYINITIAL); return symbol(sym.CHAR_LITERAL, '\"'); }
  "\\'"\'          { yybegin(YYINITIAL); return symbol(sym.CHAR_LITERAL, '\''); }
  "\\\\"\'         { yybegin(YYINITIAL); return symbol(sym.CHAR_LITERAL, '\\'); }

	/* error - if new line char */
	\\. 						 { throw new RuntimeException("Illegal escape sequence \"" + yytext() + "\""); }
	{LineTerminator} { throw new RuntimeException("Unterminated character literal at the end of a line"); }
}

/* error - everything else */
[^]               { throw new RuntimeException("Illegal character \"" + yytext()+ "\" at line " + yyline + ", column " + yycolumn); }

/* end of file */
<<EOF>>            { return symbol(sym.EOF); }
