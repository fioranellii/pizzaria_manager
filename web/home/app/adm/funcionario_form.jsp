<%@page import="model.Funcionario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Funcionário Form</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                color: #333;
                margin: 0;
                padding: 20px;
            }
            .form-container {
                width: 50%;
                margin: 30px auto;
                background-color: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                color: #e74c3c;
                margin-bottom: 25px;
            }
            label {
                display: block;
                margin-top: 15px;
                font-weight: bold;
                color: #333;
            }
            input[type="text"], input[type="email"], input[type="tel"], input[type="password"], input[type="number"], select, textarea {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 16px;
            }
            input[type="submit"] {
                background-color: #27ae60;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                width: 100%;
                margin-top: 30px;
                font-size: 18px;
                transition: background-color 0.3s;
            }
            input[type="submit"]:hover {
                background-color: #229954;
            }
            .btn-voltar {
                display: block;
                width: 100%;
                text-align: center;
                margin-top: 20px;
                padding: 8px;
                background-color: #3498db;
                color: white;
                text-decoration: none;
                border-radius: 4px;
            }
            .btn-voltar:hover {
                background-color: #2980b9;
            }
            .error-message-box {
                color: #c0392b;
                border: 2px solid #e74c3c;
                background-color: #fdd;
                padding: 10px;
                margin-bottom: 20px;
                text-align: center;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <%
            Funcionario func = null;
            String action = request.getParameter("action");
            String msgErro = (String) request.getAttribute("msg_erro");
            Funcionario dadosPreenchidos = (Funcionario) request.getAttribute("func_dados");

            if (action == null || action.isEmpty()) {
                action = "create";
            } else if (action.equals("update")) {
                int id = Integer.valueOf(request.getParameter("id"));
                func = new Funcionario();
                func.setIdFuncionario(id);
                func.load();
            }
            if (dadosPreenchidos != null) {
                func = dadosPreenchidos;
            }
        %>

        <div class="form-container">
            <h1><%= action.equals("create") ? "Adicionar Novo Funcionário" : "Alterar Funcionário"%></h1>

            <% if (msgErro != null) {%>
            <div class="error-message-box">
                <strong><%= msgErro%></strong>
            </div>
            <% }%>

            <form action="<%= request.getContextPath()%>/home?action=<%= action%>&task=funcionarios" method="post">

                <label for="id_funcionario">ID:</label>
                <input type="text" id="id_funcionario" name="id_funcionario" pattern="\d+" title="Apenas dígitos" 
                       value="<%= (func != null) ? func.getIdFuncionario() : ""%>" 
                       <%= (action.equals("update") || msgErro != null) ? "readonly" : ""%> required>

                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="<%= (func != null) ? func.getNome() : ""%>" required>

                <label for="cpf">CPF:</label>
                <input type="text" id="cpf" name="cpf" pattern="\d{3}\.?\d{3}\.?\d{3}-?\d{2}" title="Formato CPF: XXX.XXX.XXX-XX" value="<%= (func != null) ? func.getCpf() : ""%>" required>

                <label for="senha">Senha:</label>
                <input type="password" id="senha" name="senha" placeholder="<%= action.equals("update") ? "Deixe vazio para manter a senha atual" : ""%>" <%= action.equals("create") ? "required" : ""%>>

                <label for="cargo">Cargo:</label>
                <select id="cargo" name="cargo" required>
                    <option value="Atendente" <%= (func != null && "Atendente".equals(func.getCargo())) ? "selected" : ""%>>Atendente</option>
                    <option value="Pizzaiolo" <%= (func != null && "Pizzaiolo".equals(func.getCargo())) ? "selected" : ""%>>Pizzaiolo</option>
                    <option value="Gerente" <%= (func != null && "Gerente".equals(func.getCargo())) ? "selected" : ""%>>Gerente</option>
                </select>

                <input type="submit" value="Salvar Funcionário">
            </form>
            <a href="<%= request.getContextPath()%>/home/app/adm/funcionarios.jsp" class="btn-voltar">Voltar</a>
        </div>
    </body>
</html>