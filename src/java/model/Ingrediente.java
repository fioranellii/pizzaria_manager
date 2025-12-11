package model;

import java.util.ArrayList;
import model.framework.DataAccessObject;

public class Ingrediente extends DataAccessObject {
    
    private int idIngrediente;
    private String nome;
    private int quantidadeEstoque;
    private String unidadeMedida;

    public Ingrediente() {
        super("ingredientes");
    }

    public int getIdIngrediente() {
        return idIngrediente;
    }

    public String getNome() {
        return nome;
    }

    public int getQuantidadeEstoque() {
        return quantidadeEstoque;
    }

    public String getUnidadeMedida() {
        return unidadeMedida;
    }

    public void setIdIngrediente(int idIngrediente) {
        this.idIngrediente = idIngrediente;
        addChange("id_ingrediente", this.idIngrediente);
    }

    public void setNome(String nome) {
        this.nome = nome;
        addChange("nome", this.nome);
    }

    public void setQuantidadeEstoque(int quantidadeEstoque) {
        this.quantidadeEstoque = quantidadeEstoque;
        addChange("quantidade_estoque", this.quantidadeEstoque); 
    }

    public void setUnidadeMedida(String unidadeMedida) {
        this.unidadeMedida = unidadeMedida;
        addChange("unidade_medida", this.unidadeMedida);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return " id_ingrediente = " + getIdIngrediente();
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        idIngrediente = (int) data.get(0);
        nome = (String) data.get(1);
        quantidadeEstoque = ((Number) data.get(2)).intValue(); 
        unidadeMedida = (String) data.get(3);
        
        return this;
    }

    @Override
    protected Ingrediente copy() {
        Ingrediente cp = new Ingrediente();
        
        cp.idIngrediente = getIdIngrediente();
        cp.nome = getNome();
        cp.quantidadeEstoque = getQuantidadeEstoque();
        cp.unidadeMedida = getUnidadeMedida();
        
        cp.setNovelEntity(false);
        
        return cp;
    }
    
    @Override
    public boolean equals(Object obj) {
        if( obj instanceof Ingrediente ) {
            Ingrediente aux = (Ingrediente) obj;
            return getIdIngrediente() == aux.getIdIngrediente();
        }
        return false;
    }
}
