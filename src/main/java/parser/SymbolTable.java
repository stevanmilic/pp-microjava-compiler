package parser;

import rs.etf.pp1.symboltable.Tab;
import rs.etf.pp1.symboltable.concepts.Obj;
import rs.etf.pp1.symboltable.concepts.Struct;

/**
 * Created by stevan on 5/3/17.
 */
public class SymbolTable extends Tab {
    public static final Struct boolType = new Struct(Struct.Bool);

    public static void init() {
        Tab.init();
        currentScope.addToLocals(new Obj(Obj.Type, "bool", boolType));
    }
}
