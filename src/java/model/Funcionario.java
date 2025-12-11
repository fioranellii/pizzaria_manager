package model;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.ArrayList;
import model.framework.DataAccessObject;

public class Funcionario extends DataAccessObject {

    private int idFuncionario;
    private String nome;
    private String cpf;
    private String senha;
    private String cargo;

    public Funcionario() {
        super("FUNCIONARIOS");
    }

    public int getIdFuncionario() {
        return idFuncionario;
    }

    public String getNome() {
        return nome;
    }

    public String getCpf() {
        return cpf;
    }

    public String getSenha() {
        return senha;
    }

    public String getCargo() {
        return cargo;
    }

    public void setIdFuncionario(int idFuncionario) {
        this.idFuncionario = idFuncionario;
        addChange("id_funcionario", this.idFuncionario);
    }

    public void setNome(String nome) {
        this.nome = nome;
        addChange("nome", this.nome);
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
        addChange("cpf", this.cpf);
    }
    
public void setSenha(String senha) throws Exception {
    
    if (senha == null || senha.trim().isEmpty()) {
        return; 
    }
    if (!senha.equals(this.senha)) {

        String senhaSal = getIdFuncionario() + senha + (getIdFuncionario() / 2);

        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hashBytes = md.digest(senhaSal.getBytes("UTF-8"));
        
        String hash = new BigInteger(1, hashBytes).toString(16);
        
        while (hash.length() < 64) {
            hash = "0" + hash;
        }

        this.senha = hash;
        
        addChange("senha", this.senha);
    }
}

    public void setCargo(String cargo) {
        this.cargo = cargo;
        addChange("cargo", this.cargo);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return " id_funcionario = " + getIdFuncionario();
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        idFuncionario = (int) data.get(0);
        nome = (String) data.get(1);
        cpf = (String) data.get(2);
        senha = (String) data.get(3);
        cargo = (String) data.get(4);

        return this;
    }

    @Override
    protected Funcionario copy() {
        Funcionario cp = new Funcionario();

        cp.idFuncionario = getIdFuncionario();
        cp.nome = getNome();
        cp.cpf = getCpf();
        cp.senha = getSenha();
        cp.cargo = getCargo();

        cp.setNovelEntity(false);

        return cp;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Funcionario) {
            Funcionario aux = (Funcionario) obj;
            return getIdFuncionario() == aux.getIdFuncionario();
        }
        return false;
    }
}
