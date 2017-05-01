import java_cup.runtime.*;
import lexer.sym;

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

%state CHARLITERAL

%%

<YYINITIAL> {

	/* keywords */
	"program"        { return symbol(sym.PROGRAM); }
	"break"          { return symbol(sym.BREAK); }
	"class"          { return symbol(sym.CLASS); }
	"else"           { return symbol(sym.ELSE); }
	"const"          { return symbol(sym.CONST); }
	"if"             { return symbol(sym.IF); }
	"new"            { return symbol(sym.NEW); }
	"print"          { return symbol(sym.PRINT); }
	"read"           { return symbol(sym.READ); }
	"return"         { return symbol(sym.RETURN); }
	"void"           { return symbol(sym.VOID); }
	"for"            { return symbol(sym.FOR); }
	"extends"        { return symbol(sym.EXTENDS); }
	"continue"       { return symbol(sym.CONTINUE); }
	"static"         { return symbol(sym.STATIC); }

	/* literals */
	"true"           { return symbol(sym.BOOL_LITERAL, true); }
	"false"          { return symbol(sym.BOOL_LITERAL, false); }

	"null"           { return symbol(sym.NULL_LITERAL); }

	\'               { yybegin(CHARLITERAL); }

	/* separators */
	";"              { return symbol(sym.SEMICOLON); }
	","              { return symbol(sym.COMMA); }
	"."              { return symbol(sym.DOT); }
	"("              { return symbol(sym.LPAREN); }
	")"              { return symbol(sym.RPAREN); }
	"["              { return symbol(sym.LBRACK); }
	"]"              { return symbol(sym.RBRACK); }
	"{"              { return symbol(sym.LBRACE); }
	"}"              { return symbol(sym.RBRACE); }

	/* operators */
	"+"              { return symbol(sym.PLUS); }
	"-"              { return symbol(sym.MINUS); }
	"*"              { return symbol(sym.MULT); }
	"/"              { return symbol(sym.DIV); }
	"%"              { return symbol(sym.MOD); }
	"++"             { return symbol(sym.PLUSPLUS); }
	"--"             { return symbol(sym.MINUSMINUS); }

	"=="             { return symbol(sym.EQEQ); }
	"!="             { return symbol(sym.NOTEQ); }
	">"              { return symbol(sym.GT); }
	"<"              { return symbol(sym.LT); }
	">="             { return symbol(sym.GTEQ); }
	"<="             { return symbol(sym.LTEQ); }

	"&&"             { return symbol(sym.ANDAND); }
	"||"             { return symbol(sym.OROR); }
	"!"              { return symbol(sym.NOT); }

	"="              { return symbol(sym.EQ); }
	"+="             { return symbol(sym.PLUSEQ); }
	"-="             { return symbol(sym.MINUSEQ); }
	"*="             { return symbol(sym.MULTEQ); }
	"/="             { return symbol(sym.DIVEQ); }
	"%="             { return symbol(sym.MODEQ); }
	
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
	\' 							 { yybegin(YYINITIAL); return symbol(sym.CHAR_LITERAL, yytext().charAt(0)); }   /* escape sequences */

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
.|\n               { throw new RuntimeException("Illegal character \"" + yytext()+ "\" at line " + yyline + ", column " + yycolumn); }

/* end of file */
<<EOF>>            { return symbol(sym.EOF); }
