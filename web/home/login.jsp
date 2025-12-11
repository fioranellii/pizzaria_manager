<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="jakarta.servlet.http.Cookie"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login - PizzaManager</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
                margin: 0;
            }
            .login-box {
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                width: 300px;
            }
            h1 {
                text-align: center;
                color: #c0392b;
                margin-bottom: 20px;
            }
            label {
                display: block;
                margin-top: 10px;
                font-weight: bold;
            }
            input[type="text"], input[type="password"] {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }
            input[type="submit"] {
                background-color: #e74c3c;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                width: 100%;
                margin-top: 20px;
                font-size: 16px;
            }
            input[type="submit"]:hover {
                background-color: #c0392b;
            }
        </style>
    </head>
    <body>

        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null) {%>
        <script>
                alert("<%= msg%>");
        </script>
        <% }%>

        <%
            HttpSession sessao = request.getSession(false);
            if ((sessao != null)
                    && (sessao.getAttribute("usuario_nome") != null)
                    && (sessao.getAttribute("cargo") != null)) {
                response.sendRedirect(request.getContextPath() + "/home/app/menu.jsp");
                return;
            }
        %>

        <%
            int id = -1;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if (c.getName().equals("id")) {
                        try {
                            id = Integer.parseInt(c.getValue());
                        } catch (NumberFormatException e) {

                        }
                    }
                }
            }
        %>

        <div class="login-box">
            <h1>Login de Funcionário</h1>

            <form action="<%= request.getContextPath()%>/home?task=login" method="post">

                <label for="id">ID do Funcionário:</label>
                <input 
                    type="text" 
                    id="id" 
                    name="id" 
                    pattern="\d+" 
                    title="Apenas dígitos" 
                    value="<%= (id != -1) ? id : ""%>" 
                    required>

                <label for="senha">Senha:</label>
                <input 
                    type="password" 
                    id="senha" 
                    name="senha" 
                    required>

                <input type="submit" value="Acessar Sistema">

            </form>
        </div>

    </body>
</html>