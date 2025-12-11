package model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import model.framework.DataAccessObject;
import java.time.LocalDateTime;
import java.time.ZoneId;

public class Pedido extends DataAccessObject {
    
    private int idPedido;
    private Date dtHora;
    private BigDecimal valorTotal;
    private String status;
    private int idCliente;
    private int idFuncionario;

    public Pedido() {
        super("pedidos");
    }

    public int getIdPedido() {
        return idPedido;
    }

    public Date getDtHora() {
        return dtHora;
    }

    public BigDecimal getValorTotal() {
        return valorTotal;
    }

    public String getStatus() {
        return status;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public int getIdFuncionario() {
        return idFuncionario;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
        addChange("id_pedido", this.idPedido);
    }

    public void setDtHora(Date dtHora) {
        this.dtHora = dtHora;
        addChange("dt_hora", this.dtHora);
    }

    public void setValorTotal(BigDecimal valorTotal) {
        this.valorTotal = valorTotal;
        addChange("valor_total", this.valorTotal);
    }

    public void setStatus(String status) {
        this.status = status;
        addChange("status", this.status);
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
        addChange("id_cliente", this.idCliente);
    }

    public void setIdFuncionario(int idFuncionario) {
        this.idFuncionario = idFuncionario;
        addChange("id_funcionario", this.idFuncionario);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return " id_pedido = " + getIdPedido();
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        idPedido = (int) data.get(0);
        
        LocalDateTime localDateTime = (LocalDateTime) data.get(1);
        dtHora = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
        valorTotal = (BigDecimal) data.get(2);
        status = (String) data.get(3);
        idCliente = (int) data.get(4);
        idFuncionario = (int) data.get(5);
        
        return this;
    }

    @Override
    protected Pedido copy() {
        Pedido cp = new Pedido();
        
        cp.idPedido = getIdPedido();
        cp.dtHora = getDtHora();
        cp.valorTotal = getValorTotal();
        cp.status = getStatus();
        cp.idCliente = getIdCliente();
        cp.idFuncionario = getIdFuncionario();
        
        cp.setNovelEntity(false);
        
        return cp;
    }
    
    @Override
    public boolean equals(Object obj) {
        if( obj instanceof Pedido ) {
            Pedido aux = (Pedido) obj;
            return getIdPedido() == aux.getIdPedido();
        }
        return false;
    }
}