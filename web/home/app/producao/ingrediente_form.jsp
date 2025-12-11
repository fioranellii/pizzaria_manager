<%@page import="model.Ingrediente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingrediente Form</title>
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
            Ingrediente ing = null;
            String action = request.getParameter("action");
            
            if (action == null || action.isEmpty()) {
                action = "create";
            } else if (action.equals("update")) {
                int id = Integer.valueOf(request.getParameter("id"));
                ing = new Ingrediente();
                ing.setIdIngrediente(id);
                ing.load();
            }
        %>
        <div class="form-container">
            <h1><%= action.equals("create") ? "Adicionar Novo Ingrediente" : "Alterar Ingrediente" %></h1>
            <form action="<%= request.getContextPath()%>/home?action=<%= action%>&task=ingredientes" method="post">
                
                <label for="id_ingrediente">ID:</label>
                <input type="text" id="id_ingrediente" name="id_ingrediente" pattern="\d+" title="Apenas dígitos" value="<%= (ing != null) ? ing.getIdIngrediente() : "" %>" <%= (ing != null) ? "readonly" : ""%> required>
                
                <label for="nome">Nome do Ingrediente:</label>
                <input type="text" id="nome" name="nome" value="<%= (ing != null) ? ing.getNome() : ""%>" required>
                
                <label for="quantidade_estoque">Quantidade em Estoque:</label>
                <input type="number" id="quantidade_estoque" name="quantidade_estoque" min="0" title="Apenas números inteiros positivos" value="<%= (ing != null) ? ing.getQuantidadeEstoque() : ""%>" required>
                
                <label for="unidade_medida">Unidade de Medida:</label>
                <select id="unidade_medida" name="unidade_medida" required>
                    <option value="kg" <%= (ing != null && ing.getUnidadeMedida().equals("kg")) ? "selected" : "" %>>Kilograma (kg)</option>
                    <option value="g" <%= (ing != null && ing.getUnidadeMedida().equals("g")) ? "selected" : "" %>>Grama (g)</option>
                    <option value="L" <%= (ing != null && ing.getUnidadeMedida().equals("L")) ? "selected" : "" %>>Litro (L)</option>
                    <option value="un" <%= (ing != null && ing.getUnidadeMedida().equals("un")) ? "selected" : "" %>>Unidade (un)</option>
                </select>
                
                <input type="submit" value="Salvar Ingrediente">
            </form>
            <a href="<%= request.getContextPath()%>/home/app/producao/ingredientes.jsp" class="btn-voltar">Voltar</a>
        </div>
    </body>
</html>