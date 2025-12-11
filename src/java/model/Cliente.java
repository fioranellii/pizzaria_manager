package model;

import java.util.ArrayList;
import model.framework.DataAccessObject;

public class Cliente extends DataAccessObject {
    
    private int idCliente;
    private String nome;
    private String email;
    private String telefone;
    private String endereco;

    public Cliente() {
        super("cliente");
    }
    
    public int getIdCliente() {
        return idCliente;
    }

    public String getNome() {
        return nome;
    }

    public String getEmail() {
        return email;
    }

    public String getTelefone() {
        return telefone;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
        addChange("id_cliente", this.idCliente);
    }

    public void setNome(String nome) {
        this.nome = nome;
        addChange("nome", this.nome);
    }

    public void setEmail(String email) {
        this.email = email;
        addChange("email", this.email);
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
        addChange("telefone", this.telefone);
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
        addChange("endereco", this.endereco);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return " id_cliente = " + getIdCliente();
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        idCliente = (int) data.get(0);
        nome = (String) data.get(1);
        email = (String) data.get(2);
        telefone = (String) data.get(3);
        endereco = (String) data.get(4);
        
        return this;
    }

    @Override
    protected Cliente copy() {
        Cliente cp = new Cliente();
        
        cp.idCliente = getIdCliente();
        cp.nome = getNome();
        cp.email = getEmail();
        cp.telefone = getTelefone();
        cp.endereco = getEndereco();
        
        cp.setNovelEntity(false);
        
        return cp;
    }
    
    @Override
    public boolean equals(Object obj) {
        if( obj instanceof Cliente ) {
            Cliente aux = (Cliente) obj;
            return getIdCliente() == aux.getIdCliente();
        }
        return false;
    }
}