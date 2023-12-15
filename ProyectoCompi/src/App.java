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

        Files.deleteIfExists(Paths.get(basePath + "\\src\\ParserLexer\\" + jlexer));
        Files.deleteIfExists(Paths.get(basePath + "\\src\\ParserLexer\\" + jparser));
        Files.deleteIfExists(Paths.get(basePath + "\\src\\ParserLexer\\sym.java"));

        fullPathLexer = basePath + "\\src\\SourceParserLexer\\SourceLexer.jflex";
        fullPathParser = basePath + "\\src\\SourceParserLexer\\SourceParser.cup";

        mfjc.generateParserLexer(fullPathLexer, fullPathParser);

        Files.move(Paths.get(basePath + "\\sym.java"), Paths.get(basePath + "\\src\\ParserLexer\\sym.java"));
        Files.move(Paths.get(basePath + "\\" + jparser), Paths.get(basePath + "\\src\\ParserLexer\\" + jparser));
        Files.move(Paths.get(basePath + "\\src\\" + jlexerFolder + "\\" + jlexer),
                Paths.get(basePath + "\\src\\ParserLexer\\" + jlexer));
    }

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