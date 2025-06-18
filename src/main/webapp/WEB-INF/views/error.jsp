<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <%@ include file="templates/head.jsp"%>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Lato:wght@400;700&display=swap');
        body {
            font-family: 'Lato', sans-serif;
            background: linear-gradient(118deg, rgba(175, 222, 242, 0.90) 0%, rgba(57, 141, 195, 0.85) 100%), url('/images/background.png') no-repeat center center / cover;
            display: flow;
            height: 1000px;
            overflow: hidden;
            overflow-y: scroll;
        }
    </style>
</head>
<body>

<img src="<c:url value='/images/logoSincTransp.png' />" alt="Logo Transparente" style="position: absolute; top: 10px; left: 43%; z-index: 9999; height: 180px">

<div class="container" align="center" style="padding-top: 150px;">
    <div class="row" style="width: 700px; height: 500px; background: rgba(255, 255, 255, 0.21); border-radius: 46px; border: 1px rgba(255, 255, 255, 0.52) solid; backdrop-filter: blur(13.60px); align-content: center;">
        <div class="col-md-12">
            <div class="error-template">
                <div style="font-size: 25px; margin-bottom: 10px">PÁGINA EM <strong>CONSTRUÇÃO</strong></div>
                <img src="<c:url value='/images/construcTransp.png' />" alt="Página em construção" style="height: 300px; margin-bottom: 10px">
                <div class="error-actions">
                    <a href="<c:url value="/home" />" class="btn btn-primary btn-lg">
                        <span class="glyphicon glyphicon-home">
                        </span>Voltar para a página inicial</a>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>
