<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Acesso Negado</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                text-align: center;
                padding: 50px;
            }
            .alert-box {
                max-width: 500px;
                margin: 0 auto;
                padding: 30px;
                border: 3px solid #e74c3c;
                background-color: #fceae9;
                border-radius: 8px;
            }
            h1 {
                color: #c0392b;
            }
            a {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #3498db;
                color: white;
                text-decoration: none;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <div class="alert-box">
            <h1>Acesso Negado!</h1>
            <p>Seu cargo (<%= session.getAttribute("cargo") %>) não possui permissão para acessar este recurso.</p>
            <a href="<%= request.getContextPath()%>/home/app/menu.jsp">Voltar ao Menu Principal</a>
        </div>
    </body>
</html>