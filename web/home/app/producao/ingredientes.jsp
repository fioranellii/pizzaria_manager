<%@page import="model.Ingrediente"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Estoque de Ingredientes - PizzaManager</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                color: #333;
                margin: 0;
                padding: 20px;
            }
            .container {
                width: 80%;
                margin: 20px auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                color: #e74c3c;
                margin-bottom: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            th, td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #c0392b;
                color: white;
                text-transform: uppercase;
            }
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            tr:hover {
                background-color: #f1f1f1;
            }
            a {
                display: inline-block;
                padding: 6px 10px;
                margin: 2px;
                text-decoration: none;
                border-radius: 4px;
                font-size: 14px;
                transition: background-color 0.3s;
            }
            a:not(.link-excluir):not(.link-adicionar):not(.btn-voltar-menu) {
                background-color: #3498db;
                color: white;
            }
            a:not(.link-excluir):not(.link-adicionar):not(.btn-voltar-menu):hover {
                background-color: #2980b9;
            }
            .link-excluir {
                background-color: #e74c3c;
                color: white;
            }
            .link-excluir:hover {
                background-color: #c0392b;
            }
            .link-adicionar {
                display: block;
                width: 150px;
                text-align: center;
                margin: 20px auto 0;
                padding: 10px;
                background-color: #27ae60;
                color: white;
                font-weight: bold;
            }
            .link-adicionar:hover {
                background-color: #229954;
            }
            .btn-voltar-menu {
                display: block;
                width: 250px;
                text-align: center;
                margin: 20px auto 10px;
                padding: 10px;
                background-color: #34495e; 
                color: white;
                font-weight: bold;
                border-radius: 4px;
                text-decoration: none;
            }
            .btn-voltar-menu:hover {
                background-color: #2c3e50;
            }
        </style>
    </head>
    <body>
        <% ArrayList<Ingrediente> dados = new Ingrediente().getAllTableEntities(); %>
        <h1>Estoque de Ingredientes</h1>
        
        <a href="<%= request.getContextPath()%>/home/app/menu.jsp" class="btn-voltar-menu">
            <-- Voltar ao Menu Principal
        </a>
        
        <div class="container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Quantidade</th>
                    <th>Unidade</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <% for(Ingrediente ing : dados) { %>
                <tr>
                    <td><%= ing.getIdIngrediente() %></td>
                    <td><%= ing.getNome() %></td>
                    <td><%= ing.getQuantidadeEstoque()%></td>
                    <td><%= ing.getUnidadeMedida()%></td>
                    <td> 
                        <a href="<%= request.getContextPath()%>/home/app/producao/ingrediente_form.jsp?action=update&id=<%= ing.getIdIngrediente() %>">Alterar</a>
                        <a href="<%= request.getContextPath()%>/home?action=delete&id=<%= ing.getIdIngrediente() %>&task=ingredientes" onclick="return confirm('Deseja excluir Ingrediente <%= ing.getIdIngrediente()%> (<%= ing.getNome() %>)?')" class="link-excluir" >Excluir</a>
                    </td>
                </tr>
                <% }%>
            </tbody>
        </table>
        </div>
        <a href="<%= request.getContextPath()%>/home/app/producao/ingrediente_form.jsp?action=create" class="link-adicionar">Adicionar</a>
    </body>
</html>