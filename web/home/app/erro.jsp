<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Página de Erro</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 20px;
                text-align: center;
            }
            .error-box {
                border: 1px solid #c0392b;
                padding: 15px;
                margin: 20px auto;
                max-width: 600px;
                background-color: #fdd;
            }
            h1 {
                color: #e74c3c;
            }
            a {
                padding: 8px 15px;
                background-color: #3498db;
                color: white;
                text-decoration: none;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <h1>Página de Erro</h1>
        
        <div class="error-box">
            Esta é uma página de erro. Se você foi redirecionado para esta página, significa que algum erro aconteceu.
            <br>
            <p style="margin-top: 10px; color: #333;">Consulte o log do servidor para detalhes técnicos.</p>
        </div>
        
        <br>
        <a href="<%= request.getContextPath()%>/home/app/menu.jsp">Voltar ao Menu Principal</a>
    </body>
</html>