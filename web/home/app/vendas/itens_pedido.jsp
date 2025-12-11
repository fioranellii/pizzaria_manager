<%@page import="model.ItemPedido"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Pedido"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Itens do Pedido - PizzaManager</title>
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
            a:not(.link-excluir):not(.link-adicionar) {
                background-color: #3498db;
                color: white;
            }
            a:not(.link-excluir):not(.link-adicionar):hover {
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
        </style>
    </head>
    <body>
        <% 
            int idPedido = 0;
            try {
                idPedido = Integer.parseInt(request.getParameter("id_pedido"));
            } catch(NumberFormatException ex) {
            }

            ArrayList<ItemPedido> todosDados = new ItemPedido().getAllTableEntities();
            ArrayList<ItemPedido> dadosDoPedido = new ArrayList<>();
            for (ItemPedido item : todosDados) {
                if (item.getIdPedido() == idPedido) {
                    dadosDoPedido.add(item);
                }
            }
        %>
        <h1>Detalhes do Pedido #<%= idPedido %></h1>
        <div class="container">
        <table>
            <thead>
                <tr>
                    <th>ID Produto</th>
                    <th>Quantidade</th>
                    <th>Observações</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <% for(ItemPedido item : dadosDoPedido) { %>
                <tr>
                    <td><%= item.getIdProduto() %></td>
                    <td><%= item.getQuantidade() %></td>
                    <td><%= item.getObservacao()%></td>
                    <td> 
                        <a href="<%= request.getContextPath()%>/home/app/item_pedido_form.jsp?action=update&id_pedido=<%= item.getIdPedido() %>&id_produto=<%= item.getIdProduto() %>">Alterar</a>
                        <a href="<%= request.getContextPath()%>/home?action=delete&id_pedido=<%= item.getIdPedido() %>&id_produto=<%= item.getIdProduto() %>&task=itens_pedido" onclick="return confirm('Deseja excluir item do produto <%= item.getIdProduto()%> do pedido <%= item.getIdPedido() %>?')" class="link-excluir" >Excluir</a>
                    </td>
                </tr>
                <% }%>
            </tbody>
        </table>
        </div>
        <a href="<%= request.getContextPath()%>/home/app/item_pedido_form.jsp?action=create&id_pedido=<%= idPedido %>" class="link-adicionar">Adicionar Item</a>
        <a href="<%= request.getContextPath()%>/home/app/pedidos.jsp">Voltar à Lista de Pedidos</a>
    </body>
</html>