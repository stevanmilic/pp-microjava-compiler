package symboltablext;

import symboltablext.visitors.DumpSymbolTableVisitorExtended;
import parser.Parser;
import rs.etf.pp1.symboltable.Tab;
import rs.etf.pp1.symboltable.concepts.Obj;
import rs.etf.pp1.symboltable.concepts.Scope;
import rs.etf.pp1.symboltable.concepts.Struct;
import rs.etf.pp1.symboltable.visitors.SymbolTableVisitor;

/**
 * Created by stevan on 5/3/17.
 */
public class SymbolTable extends Tab {
    public static final Struct boolType = new Struct(Struct.Bool);


    public static void init() {
        Tab.init();
        currentScope.addToLocals(new Obj(Obj.Type, "bool", boolType));
    }

    public static void dump(SymbolTableVisitor symbolTableVisitor) {
        Parser.logger.info("============= SYMBOL TABLE DUMP =============");
        if (symbolTableVisitor == null)
            symbolTableVisitor = new DumpSymbolTableVisitorExtended();
        for (Scope s = currentScope; s != null; s = s.getOuter()) {
            s.accept(symbolTableVisitor);
        }
        Parser.logger.info(symbolTableVisitor.getOutput());
    }

    public static void dump() {
        dump(null);
    }

    public static Obj findInScope(String symbolName) {
        Obj resultObj = SymbolTable.currentScope.findSymbol(symbolName);
        return (resultObj != null) ? resultObj : noObj;
    }
    public static boolean isMain(Obj obj) {
        if(obj.getKind() == Obj.Meth && obj.getName().equals("main")) {
            return true;
        }
        return false;
    }
}
