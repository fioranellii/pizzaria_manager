<%@page import="model.Produto"%>
<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Produto Form</title>
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
            Produto prod = null;
            String action = request.getParameter("action");
            
            String precoFormatado = "";
            
            if (action == null || action.isEmpty()) {
                action = "create";
            } else if (action.equals("update")) {
                int id = Integer.valueOf(request.getParameter("id"));
                prod = new Produto();
                prod.setIdProduto(id);
                prod.load();
                
                if (prod.getPreco() != null) {
                    precoFormatado = prod.getPreco().toString();
                }
            }
        %>
        <div class="form-container">
            <h1><%= action.equals("create") ? "Adicionar Novo Produto" : "Alterar Produto" %></h1>
            <form action="<%= request.getContextPath()%>/home?action=<%= action%>&task=produtos" method="post">
                
                <label for="id_produto">ID:</label>
                <input type="text" id="id_produto" name="id_produto" pattern="\d+" title="Apenas dígitos" value="<%= (prod != null) ? prod.getIdProduto() : "" %>" <%= (prod != null) ? "readonly" : ""%> required>
                
                <label for="nome">Nome / Sabor:</label>
                <input type="text" id="nome" name="nome" value="<%= (prod != null) ? prod.getNome() : ""%>" required>
                
                <label for="preco">Preço (R$):</label>
                <input type="text" id="preco" name="preco" pattern="^\d+(\.\d{1,2})?$" title="Apenas números e, opcionalmente, duas casas decimais (ex: 19.99)" value="<%= precoFormatado %>" required>
                
                <label for="categoria">Categoria:</label>
                <select id="categoria" name="categoria" required>
                    <option value="Pizza" <%= (prod != null && prod.getCategoria().equals("Pizza")) ? "selected" : "" %>>Pizza</option>
                    <option value="Bebida" <%= (prod != null && prod.getCategoria().equals("Bebida")) ? "selected" : "" %>>Bebida</option>
                    <option value="Sobremesa" <%= (prod != null && prod.getCategoria().equals("Sobremesa")) ? "selected" : "" %>>Sobremesa</option>
                    <option value="Outro" <%= (prod != null && prod.getCategoria().equals("Outro")) ? "selected" : "" %>>Outro</option>
                </select>
                
                <input type="submit" value="Salvar Produto">
            </form>
            <a href="<%= request.getContextPath()%>/home/app/vendas/produtos.jsp" class="btn-voltar">Voltar</a>
        </div>
    </body>
</html>