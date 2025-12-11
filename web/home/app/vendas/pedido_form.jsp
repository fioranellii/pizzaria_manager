<%@page import="model.Pedido"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pedido Form</title>
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
            input[type="text"], input[type="email"], input[type="tel"], input[type="password"], input[type="number"], input[type="datetime-local"], select, textarea {
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
            Pedido ped = null;
            String action = request.getParameter("action");

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            String dtHoraFormatada = "";
            String valorTotalFormatado = "";

            if (action == null || action.isEmpty()) {
                action = "create";
            } else if (action.equals("update")) {
                int id = Integer.valueOf(request.getParameter("id"));
                ped = new Pedido();
                ped.setIdPedido(id);
                ped.load();

                if (ped.getDtHora() != null) {
                    dtHoraFormatada = dateFormat.format(ped.getDtHora());
                }
                if (ped.getValorTotal() != null) {
                    valorTotalFormatado = ped.getValorTotal().toString();
                }
            }
        %>
        <div class="form-container">
            <h1><%= action.equals("create") ? "Registrar Novo Pedido" : "Alterar Pedido"%></h1>
            <form action="<%= request.getContextPath()%>/home?action=<%= action%>&task=pedidos" method="post">

                <label for="id_pedido">ID do Pedido:</label>
                <input type="text" id="id_pedido" name="id_pedido" pattern="\d+" title="Apenas dígitos" value="<%= (ped != null) ? ped.getIdPedido() : ""%>" <%= (ped != null) ? "readonly" : ""%> required>

                <label for="id_cliente">ID do Cliente:</label>
                <input type="text" id="id_cliente" name="id_cliente" pattern="\d+" title="Apenas dígitos" value="<%= (ped != null) ? ped.getIdCliente() : ""%>" required>

                <label for="id_funcionario">ID do Funcionário (Atendente):</label>
                <input type="text" id="id_funcionario" name="id_funcionario" pattern="\d+" title="Apenas dígitos" value="<%= (ped != null) ? ped.getIdFuncionario() : ""%>" required>

                <label for="dt_hora">Data e Hora:</label>
                <input type="datetime-local" id="dt_hora" name="dt_hora" value="<%= dtHoraFormatada%>" required>

                <label for="valor_total">Valor Total (R$):</label>
                <input type="text" id="valor_total" name="valor_total" pattern="^\d+(\.\d{1,2})?$" title="Apenas números e, opcionalmente, duas casas decimais" value="<%= valorTotalFormatado%>" <%= (ped != null && action.equals("update")) ? "readonly" : ""%>>

                <label for="status">Status:</label>
                <select id="status" name="status" required>
                    <option value="Pendente" <%= (ped != null && ped.getStatus().equals("Pendente")) ? "selected" : ""%>>Pendente</option>
                    <option value="Em Preparo" <%= (ped != null && ped.getStatus().equals("Em Preparo")) ? "selected" : ""%>>Em Preparo</option>
                    <option value="Pronto" <%= (ped != null && ped.getStatus().equals("Pronto")) ? "selected" : ""%>>Pronto</option>
                    <option value="Entregue" <%= (ped != null && ped.getStatus().equals("Entregue")) ? "selected" : ""%>>Entregue</option>
                </select>

                <input type="submit" value="Salvar Pedido">
            </form>
            <a href="<%= request.getContextPath()%>/home/app/vendas/pedidos.jsp" class="btn-voltar">Voltar</a>
        </div>
    </body>
    <%
        String msgErro = (String) request.getAttribute("msg_erro");
    %>

    <% if (msgErro != null) {%>
    <div style="color: #c0392b; border: 2px solid #e74c3c; background-color: #fdd; padding: 10px; margin: 15px auto; max-width: 600px; text-align: center; border-radius: 4px;">
        <strong>ERRO DE VALIDAÇÃO:</strong> <%= msgErro%>
    </div>
    <% }%>
</html>