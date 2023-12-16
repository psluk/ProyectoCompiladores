import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class App {
    public static void generateLexerParser() throws Exception {
        String basePath, fullPathLexer, fullPathParser, jlexer, jparser, jlexerFolder;
        MainJflexCup mfjc = new MainJflexCup();

        basePath = System.getProperty("user.dir");
        jlexer = "LexerProject.java";
        jparser = "parser.java";
        jlexerFolder = "SourceParserLexer";

        // If the files already exist, they get deleted
        Files.deleteIfExists(Paths.get(basePath + "\\src\\ParserLexer\\" + jlexer));
        Files.deleteIfExists(Paths.get(basePath + "\\src\\ParserLexer\\" + jparser));
        Files.deleteIfExists(Paths.get(basePath + "\\src\\ParserLexer\\sym.java"));

        fullPathLexer = basePath + "\\src\\SourceParserLexer\\SourceLexer.jflex";
        fullPathParser = basePath + "\\src\\SourceParserLexer\\SourceParser.cup";

        // Uses the generateParserLexer from the MainJflexCup class
        // to generate a lexer and parser
        mfjc.generateParserLexer(fullPathLexer, fullPathParser);

        // The files sym.java, parser.java and LexerProject.java
        // get placed in the ParserLexer folder
        Files.move(Paths.get(basePath + "\\sym.java"), Paths.get(basePath + "\\src\\ParserLexer\\sym.java"));
        Files.move(Paths.get(basePath + "\\" + jparser), Paths.get(basePath + "\\src\\ParserLexer\\" + jparser));
        Files.move(Paths.get(basePath + "\\src\\" + jlexerFolder + "\\" + jlexer),
                Paths.get(basePath + "\\src\\ParserLexer\\" + jlexer));
    }

    // runTest reads the file testCode.txt located in the
    // TestFiles folder and generates output.txt
    public static void runTest() throws IOException {
        String basePath;

        MainJflexCup mfjc = new MainJflexCup();

        basePath = System.getProperty("user.dir");

        mfjc.runTest(basePath + "\\src\\TestFiles\\testCode.txt",
                basePath + "\\src\\TestFiles\\output.txt");
    }

    public static void main(String[] args) throws Exception {
        generateLexerParser();
        runTest();
    }
}