<%@page import="model.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cliente Form</title>
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
            input[type="text"], input[type="email"], input[type="tel"], input[type="number"], textarea {
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
        </style>
    </head>
    <body>
        <%
            Cliente cli = null;
            String action = request.getParameter("action");
            
            if (action == null || action.isEmpty()) {
                action = "create";
            } else if (action.equals("update")) {
                int id = Integer.valueOf(request.getParameter("id"));
                cli = new Cliente();
                cli.setIdCliente(id);
                cli.load();
            }
        %>
        
        <div class="form-container">
            <h1><%= action.equals("create") ? "Adicionar Novo Cliente" : "Alterar Cliente" %></h1>
            
            <form action="<%= request.getContextPath()%>/home?action=<%= action%>&task=clientes" method="post">
                
                <label for="id_cliente">ID:</label>
                <input type="text" id="id_cliente" name="id_cliente" pattern="\d+" title="Apenas dígitos" 
                       value="<%= (cli != null) ? cli.getIdCliente() : "" %>" 
                       <%= (cli != null) ? "readonly" : ""%> required>
                
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="<%= (cli != null) ? cli.getNome() : ""%>" required>
                
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= (cli != null) ? cli.getEmail() : ""%>" required>
                
                <label for="telefone">Telefone:</label>
                <input type="tel" id="telefone" name="telefone" value="<%= (cli != null) ? cli.getTelefone() : ""%>" required>
                
                <label for="endereco">Endereço:</label>
                <textarea id="endereco" name="endereco" rows="3" required><%= (cli != null) ? cli.getEndereco() : ""%></textarea>
                
                <input type="submit" value="Salvar Cliente">
            </form>
            <a href="<%= request.getContextPath()%>/home/app/geral/clientes.jsp" class="btn-voltar">Voltar</a>
        </div>
    </body>
</html>
