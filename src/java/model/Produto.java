package model;

import java.math.BigDecimal;
import java.util.ArrayList;
import model.framework.DataAccessObject;

public class Produto extends DataAccessObject {
    
    private int idProduto;
    private String nome;
    private BigDecimal preco;
    private String categoria;

    public Produto() {
        super("produtos");
    }

    public int getIdProduto() {
        return idProduto;
    }

    public String getNome() {
        return nome;
    }

    public BigDecimal getPreco() {
        return preco;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setIdProduto(int idProduto) {
        this.idProduto = idProduto;
        addChange("id_produto", this.idProduto);
    }

    public void setNome(String nome) {
        this.nome = nome;
        addChange("nome", this.nome);
    }

    public void setPreco(BigDecimal preco) {
        this.preco = preco;
        addChange("preco", this.preco);
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
        addChange("categoria", this.categoria);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return " id_produto = " + getIdProduto();
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        idProduto = (int) data.get(0);
        nome = (String) data.get(1);
        preco = (BigDecimal) data.get(2);
        categoria = (String) data.get(3);
        
        return this;
    }

    @Override
    protected Produto copy() {
        Produto cp = new Produto();
        
        cp.idProduto = getIdProduto();
        cp.nome = getNome();
        cp.preco = getPreco();
        cp.categoria = getCategoria();
        
        cp.setNovelEntity(false);
        
        return cp;
    }
    
    @Override
    public boolean equals(Object obj) {
        if( obj instanceof Produto ) {
            Produto aux = (Produto) obj;
            return getIdProduto() == aux.getIdProduto();
        }
        return false;
    }
}
