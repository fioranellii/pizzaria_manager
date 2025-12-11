<%@page import="model.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cliente Form</title>
        <style>
            /* ... (Seu CSS aqui) ... */
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
                // NOTA: No modo update, cli.getIdCliente() terá o valor carregado
            }
            // NOTA: No modo create, cli permanece null, e o ID será inserido pelo usuário
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
            <a href="<%= request.getContextPath()%>/home/app/clientes.jsp" class="btn-voltar">Voltar</a>
        </div>
    </body>
</html>