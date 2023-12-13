import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

import jflex.exceptions.SilentExit;

public class MainJflexCup {

    public void generateLexer(String ruta) throws IOException, SilentExit{
        String[] strArr = {ruta};
        jflex.Main.generate(strArr);
    }

    public void runTest(String inputPath) throws IOException{
        Reader reader = new BufferedReader(new FileReader(inputPath));
        reader.read();
    }
    
}
