package lexer;

public class sym {

	// Keywords
	public static final int PROGRAM = 1;
	public static final int BREAK = 2;
	public static final int CLASS = 3;
	public static final int ELSE = 4;
	public static final int CONST = 5;
	public static final int IF = 6;
	public static final int NEW = 7;
	public static final int PRINT = 8;
	public static final int READ = 9;
	public static final int RETURN = 10;
	public static final int VOID = 11;
	public static final int FOR = 12;
	public static final int EXTENDS = 13;
	public static final int CONTINUE = 14;
	public static final int STATIC = 15;

	// Identifiers
	public static final int IDENTIFIER = 16;
	
	// Literals
	public static final int INTEGER_LITERAL = 17;
	public static final int CHAR_LITERAL = 18;
	public static final int BOOL_LITERAL = 19;

	//Separators
    public static final int SEMICOLON = 20;
    public static final int COMMA = 21;
    public static final int DOT = 22;
    public static final int LPAREN = 23;
    public static final int RPAREN = 24;
    public static final int LBRACK = 25;
    public static final int RBRACK = 26;
    public static final int LBRACE = 27;
    public static final int RBRACE = 28;

	// Arithmetic Operators
	public static final int PLUS = 29;
    public static final int MINUS = 30;
    public static final int MULT = 31;
    public static final int DIV = 32;
    public static final int MOD = 33;
    public static final int PLUSPLUS = 34;
    public static final int MINUSMINUS = 35;

    // Relational Operators
    public static final int EQEQ = 36;
    public static final int NOTEQ = 37;
    public static final int GT = 38;
    public static final int LT = 39;
    public static final int GTEQ = 40;
	public static final int LTEQ = 41;

	// Logical Operators
	public static final int ANDAND = 42;
	public static final int OROR = 43;

	// Assignment Operators
	public static final int EQ = 44;
	public static final int PLUSEQ = 45;
    public static final int MINUSEQ = 46;
    public static final int MULTEQ = 47;
    public static final int DIVEQ = 48;
    public static final int MODEQ = 49;

	public static final int EOF = 50;
}
