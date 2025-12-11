<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Módulos - PizzaManager</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                color: #333;
                margin: 0;
                padding: 0;
            }
            .header-info {
                background-color: #c0392b;
                color: white;
                padding: 15px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            }
            .header-info h1 {
                margin: 0;
                font-size: 1.8rem;
            }
            .user-details {
                text-align: right;
            }
            .user-details span {
                display: block;
                font-weight: bold;
            }
            nav {
                background-color: #e74c3c;
                padding: 0 30px;
            }
            nav ul {
                list-style: none;
                padding: 0;
                margin: 0;
                display: flex;
                justify-content: flex-start;
                align-items: center;
            }
            nav ul li {
                margin-right: 20px;
            }
            nav ul li a {
                color: white;
                text-decoration: none;
                padding: 10px 15px;
                display: block;
                border-radius: 4px;
                transition: background-color 0.3s;
                font-weight: 600;
            }
            nav ul li a:hover {
                background-color: #c0392b;
            }
            .logout-link {
                margin-left: auto;
                background-color: #34495e;
                border-radius: 0;
            }
            .logout-link a {
                padding: 10px 20px;
                font-size: 0.95rem;
                background-color: transparent;
            }
            .logout-link a:hover {
                background-color: #2c3e50;
            }
            .content {
                padding: 30px;
                text-align: center;
            }
            .welcome-box {
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                margin-top: 20px;
            }
            .welcome-box h2 {
                color: #2c3e50;
            }
        </style>
    </head>
    <body>
        <%
            String usuarioNome = (String) session.getAttribute("usuario_nome");
            String cargo = (String) session.getAttribute("cargo");

            if (usuarioNome == null || cargo == null) {
                response.sendRedirect(request.getContextPath() + "/home/login.jsp");
                return;
            }

            boolean isGerente = "Gerente".equals(cargo);
            boolean isPizzaiolo = "Pizzaiolo".equals(cargo);
            boolean isAtendente = "Atendente".equals(cargo);
        %>

        <div class="header-info">
            <h1>PizzaManager - Sistema</h1>
            <div class="user-details">
                <span>Bem-vindo(a), <%= usuarioNome%></span>
                <small>(<%= cargo%>)</small>
            </div>
        </div>

        <nav>
            <ul>
                <li><a href="<%= request.getContextPath()%>/home/app/menu.jsp">Início / Menu</a></li>

                <li><a href="<%= request.getContextPath()%>/home/app/geral/clientes.jsp">Clientes</a></li>

                <% if (isGerente || isAtendente) {%>
                <li><a href="<%= request.getContextPath()%>/home/app/vendas/produtos.jsp">Produtos/Sabores</a></li>
                <li><a href="<%= request.getContextPath()%>/home/app/vendas/pedidos.jsp">Pedidos</a></li>
                <% } %>

                <% if (isGerente || isPizzaiolo) {%>
                <li><a href="<%= request.getContextPath()%>/home/app/producao/ingredientes.jsp">Estoque/Ingredientes</a></li>
                <% } %>

                <% if (isGerente) {%>
                <li><a href="<%= request.getContextPath()%>/home/app/adm/funcionarios.jsp">Funcionários</a></li>
                <% }%>

                <li class="logout-link"><a href="<%= request.getContextPath()%>/home?task=logout">Sair (Logout)</a></li>
            </ul>
        </nav>

        <div class="content">
            <div class="welcome-box">
                <h2>Gerenciamento de Pizzaria</h2>
                <p>Use o menu superior para acessar os módulos permitidos ao seu cargo de <strong><%= cargo %></strong>.</p>
            </div>
        </div>
    </body>
</html>