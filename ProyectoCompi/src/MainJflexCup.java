import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java_cup.internal_error;
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

    public void runTest(String inputPath) throws IOException {
        Reader reader = new BufferedReader(new FileReader(inputPath));
        reader.read();

        parser parser;

        // TODO: // Here would be the code to run the lexer

        reader.close();
    }

}
