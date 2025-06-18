<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ControlPanel</title>
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

        input::placeholder, textarea::placeholder{
            color: rgba(232, 237, 241, 0.5);
            font-style: italic;
            text-align: justify;
        }

    </style>
    <script src="scripts/post.js"> </script>
</head>
<body>

<%--NAVBAR ESPECÍFICA--%>
<nav class="navbar navbar-expand-lg navbar-light bg-white barra " style="padding-left: 40px; padding-right: 40px; padding-bottom: 0px; padding-top:0px">
    <div class="container-fluid">
        <button
                data-mdb-collapse-init
                class="navbar-toggler "
                type="button"
                data-mdb-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent"
                aria-expanded="false"
                aria-label="Toggle navigation"
        >
            <i class="fas fa-bars "></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <a class="navbar-brand mt-2 mt-lg-0 ">
                <div class="PanelLoginLogo" style=" padding-bottom: 0px; padding-top:0px;"></div>
            </a>
            <ul class="navbar-nav ms-auto mb-3 mb-lg-0">
            </ul>
        </div>
        <div class="d-flex align-items-center">
            <a class="text-reset me-3" href="#">
            </a>
            <div class="dropdown">
                <div class="d-flex align-items-center controlPanelUser-profile">
                    <div class="dropdown">
                        <a
                                id="navbarDropdownMenuAvatar"
                                role="button"
                                data-bs-toggle="dropdown"
                                aria-expanded="false"
                        >
                        <img
                                src="https://endosolns.com/wp-content/uploads/2017/02/avatar-round-2.png"
                                class="rounded-circle"
                                height="55"
                                alt="Avatar"
                                loading="lazy"
                        />
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuAvatar">
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/login">Logout</a></li>
                        </ul>
                    </div>
                    <div class="user-info ms-3">
                        <div class="user-name">Maria João</div>
                        <div class="user-role">Admin</div>
                    </div>
                </div>
                <ul
                        class="dropdown-menu dropdown-menu-end"
                        aria-labelledby="navbarDropdownMenuAvatar"
                ></ul>
                    <ul
                            class="dropdown-menu dropdown-menu-end"
                            aria-labelledby="navbarDropdownMenuLink"
                    >
                    </ul>
            </div>
        </div>
    </div>
    <div class="dropdown">
            <i class="fas fa-bell"></i>
    </div>
    <div class="dropdown">
        <span class="badge rounded-pill badge-notification bg-danger ">1</span>
    </div>
</nav>

<%--BOTÕES--%>
<div class="controlPanelAction-buttons">
    <h4><button type="button" class="controlPanelPost-button btn btn-outline-primary d-flex align-items-center" data-bs-toggle="modal" data-bs-target="#modalPostInstitucional" style="padding: 30px 45px;">
        <i class="bi bi-pencil-square fs-3"></i>
        <div style="font-family: 'Lato', sans-serif; font-size: 22px; padding: 12px; font-weight: bold;">Post Institucional</div>
    </button>
    </h4>
    <h4><button type="button" class="controlPanelPost-button btn btn-outline-primary d-flex align-items-center" data-bs-toggle="modal"  style="padding: 30px 45px;">
        <i class="bi bi-exclamation-triangle fs-3"></i>
        <div style="font-family: 'Lato', sans-serif; font-size: 22px; padding: 12px; font-weight: bold;">Aplicar Sanções</div>
    </button>
    </h4>
</div>

<%--AVALIAÇÕES--%>
<div class="controlPanel">
    <h2>Painel de Controle das <span class="highlight">Avaliações</span></h2>
    <table>
        <thead>
        <tr>
            <th>Colaborador</th>
            <th>Cargo</th>
            <th>Experiência</th>
            <th>Análise</th>
            <th>Abertura</th>
            <th>Status</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>Inês Castro</td>
            <td>Programadora</td>
            <td>Senior</td>
            <td>Tópico em Fórum</td>
            <td>06.02.2025 - 14:05</td>
            <td><span class="controlPanelStatus aprovado">Aprovado</span></td>
            <td></td>
        </tr>
        <tr>
            <td>Joana Vaz</td>
            <td>Analista de Sistemas</td>
            <td>Júnior</td>
            <td>Pedido de Ajuda</td>
            <td>08.02.2025 - 09:48</td>
            <td><span class="controlPanelStatus pendente">Pendente</span></td>
            <td><span class="avaliar">Avaliar</span></td>
        </tr>
        <tr>
            <td>Pedro Lima</td>
            <td>Recursos Humanos</td>
            <td>Pleno</td>
            <td>Marcação de Reunião</td>
            <td>07.02.2025 - 10:55</td>
            <td><span class="controlPanelStatus rejeitado">Rejeitado</span></td>
            <td></td>
        </tr>
        </tbody>
    </table>
</div>

<div class="modal fade" id="modalPostInstitucional" tabindex="-1" role="dialog" aria-labelledby="modalPostInstitucionalLabel">
    <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 800px; max-height: 600px;">
        <div class="modal-content" style="background-color: #B0E0E6; border-radius: 12px; padding: 15px; width: 100%; height: 100%;">
            <div class="modal-header" style="border-bottom: none;">
                <h4 class="modal-title" id="modalPostInstitucionalLabel" style="color: #0A3D62; font-weight: bold;">Post Institucional</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/posts" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="title" class="form-label" style="color: #0A3D62;">Título</label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="Escreva aqui o título do Post." required>
                    </div>
                    <div class="row g-3 align-items-start" style="padding-left: 10px">
                        <div class="col-md-4">
                            <label for="attachment" class="d-flex justify-content-center align-items-center" style="background-color: #E6E6FA; height: 165px; width: 240px; border-radius: 8px; cursor: pointer;">
                                <i class="bi bi-upload" style="font-size: 32px; color: #0A3D62;"></i>
                                <input type="file" class="form-control d-none" id="attachment" name="attachment" onchange="previewFile()">
                            </label>
                            <div class="form-text text-muted" style="font-size: 12px; margin-top: 5px;">
                                <i class="bi bi-info-circle"></i> Máximo permitido: 1MB
                            </div>
                            <!-- File Information Display -->
                            <div id="fileInfo" style="margin-top: 5px; font-size: 12px; color: #666;"></div>
                            <!-- File Warning Display -->
                            <div id="fileWarning" style="margin-top: 5px; font-size: 12px; font-weight: bold; color: #dc3545;"></div>
                        </div>
                        <div class="col-md-8">
                            <label for="description" class="form-label" style="color: #0A3D62;">Legenda</label>
                            <textarea class="form-control" id="description" name="description" rows="5" placeholder="Escreva aqui o que queres fixar na parte superior do Feed para que todos os colaboradores possam ver." required></textarea>
                        </div>
                        <div id="previewContainer" style="display: none; margin-top: 10px;" class="col-12">
                            <img id="attachmentPreview" style="max-width: 100%; border-radius: 8px; display: none;">
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="border-top: none;">
                    <button type="submit" class="btn btn-primary" style="border-color: #398dc3; border-radius: 12px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.6);">Post</button>
                </div>
            </form>
        </div>
    </div>
</div>

<c:if test="${not empty success}">
    <div id="successToast" class="toast align-items-center text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; top: 20px; right: 20px;">
        <div class="d-flex">
            <div class="toast-body">
                    ${success}
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</c:if>

</body>
</html>