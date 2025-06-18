<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SignUp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="<c:url value="/scripts/signup-validation.js" />"></script>
    <link href="<c:url value="/styles/estiloslogin.css" />" rel="stylesheet" type="text/css">
    <title>Fonte Lato</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Lato:wght@400;700&display=swap');

        body {
            font-family: 'Lato', sans-serif;
        }

        select[multiple] {
            min-height: 120px;
            padding: 5px;
        }

        select[multiple] option {
            padding: 4px;
            margin: 1px;
            border-radius: 4px;
            border-radius: 4px;
            font-size: 12px;
            line-height: 1.2;
        }

        select[multiple] option:checked {
            background: #e2e8f0 linear-gradient(0deg, #e2e8f0 0%, #e2e8f0 100%);
            color: #1a202c;

        }

        .is-invalid {
            border-color: #dc3545;
            background-color: #f8d7da;
            color: #dc3545;
        }

        .input-feedback {
            font-size: 11px;
            color: #dc3545;
            display: block;
        }
    </style>
</head>
<body>

<div class="mainContainer">

    <headerBox>
        <div class="loginLogo"></div>
        <div>
            <h2>CRIANDO UMA <span class="highlight">NOVA CONTA</span></h2>
            <p>Insira seus dados pessoais para criar seu perfil de utilizador na plataforma</p>
        </div>
    </headerBox>

    <form id= "signupForm" method="POST" action="/signup">
        <div class="form-section">

            <div class="form-group">
                <h4>DADOS PESSOAIS</h4>

                <input id="username" type="text" name="username" placeholder="Username" required>

                <input id="password" type="password" name="password" placeholder="Password" required oninput="removeInvalidFeedback(event)">
                <span id="passwordFeedback" class="input-feedback"></span>

                <label for="birthDate">Data de Nascimento</label>
                <input id="birthDate" type="date" name="birthDate" required oninput="removeInvalidFeedback(event)">
                <span id="birthDateFeedback" class="input-feedback"></span>
                <div>Selecione até 5 interesses</div>
                <select class = "form-select" id="interests" name="interests" multiple required>
                    <c:forEach items="${interests}" var="interest">
                        <option value="${interest}">${interest.getInterest()}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <h4>DADOS EMPRESARIAIS</h4>

                <select id="department" name="department" required>
                    <option value="" selected disabled>Departamento</option>
                    <c:forEach var="department" items="${departments}">
                        <option value="${department}">${department.getName()}</option>
                    </c:forEach>
                </select>

                <select id="position" name="position" required>
                    <option value="" selected disabled> Cargo</option>
                </select>

                <select id="role" name="role" required>
                    <option value="" selected disabled> Experiência</option>
                    <option value="JUNIOR">Júnior</option>
                    <option value="PLENO">Pleno</option>
                    <option value="SENIOR">Sénior</option>
                </select>

                <select id="technologies" name="technologies" required>
                    <option value="" selected disabled> Tecnologia</option>
                </select>

                <label for="admissionDate">Data de Ingresso na Empresa</label>
                <div class="form-section">
                    <input id="admissionDate" type="date" name="admissionDate" required oninput="removeInvalidFeedback(event)">
                </div>
                <span id="admissionDateFeedback" class="input-feedback"></span>
            </div>
        </div>

        <div class="terms" style=text-align:justify;">
            <span style="color: black; font-family: Lato; word-wrap: break-word">
            Os colaboradores que usam o nosso serviço podem ter carregado as tuas informações de contacto para a plataforma S.Inc.<br/><br/>Ao tocares em </span><span
                style="color: black; font-family: Lato; font-style: italic; word-wrap: break-word">Create New Account</span><span
                style="color: black; font-family: Lato; word-wrap: break-word"> estás a aceitar criar uma conta e a aceitar os Termos do S.Inc. Consulta a nossa Política de Privacidade para saber mais sobre a forma como recolhemos, utilizamos e partilhamos os teus dados e consulta a Política de Cookies para saber mais sobre a forma como utilizamos os cookies e tecnologias semelhantes.<br/>
            <br/>A Política de Privacidade descreve as formas como podemos utilizar as informações que recolhemos quando crias uma conta. Por exemplo, utilizamos estas informações para fornecer, personalizar e melhorar os nossos produtos.
            </span>
            <br/><br/>
        </div>

        <c:if test="${error != null}">
            <p class="alert alert-danger">${error}</p>
        </c:if>

        <button type="submit" class="btn btn-primary mt-2">Create Account</button>

    </form>

</div>

</body>
</html>