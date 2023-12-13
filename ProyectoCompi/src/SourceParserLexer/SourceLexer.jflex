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
BooleanLiteralT   = "true"
BooleanLiteralT   = "false"
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
<YYINITIAL> "break"              { return symbol(sym.JOULUPUKKI); }

<YYINITIAL> {
    /* identifiers */ 
    {Identifier}                   { return symbol(sym.PERSONA); }
    
    /* literals */
    {DecIntegerLiteral}            { return symbol(sym.l_SANNICOLAS); }
    {FloatLiteral}                 { return symbol(sym.l_SINTERKLAAS); }
    {BooleanLiteralT}              { return symbol(sym.l_COLACHO); }
    {BooleanLiteralF}              { return symbol(sym.l_COLACHO); }
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
[^]                              { throw new Error("Illegal character <"+
                                                    yytext()+">"); }