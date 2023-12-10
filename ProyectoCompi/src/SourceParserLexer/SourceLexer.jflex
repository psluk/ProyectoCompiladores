/* JFlex example: partial Java language lexer specification */
import java_cup.runtime.*;

/**
    * This is a JFlex specification for a lexer that recognizes a test language
    */
%%

%class Lexer
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
%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*

Identifier = [:jletter:] [:jletterdigit:]*

HexDigit = [0-9a-fA-F]
    // To use in CharLiteral, for Unicode escape sequences

/* literals */
DecIntegerLiteral = -? (0 | [1-9][0-9])*
FloatLiteral      = {DecIntegerLiteral} \. [0-9]+ ([eE] [+-]? [0-9]+)?
    // Similar to DecIntegerLiteral, but with a decimal point and optional exponent
BooleanLiteral    = "true" | "false"
CharLiteral       = \' ( [^\'\\\n\r] | \\ u {HexDigit} {HexDigit} {HexDigit} {HexDigit} ) \'
    // The second alternative is for Unicode escape sequences

%state STRING

%%

/* keywords */
<YYINITIAL> "abstract"           { return symbol(sym.ABSTRACT); }
<YYINITIAL> "boolean"            { return symbol(sym.BOOLEAN); }
<YYINITIAL> "break"              { return symbol(sym.BREAK); }
<YYINITIAL> "int"                { return symbol(sym.INT); }
<YYINITIAL> "float"              { return symbol(sym.FLOAT); }
<YYINITIAL> "boolean"            { return symbol(sym.BOOLEAN); }
<YYINITIAL> "char"               { return symbol(sym.CHAR); }
<YYINITIAL> "string"             { return symbol(sym.STRING); }

<YYINITIAL> {
    /* identifiers */ 
    {Identifier}                   { return symbol(sym.IDENTIFIER); }
    
    /* literals */
    {DecIntegerLiteral}            { return symbol(sym.INTEGER_LITERAL); }
    \"                             { string.setLength(0); yybegin(STRING); }
    

    /* operators */
    /* binary */
    "<="                           { return symbol(sym.EQ); }
    "+"                            { return symbol(sym.PLUS); }
    "-"                            { return symbol(sym.MINUS); }
    "**"                           { return symbol(sym.POWER); }
    "*"                            { return symbol(sym.TIMES); }
    "/"                            { return symbol(sym.DIVIDE); }
    "~"                            { return symbol(sym.MOD); }

    /* relational */
    "<"                            { return symbol(sym.LT); }
    "<=="                          { return symbol(sym.EQEQ); }
    ">"                            { return symbol(sym.GT); }
    ">="                           { return symbol(sym.GTEQ); }
    "=="                           { return symbol(sym.EQEQ); }
    "!="                           { return symbol(sym.NOTEQ); }

    /* unary */
    "++"                           { return symbol(sym.INC); }
    "--"                           { return symbol(sym.DEC); }

    /* logical */
    "^"                            { return symbol(sym.AND); }
    "#"                            { return symbol(sym.OR); }
    "!"                            { return symbol(sym.NOT); }

    /* comments */
    {Comment}                      { /* ignore */ }
    
    /* whitespace */
    {WhiteSpace}                   { /* ignore */ }
}

<STRING> {
    \"                             { yybegin(YYINITIAL); 
                                    return symbol(sym.STRING_LITERAL, 
                                    string.toString()); }
    [^\n\r\"\\]+                   { string.append( yytext() ); }
    \\t                            { string.append('\t'); }
    \\n                            { string.append('\n'); }

    \\r                            { string.append('\r'); }
    \\\"                           { string.append('\"'); }
    \\                             { string.append('\\'); }
}

/* error fallback */
[^]                              { throw new Error("Illegal character <"+
                                                    yytext()+">"); }