<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html lang="en">
<head>
    <title>Login</title>
    <%@ include file="templates/head.jsp" %>
    <style>
        body {font-family: 'Lato', sans-serif;}
    </style>
</head>

<body>
<section class="h-100 gradient-form" style="background: #ffffff">
    <div class="container py-5 h-100" >
        <div class="row d-flex justify-content-center align-items-center h-100" style="margin-top: 0px" >
            <div class="col-xl-10" >
                <div class="card rounded-3 text-black">
                    <div class="row g-0">
                        <div class="col-lg-6">
                            <div class="card-body p-md-5 mx-md-4">

                                <div class="text-center mt-1 mb-4 pb-1 logo">
                                </div>

                                <form action="/login" method ="post">

                                    <h5 class="texto-colorido">Login </h5>

                                    <div data-mdb-input-init class="form-outline mb-4 texto-botão">
                                        <input type="text" id="form2Example11" class="form-control" name="username" placeholder="Username" required/>
                                    </div>

                                    <div data-mdb-input-init class="form-outline mb-4 texto-botão">
                                        <input type="password" id="form2Example22" class="form-control" name="password" placeholder="Password" required />
                                    </div>

                                    <div class=" text-center pt-1 mb-6 p ">
                                        <button data-mdb-button-init data-mdb-ripple-init class="btn btn-primary mt-2" type="submit">Login</button>
                                    </div>

                                    <div class="text-center pt-1 mb-3 pb-1">
                                        <div class="message-container" style="min-height: 24px;">
                                            <c:if test="${param.error}">
                                                <p class="text-danger m-0">Login falhou, por favor verifique suas credenciais.</p>
                                            </c:if>
                                            <c:if test="${param.success}">
                                                <p class="text-success m-0">Conta criada, por favor faça o login.</p>
                                            </c:if>
                                        </div>
                                        <button type="button"
                                                class="btn btn-outline-custom1 gradient-custom-3 mb-3 center"
                                                onclick="window.location.href='/signup'">Create Account</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="col-lg-6 d-flex align-items-center" style="background: linear-gradient(118deg, rgba(175, 222, 242, 0.90) 0%, rgba(57, 141, 195, 0.85) 100%), url('/images/background.png') no-repeat center center / cover; border-top-right-radius: 6px; border-bottom-right-radius: 6px">
                            <div class="text-black px-3 py-4 p-md-5 mx-md-4">
                                <div class="row" style="width: 400px; height: 420px; background: rgba(255, 255, 255, 0.21); border-radius: 12px; border: 1px rgba(255, 255, 255, 0.52) solid; backdrop-filter: blur(13.60px);">
                                    <div class="elemento">
                                            <div class="texto caixa-estreita" style="text-align: left">
                                                <p>Sincronize a sua empresa e tenha mais resultados em menos tempo</p>
                                            </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</section>
</body>
</html>