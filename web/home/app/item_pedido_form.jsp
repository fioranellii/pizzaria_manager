<%@page import="model.ItemPedido"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Item do Pedido Form</title>
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
        </style>
    </head>
    <body>
        <%
            ItemPedido item = null;
            String action = request.getParameter("action");
            
            int idPedido = 0;
            int idProduto = 0;

            if (action == null || action.isEmpty()) {
                action = "create";
            } 
            
            try {
                idPedido = Integer.valueOf(request.getParameter("id_pedido"));
            } catch (NumberFormatException e) {
            }
            
            if (action.equals("update")) {
                try {
                    idProduto = Integer.valueOf(request.getParameter("id_produto"));
                    
                    item = new ItemPedido();
                    item.setIdPedido(idPedido);
                    item.setIdProduto(idProduto);
                    item.load();
                } catch (NumberFormatException e) {
                }
            }
        %>
        <div class="form-container">
            <h1><%= action.equals("create") ? "Adicionar Item ao Pedido #" + idPedido : "Alterar Item do Pedido #" + idPedido %></h1>
            <form action="<%= request.getContextPath()%>/home?action=<%= action%>&task=itens_pedido" method="post">
                
                <label for="id_pedido">ID do Pedido:</label>
                <input type="text" id="id_pedido" name="id_pedido" value="<%= idPedido %>" readonly required>
                
                <label for="id_produto">ID do Produto:</label>
                <input type="text" id="id_produto" name="id_produto" pattern="\d+" title="Apenas dígitos" value="<%= (item != null) ? item.getIdProduto() : idProduto %>" <%= (item != null) ? "readonly" : ""%> required>

                <label for="quantidade">Quantidade:</label>
                <input type="number" id="quantidade" name="quantidade" min="1" value="<%= (item != null) ? item.getQuantidade() : "1"%>" required>
                
                <label for="observacao">Observações (Sem Cebola, etc.):</label>
                <textarea id="observacao" name="observacao" rows="2"><%= (item != null) ? item.getObservacao() : ""%></textarea>
                
                <input type="submit" value="Salvar Item">
            </form>
            <a href="<%= request.getContextPath()%>/home/app/itens_pedido.jsp?id_pedido=<%= idPedido %>" class="btn-voltar">Voltar para Detalhes do Pedido</a>
        </div>
    </body>
</html>