/*
 * This Java source file was generated by the Gradle 'init' task.
 */
import java_cup.runtime.Symbol;
import lexer.Lexer;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Test;
import lexer.sym;

import java.io.*;

public class AppTest {

    private static final Logger logger = LogManager.getLogger(AppTest.class);

    @Test
    public void testLexer() {
        try(BufferedReader reader = new BufferedReader(new FileReader("src/test/resources/program.mj"))){

            logger.info("Beginning lexical analysis on file: program.mj");

            Lexer lexer = new Lexer(reader);

            for(Symbol symbol = lexer.next_token(); symbol.sym != sym.EOF; symbol = lexer.next_token()){
               logger.info("Token: " + symbol.value.toString());
            }

            logger.info("No errors!");

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
