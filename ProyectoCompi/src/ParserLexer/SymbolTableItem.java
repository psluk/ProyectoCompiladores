package ParserLexer;

// This class represents an item in the symbol table
public class SymbolTableItem {
    private String name;
    private String type;
    private String category;
    private int lineNumber;
    private int columnNumber;

    public SymbolTableItem(String name, String type, String category, int lineNumber, int columnNumber) {
        this.name = name;
        this.type = type;
        this.category = category;
        this.lineNumber = lineNumber;
        this.columnNumber = columnNumber;
    }

    // Getters
    public String getName() {
        return name;
    }

    public String getType() {
        return type;
    }

    public String getCategory() {
        return category;
    }

    public int getLineNumber() {
        return lineNumber;
    }

    public int getColumnNumber() {
        return columnNumber;
    }

    public String toString() {
        return name + "\t" + type + "\t" + category + "\t" + lineNumber + "\t" + columnNumber;
    }

    static public String getFields() {
        return "Nombre\tTipo\tCategoría\tLínea\tColumna";
    }
}
