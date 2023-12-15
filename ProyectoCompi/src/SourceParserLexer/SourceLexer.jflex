/* JFlex example: partial Java language lexer specification */
package ParserLexer;
import java_cup.runtime.*;
import java.io.FileWriter;
import java.io.IOException;

/**
    * This is a JFlex specification for a lexer that recognizes a test language
    */
%%

%public
%class LexerProject
%unicode
%cup
%line
%column

%{
    StringBuffer string = new StringBuffer();

    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }

    public int getLine() {
        return yyline + 1; // +1 because the line index starts in 0
    }

    public int getColumn() {
        return yycolumn + 1; // +1 because the column index starts in 0
    }

    // Adds a writer to write the errors in the output file,
    // which requires to add another constructor to the lexer
    private FileWriter writer;
    public LexerProject(java.io.Reader in, FileWriter out) {
        this.zzReader = in;
        this.writer = out;
    }
%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

TraditionalComment   = "/_" [^_] ~"_/" | "/_" "_"+ "/"
// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "@" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/__" {CommentContent} "_"+ "/"
CommentContent       = ( [^_] | \_+ [^/_] )*

Identifier = [:jletter:] [:jletterdigit:]*

HexDigit = [0-9a-fA-F]
    // To use in CharLiteral, for Unicode escape sequences

/* literals */
DecIntegerLiteral = -? (0 | [1-9][0-9]*)
FloatLiteral      = {DecIntegerLiteral}? \. [0-9]+ ([eE] [+-]? [0-9]+)?
                    | {DecIntegerLiteral} [eE] [+-]? [0-9]+
                    | {DecIntegerLiteral} \.
    // Similar to DecIntegerLiteral, but with a decimal point and optional exponent
BooleanLiteralT   = "true"
BooleanLiteralF   = "false"
CharLiteral       = \' ( [^\'\\\n\r] | \\ u {HexDigit} {HexDigit} {HexDigit} {HexDigit} ) \'
    // The second alternative is for Unicode escape sequences

%state STRING

%%

/* keywords */
<YYINITIAL> "boolean"            { return symbol(sym.COLACHO); }
<YYINITIAL> "int"                { return symbol(sym.SANNICOLAS); }
<YYINITIAL> "float"              { return symbol(sym.SINTERKLAAS); }
<YYINITIAL> "char"               { return symbol(sym.PAPANOEL); }
<YYINITIAL> "string"             { return symbol(sym.DEDMOROZ); }

<YYINITIAL> {
    
    /* literals */
    {DecIntegerLiteral}            { return symbol(sym.l_SANNICOLAS); }
    {FloatLiteral}                 { return symbol(sym.l_SINTERKLAAS); }
    {BooleanLiteralT}              { return symbol(sym.l_tCOLACHO); }
    {BooleanLiteralF}              { return symbol(sym.l_fCOLACHO); }
    {CharLiteral}                  { return symbol(sym.l_PAPANOEL); }
    \"                             { string.setLength(0); yybegin(STRING); }
    

    /* operators */
    /* assignment */
    "<="                           { return symbol(sym.ENTREGA); }

    /* binary */
    "+"                            { return symbol(sym.RODOLFO); }
    "-"                            { return symbol(sym.BRIOSO); }
    "**"                           { return symbol(sym.DANZARIN); }
    "*"                            { return symbol(sym.BROMISTA); }
    "/"                            { return symbol(sym.COMETA); }
    "~"                            { return symbol(sym.CUPIDO); }

    /* relational */
    "<"                            { return symbol(sym.CANALLA); }
    "<=="                          { return symbol(sym.CHISPA); }
    ">"                            { return symbol(sym.BUFON); }
    ">="                           { return symbol(sym.ASTUTO); }
    "=="                           { return symbol(sym.COPODENIEVE); }
    "!="                           { return symbol(sym.FELICIDAD); }

    /* unary */
    "++"                           { return symbol(sym.GRINCH); }
    "--"                           { return symbol(sym.QUIEN); }

    /* logical */
    "^"                            { return symbol(sym.MELCHOR); }
    "#"                            { return symbol(sym.GASPAR); }
    "!"                            { return symbol(sym.BALTASAR); }

    /* expressions */
    "{"                            { return symbol(sym.ABREREGALO); }
    "}"                            { return symbol(sym.CIERRAREGALO); }
    "("                            { return symbol(sym.ABRECUENTO); }
    ")"                            { return symbol(sym.CIERRACUENTO); }
    "|"                            { return symbol(sym.FINREGALO); }

    /* control */
    "if"                           { return symbol(sym.ELFO); }
    "elif"                         { return symbol(sym.HADA); }
    "else"                         { return symbol(sym.DUENDE); }
    "for"                          { return symbol(sym.ENVUELVE); }
    "do"                           { return symbol(sym.HACE); }
    "until"                        { return symbol(sym.REVISA); }
    "return"                       { return symbol(sym.ENVIA); }
    "break"                        { return symbol(sym.CORTA); }

    /* I/O */
    "print"                        { return symbol(sym.NARRA); }
    "read"                         { return symbol(sym.ESCUCHA); }

    /* functions */
    ","                            { return symbol(sym.ADORNO); }

    /* identifiers */ 
    {Identifier}                   { return symbol(sym.PERSONA); }

    /* comments */
    {Comment}                      { /* ignore */ }
    
    /* whitespace */
    {WhiteSpace}                   { /* ignore */ }
}

<STRING> {
    \"                             { yybegin(YYINITIAL); 
                                    return symbol(sym.l_DEDMOROZ, 
                                    string.toString()); }
    [^\n\r\"\\]+                   { string.append( yytext() ); }
    \\t                            { string.append('\t'); }
    \\n                            { string.append('\n'); }

    \\r                            { string.append('\r'); }
    \\\"                           { string.append('\"'); }
    \\                             { string.append('\\'); }
}

/* error fallback */
// Writes an error message in the output file
[^] {
    try {
        System.out.println("ERROR: Carácter ilegal <" + yytext() + "> en la línea " + (yyline + 1) + ", columna " + (yycolumn + 1));
        writer.write("ERROR: Carácter ilegal <" + yytext() + "> en la línea " + (yyline + 1) + ", columna " + (yycolumn + 1) + "\n");
    } catch (IOException e) {
        System.out.println("Error al escribir en el archivo de salida: " + e.getMessage());
    }
}