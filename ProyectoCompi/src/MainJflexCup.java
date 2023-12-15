import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;
import java_cup.internal_error;
import java_cup.runtime.Symbol;
import jflex.exceptions.SilentExit;
import ParserLexer.*;

public class MainJflexCup {

    public void generateLexer(String path) throws IOException, SilentExit {
        String[] strArr = { path };
        jflex.Main.generate(strArr);
    }

    public void generateParser(String path) throws internal_error, Exception, IOException {
        String[] strArr = { path };
        java_cup.Main.main(strArr);
    }

    public void generateParserLexer(String lexerPath, String parserPath) throws Exception {
        generateLexer(lexerPath);
        generateParser(parserPath);
    }

    public void runTest(String inputPath, String outputPath) throws IOException {
        Reader reader = new BufferedReader(new FileReader(inputPath));
        reader.read();
        FileWriter writer = new FileWriter(outputPath);

        // LexerProject writes errors in the same output file, so the constructor
        // receives the same writer
        LexerProject lexer = new LexerProject(reader, writer);
        int i = 0;
        Symbol token;
        while (true) {
            token = lexer.next_token();
            if (token.sym != 0) {
                writer.write("Línea: " + lexer.getLine() + "\tColumna: " + lexer.getColumn() + "\tToken: " + token.sym
                        + "\tNombre: " + sym.terminalNames[token.sym] + "\tValor: "
                        + (token.value == null ? lexer.yytext() : token.value.toString()) + "\n");
            } else {
                System.out.println("Cantidad de lexemas encontrados: " + i);
                writer.write("Cantidad de lexemas encontrados: " + i);
                break;
            }
            i++;
        }

        // Close the reader and writer
        reader.close();
        writer.close();

        System.out.println("----------------------------------------------------");
        System.out.println("Archivo generado en: " + outputPath);
    }

}
