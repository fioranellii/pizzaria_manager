package model;

import java.util.ArrayList;
import model.framework.DataAccessObject;

public class ItemPedido extends DataAccessObject {

    private int idPedido;
    private int idProduto;
    private int quantidade;
    private String observacao;

    public ItemPedido() {
        super("ITEM_PEDIDO");
    }

    public int getIdPedido() {
        return idPedido;
    }

    public int getIdProduto() {
        return idProduto;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
        addChange("id_pedido", this.idPedido);
    }

    public void setIdProduto(int idProduto) {
        this.idProduto = idProduto;
        addChange("id_produto", this.idProduto);
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
        addChange("quantidade", this.quantidade);
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
        addChange("oservacao", this.observacao);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return " id_pedido = " + getIdPedido() + " AND id_produto = " + getIdProduto();
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        idPedido = (int) data.get(0);
        idProduto = (int) data.get(1);
        quantidade = (int) data.get(2);
        observacao = (String) data.get(3);

        return this;
    }

    @Override
    protected ItemPedido copy() {
        ItemPedido cp = new ItemPedido();

        cp.idPedido = getIdPedido();
        cp.idProduto = getIdProduto();
        cp.quantidade = getQuantidade();
        cp.observacao = getObservacao();

        cp.setNovelEntity(false);

        return cp;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof ItemPedido) {
            ItemPedido aux = (ItemPedido) obj;
            return (getIdPedido() == aux.getIdPedido() && getIdProduto() == aux.getIdProduto());
        }
        return false;
    }
}
