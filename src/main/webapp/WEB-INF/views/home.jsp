<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <%@ include file="templates/head.jsp" %>

    <style>
        body {
            font-family: 'Lato', sans-serif;
            background: linear-gradient(118deg, rgba(175, 222, 242, 0.90) 0%, rgba(57, 141, 195, 0.85) 100%), url('/images/background.png') no-repeat center center / cover;
            background-color: #08335A;
            display: flow;
            height: 920px;
            overflow: hidden;
            overflow-y: scroll;
        }
    </style>

    <script src="scripts/ajuda.js"></script>

</head>
<body>
<%@ include file="templates/navbar.jsp" %>

<!-- POSTS INSTITUCIONAIS -->
<div class="container-feed" style="overflow: hidden; max-height: 500px; margin-top: 120px">
    <div class="postsinsts d-flex align-items-center" style="height: 100%;">
        <div class="post-card color-postinst-small d-flex flex-column" style="width: 250px; height: 200px; padding: 15px; text-align: left">
            <p class="text" style="padding-top: 5px; font-size: 20px;"><strong>Mensagem da Diretoria</strong></p>
            <p class="text" style="padding-top: 3px;">Reafirmamos o nosso compromisso com a excelência, inovação e trabalho em equipa. Contamos com o empenho de todos para seguirmos avançando!</p>
        </div>
        <div class="post-card color-postinst d-flex justify-content-center align-items-center gap-0" style="width: 500px; margin: auto; cursor: pointer;" data-bs-toggle="modal" data-bs-target="#modalLastPostInstitucional">
            <c:forEach items="${posts}" var="post" begin="0" end="0">
                <div class="post-image" style="width: 50%; padding-left: 10px">
                    <c:if test="${post.attachment != null}">
                        <div class="post-attachment" style="width: fit-content">
                            <c:choose>
                                <c:when test="${post.attachmentType.startsWith('image/')}">
                                    <img src="${pageContext.request.contextPath}/posts/${post.id}/attachment" alt="${post.attachmentName}" class="img-fluid mb-0" style="max-height: 200px; max-width: 200px;">
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/posts/${post.id}/attachment" download="${post.attachmentName}" class="btn btn-sm btn-secondary">
                                        <i class="fas fa-download"></i> ${post.attachmentName}
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                </div>
                <div class="post-content d-inline-block" style="width: 60%; padding-right: 32px;">
                    <h3 style="margin-bottom: 0">${post.title}</h3>
                    <span class="post-date" style="font-size: 12px;">${post.createdAt}</span>
                    <p style="padding-top: 12px; text-align: justify;">${post.description}</p>
                </div>
            </c:forEach>
        </div>

        <div class="container-generic" style="display: flex; flex-direction: column; gap: 15px">
            <div class="post-card color-postinst d-flex" style="width: 250px; height: 100px; padding: 15px; text-align: right; cursor: pointer;" data-bs-toggle="modal" data-bs-target="#modalLastPostInstitucionalOne">
                <c:forEach items="${posts}" var="post" begin="1" end="1">
                    <div class="post-image" style="width: 40%; padding-left: 5px">
                        <c:if test="${post.attachment != null}">
                            <div class="post-attachment">
                                <c:choose>
                                    <c:when test="${post.attachmentType.startsWith('image/')}">
                                        <img src="${pageContext.request.contextPath}/posts/${post.id}/attachment" alt="${post.attachmentName}" class="img-fluid mb-0" style="max-height: 80px; max-width: 80px;">
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/posts/${post.id}/attachment" download="${post.attachmentName}" class="btn btn-sm btn-secondary">
                                            <i class="fas fa-download"></i> ${post.attachmentName}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:if>
                    </div>
                    <div class="post-content d-inline-block" style="width: 60%; padding-right: 10px;">
                        <h6 class="text" style="margin-bottom: 0">${post.title}</h6>
                        <span class="post-date" style="font-size: 10px;">${post.createdAt}</span>
                    </div>
                </c:forEach>
            </div>

            <div class="post-card color-postinst d-flex" style="width: 250px; height: 100px; padding: 15px; text-align: right; cursor: pointer;" data-bs-toggle="modal" data-bs-target="#modalLastPostInstitucionalTwo">
                <c:forEach items="${posts}" var="post" begin="2" end="2">
                    <div class="post-image" style="width: 40%; padding-left: 5px">
                        <c:if test="${post.attachment != null}">
                            <div class="post-attachment">
                                <c:choose>
                                    <c:when test="${post.attachmentType.startsWith('image/')}">
                                        <img src="${pageContext.request.contextPath}/posts/${post.id}/attachment" alt="${post.attachmentName}" class="img-fluid mb-0" style="max-height: 80px; max-width: 80px;">
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/posts/${post.id}/attachment" download="${post.attachmentName}" class="btn btn-sm btn-secondary">
                                            <i class="fas fa-download"></i> ${post.attachmentName}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:if>
                    </div>
                    <div class="post-content d-inline-block" style="width: 60%; padding-right: 10px;">
                        <h6 class="text" style="margin-bottom: 0">${post.title}</h6>
                        <span class="post-date" style="font-size: 10px;">${post.createdAt}</span>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<!-- Pop-ups dos Posts Institucionais -->
<div class="modal fade" id="modalLastPostInstitucional" tabindex="-1" role="dialog" aria-labelledby="modalPostInstitucionalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered d-flex justify-content-center align-items-center" role="document" style="max-width: 800px; max-height: 700px;">
        <div class="modal-content" style="background-color: #B0E0E6; border-radius: 12px; padding: 15px; width: 100%; height: 100%;">
            <div class="modal-header" style="border: 0; margin: 0; padding: 0">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <c:forEach items="${posts}" var="post" begin="0" end="0">
                <div class="post-image d-flex justify-content-center align-items-center" style="width: 100%;">
                    <c:if test="${post.attachment != null}">
                        <div class="post-attachment" style="padding-bottom: 30px;">
                            <c:choose>
                                <c:when test="${post.attachmentType.startsWith('image/')}">
                                    <img src="${pageContext.request.contextPath}/posts/${post.id}/attachment" alt="${post.attachmentName}" class="img-fluid mb-0" style="max-height: 300px; max-width: 300px;">
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/posts/${post.id}/attachment" download="${post.attachmentName}" class="btn btn-sm btn-secondary">
                                        <i class="fas fa-download"></i> ${post.attachmentName}
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                </div>
                <div class="post-content d-flex justify-content-center align-items-center flex-column" style="width: 100%;">
                    <h2 style="margin-bottom: 0">${post.title}</h2>
                    <span class="post-date" style="font-size: 12px;">${post.createdAt}</span>
                    <span class="postDescription">${post.description}</span>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<div class="modal fade" id="modalLastPostInstitucionalOne" tabindex="-1" role="dialog" aria-labelledby="modalPostInstitucionalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered d-flex justify-content-center align-items-center" role="document" style="max-width: 800px; max-height: 700px;">
        <div class="modal-content" style="background-color: #B0E0E6; border-radius: 12px; padding: 15px; width: 100%; height: 100%;">
            <div class="modal-header" style="border: 0; margin: 0; padding: 0">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <c:forEach items="${posts}" var="post" begin="1" end="1">
                <div class="post-image d-flex justify-content-center align-items-center" style="width: 100%;">
                    <c:if test="${post.attachment != null}">
                        <div class="post-attachment" style="padding-bottom: 30px;">
                            <c:choose>
                                <c:when test="${post.attachmentType.startsWith('image/')}">
                                    <img src="${pageContext.request.contextPath}/posts/${post.id}/attachment" alt="${post.attachmentName}" class="img-fluid mb-0" style="max-height: 300px; max-width: 300px;">
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/posts/${post.id}/attachment" download="${post.attachmentName}" class="btn btn-sm btn-secondary">
                                        <i class="fas fa-download"></i> ${post.attachmentName}
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                </div>
                <div class="post-content d-flex justify-content-center align-items-center flex-column" style="width: 100%;">
                    <h2 style="margin-bottom: 0">${post.title}</h2>
                    <span class="post-date" style="font-size: 12px;">${post.createdAt}</span>
                    <span class="postDescription">${post.description}</span>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<div class="modal fade" id="modalLastPostInstitucionalTwo" tabindex="-1" role="dialog" aria-labelledby="modalPostInstitucionalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered d-flex justify-content-center align-items-center" role="document" style="max-width: 800px; max-height: 700px;">
        <div class="modal-content" style="background-color: #B0E0E6; border-radius: 12px; padding: 15px; width: 100%; height: 100%;">
            <div class="modal-header" style="border: 0; margin: 0; padding: 0">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <c:forEach items="${posts}" var="post" begin="2" end="2">
                <div class="post-image d-flex justify-content-center align-items-center" style="width: 100%;">
                    <c:if test="${post.attachment != null}">
                        <div class="post-attachment" style="padding-bottom: 30px;">
                            <c:choose>
                                <c:when test="${post.attachmentType.startsWith('image/')}">
                                    <img src="${pageContext.request.contextPath}/posts/${post.id}/attachment" alt="${post.attachmentName}" class="img-fluid mb-0" style="max-height: 300px; max-width: 300px;">
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/posts/${post.id}/attachment" download="${post.attachmentName}" class="btn btn-sm btn-secondary">
                                        <i class="fas fa-download"></i> ${post.attachmentName}
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                </div>
                <div class="post-content d-flex justify-content-center align-items-center flex-column" style="width: 100%;">
                    <h2 style="margin-bottom: 0">${post.title}</h2>
                    <span class="post-date" style="font-size: 12px;">${post.createdAt}</span>
                    <span class="postDescription">${post.description}</span>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<%--<!-- FEED DE POSTS COM PEDIDOS DE AJUDA -->--%>
<div class="container-feed2" style="max-height: 66%">

<%--FÓRUM FAKE--%>

    <div class="post-card color-forum-small flex-column" style="width: 250px; height: 300px; padding: 15px;">
        <p class="text" style="text-align: center; padding-top: 9px; font-size: 25px; color: #08335A;">
            <strong>Fórum</strong> <i class="bi bi-plus-circle"></i>
        </p>
        <p class="text" style="margin-bottom: 20px; padding-top: 5px; font-size: 15px; color: #83a8c5;">
            Últimos tópicos & Comentários
        </p>

        <div class="forum-item">
            <img src="/images/Raquel.jpg" alt="Raquel" class="avatar">
            <h5 class="forum-title">Pagamentos</h5>
        </div>
        <p class="text-forum">Últimos dias para justificar as tuas faltas!</p>
        <p class="text-forum-2"><strong>by</strong> Raquel Félix  1h ago</p>


        <div class="forum-item">
            <img src="/images/Daniel.jpg" alt="Daniel" class="avatar">
            <h5 class="forum-title">Dificuldades?</h5>
        </div>
        <p class="text-forum">Dificuldades para gerir trabalhos.</p>
        <p class="text-forum-2"><strong>by</strong> Daniel Fernandes  5h ago</p>

        <div class="forum-item">
            <img src="/images/Pedro.jpg" alt="Avatar" class="avatar">
            <h5 class="forum-title">Threads</h5>
        </div>
        <p class="text-forum">Trivialidades sobre galinhas.</p>
        <p class="text-forum-2"><strong>by</strong> Pedro Romano  8h ago</p>

        <div class="forum-item">
            <img src="/images/José.png" alt="Avatar" class="avatar">
            <h5 class="forum-title">Avaina de Pau</h5>
        </div>
        <p class="text-forum">Pushs com o código partido.</p>
        <p class="text-forum-2"><strong>by</strong> José Serro  10h ago</p>

        <div class="forum-item">
            <img src="/images/João.jpg" alt="Avatar" class="avatar">
            <h5 class="forum-title">Abstrato</h5>
        </div>
        <p class="text-forum">Heranças, polimorfismo e outros conceitos abstratos.</p>
        <p class="text-forum-2"><strong>by</strong> João Antão  15h ago</p>

    </div>

<%--    <!-- Google Calendar Widget -->--%>
    <div class="modal-container" style="display: flex; justify-content: flex-end;">

        <div class="modal-content" style="background-color: transparent; border-radius: 5px;top: -280px; width: 25%; height: 55%; margin-left: 10px;">
        <p class="text" style="text-align: center; font-size: 25px; font-weight: bolder; color: #08335A;">Agenda</p>
        <p class="text" style="margin-bottom: 1px; padding-top: -1px; font-size: 15px; color: #83a8c5;">
                Eventos & Reuniões
            </p>
        <iframe class="custom-iframe" src="https://calendar.google.com/calendar/embed?src=b8am9fc1cmetmcj3af109f4rgat0utnv%40import.calendar.google.com&ctz=Europe%2FLisbon&mode=MONTH&showNav=1&showPrint=0&showCalendars=0"></iframe>

        </div>
    </div>


        <%--Header do Feed--%>
    <div class="scroll-container" style="margin-top:-588px; margin-bottom:640px; margin-left: auto; margin-right: auto; max-height: 100%;">
        <h5 style="text-align:left; color: #08335A"> Olá, <strong><c:out value="${authUser.username}"/></strong>! </h5>
        <div class="create-homePost-card" style="margin-top: 2px;">
            <h5>
                <button type="button" class="homePost-button btn" data-bs-toggle="modal" data-bs-target="#modalFeedPost" style="padding: 15px 15px;">
                    <div style="width: 418px; font-size: 14px; border: transparent; border-radius: 9px; text-align: left;">
                        Escreva o seu pedido de ajuda...
                    </div>
                </button>
            </h5>
        </div>

        <%-- Feed Posts --%>
        <c:forEach items="${feedposts}" var="feedpost">
            <div class="feed-posts-container">

                    <div class="create-feedpost-card" style="margin-top: 0px; padding: 30px; border-radius: 9px; width: 450px; background-color: transparent;">
                        <div class="post-ajuda-container" style="margin-bottom: -15px">
                            <div style="display: flex; align-items:center; margin-top: -20px;">
                                <div style="display: flex; align-items: center;">
                                    <a href="${pageContext.request.contextPath}/profile/${feedpost.user.id}" style="text-decoration: none; display: flex; color: inherit; align-items: center;">
                                    <img src="<c:out value="${feedpost.user.profilePicture}" default="https://cdn-icons-png.freepik.com/512/8608/8608769.png"/>" alt="${feedpost.user.username}'s profile" style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%; margin-left:-15px;">
                                    <h6 style="margin-left: 8px; margin-bottom: 0px; font-size: 15px; font-weight:normal; color: #08335A;"><strong><c:out value="${feedpost.user.username}"/></strong></h6>
                                    </a>
                                </div>
                            </div>
                            <div class="post-ajuda">
                                <h6 class="text" style="text-align: left; font-size: 16px; font-weight: normal;">${feedpost.title}</h6>
                                <p class="post-date">${feedpost.content}</p>
                                <c:if test="${feedpost.attachment != null && !empty feedpost.attachment}">
                                    <div style="align-content: center">
                                        <img src="${pageContext.request.contextPath}/feedposts/${feedpost.id}/attachment" alt="Attachment"
                                             style="width: 80%; height: 80%; max-height: 250px; max-width: 250px; border-radius: 9px; margin-bottom: 10px;"/>
                                    </div>
                                </c:if>
                                <c:if test="${authUser.id != feedpost.user.id}">
                                    <div style="margin-top: 10px; margin-bottom: 10px;">
                                        <button type="button" class="botao-feed-post" data-bs-toggle="modal" data-bs-target="#commentModal${feedpost.id}"> Comentar </button>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <div class="comment-post-ajuda-container-generico" style="margin-top: 20px">

                            <%-- COMENTARIOS DO FEED --%>
                            <c:forEach items="${feedpost.comments}" var="comment">

                                <div class="comment-post-ajuda-container">
                                    <a href="${pageContext.request.contextPath}/profile/${comment.user.id}" style="text-decoration: none; color: inherit; display: flex; align-items: center;">
                                    <h6 style="font-size: 12px; margin-right: 20px; margin-bottom: 20px;"><strong><c:out value="${comment.user.username}"/></strong></h6>
                                    <img src="<c:out value="${comment.user.profilePicture}" default="https://cdn-icons-png.freepik.com/512/8608/8608769.png"/>" alt="${comment.user.username}'s profile" style="width: 42px; height: 42px; object-fit: cover; border-radius: 50%; margin-left:-15px;">
                                    </a>
                                </div>

                                <div style="margin-top: -22px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.6); padding: 8px; margin-bottom: 8px; margin-left: 5px; margin-right: 10px; align-items: center; height: auto; border-radius: 9px; width: 375px; background-color: rgba(175,222,242,0.51);">
                                    <p class="post-date-coment"><c:out value="${comment.content}"/></p>


                                    <%-- Evaluation Buttons --%>
                                    <c:if test="${authUser.id == feedpost.user.id && !comment.evaluated && comment.user.id != feedpost.user.id}">
                                        <div style="display: flex; margin-top: -10px;">
                                            <form action="${pageContext.request.contextPath}/feedposts/evaluate-comment" method="post" style="display: inline; margin-right: 5px;">
                                                <input type="hidden" name="commentId" value="${comment.id}">
                                                <input type="hidden" name="evaluation" value="OK">
                                                <button type="submit" class="btn-ok" style="background: none; border: none; cursor: pointer;"><img src="/images/ok.png" alt="OK" style="height: 15px; width: 15px; opacity: 0.5;"></button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/feedposts/evaluate-comment" method="post" style="display: inline; margin-right: 5px;">
                                                <input type="hidden" name="commentId" value="${comment.id}">
                                                <input type="hidden" name="evaluation" value="GOOD">
                                                <button type="submit" class="btn-bom" style="background: none; border: none; cursor: pointer;"><img src="/images/good.png" alt="GOOD" style="height: 15px; width: 15px; opacity: 0.5;"></button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/feedposts/evaluate-comment" method="post" style="display: inline;">
                                                <input type="hidden" name="commentId" value="${comment.id}">
                                                <input type="hidden" name="evaluation" value="EXCELLENT">
                                                <button type="submit" class="btn-otimo" style="background: none; border: none; cursor: pointer;"><img src="/images/excellent.png" alt="EXCELLENT" style="height: 15px; width: 15px; opacity: 0.5;"></button>
                                            </form>
                                        </div>
                                    </c:if>


                                    <%-- Evaluation Display --%>
                                    <c:if test="${comment.evaluation != null}">
                                        <div style="margin-top: -5px; text-align: left; font-size: 12px;">
                                            <c:choose>
                                                <c:when test="${comment.evaluation.name() == 'OK'}"><img src="/images/ok.png" alt="OK" style="height: 15px; width: 15px"></c:when>
                                                <c:when test="${comment.evaluation.name() == 'GOOD'}"><img src="/images/good.png" alt="GOOD" style="height: 15px; width: 15px"></c:when>
                                                <c:when test="${comment.evaluation.name() == 'EXCELLENT'}"><img src="/images/excellent.png" alt="EXCELLENT" style="height: 15px; width: 15px"></c:when>
                                            </c:choose>
                                        </div>
                                    </c:if>
                                </div>


                                <%-- Reply Button --%>
                                <c:if test="${authUser.id == feedpost.user.id && comment.user.id != authUser.id && !comment.hasBeenReplied}">
                                    <div style="margin-top: -40px; margin-right: 20px; text-align: right;">
                                        <button type="button" class="botao-feed-post-resposta" data-bs-toggle="modal" data-bs-target="#replyModal${comment.id}"> Responder </button>
                                    </div>
                                </c:if>

                            </c:forEach>
                        </div>
                    </div>
            </div>
        </c:forEach>
    </div>
</div>

<%-- MODAL COMENTARIO E REPLIES --%>
<c:forEach items="${feedposts}" var="feedpost">
    <%-- Comment Modal --%>
    <div class="modal fade" id="commentModal${feedpost.id}" tabindex="-1" aria-labelledby="commentModalLabel${feedpost.id}" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="background-color: #B0E0E6; border-radius: 12px;">
                <div class="modal-header">
                    <h5 class="modal-title" id="commentModalLabel${feedpost.id}">Adicionar comentário</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/feedposts/add-comment" method="post">
                        <input type="hidden" name="feedPostId" value="${feedpost.id}">
                        <div class="mb-3">
                            <textarea name="content" class="form-control" rows="3" placeholder="Escreva seu comentário..." required></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Enviar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%-- Reply --%>
    <c:forEach items="${feedpost.comments}" var="comment">
        <div class="modal fade" id="replyModal${comment.id}" tabindex="-1" aria-labelledby="replyModalLabel${comment.id}" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" style="background-color: #B0E0E6; border-radius: 12px;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="replyModalLabel${comment.id}">Responder ao comentário</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="${pageContext.request.contextPath}/feedposts/add-comment" method="post">
                            <input type="hidden" name="feedPostId" value="${feedpost.id}">
                            <input type="hidden" name="parentCommentId" value="${comment.id}">
                            <div class="mb-3">
                                <textarea name="content" class="form-control" rows="3" placeholder="Escreva sua resposta..." required></textarea>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-primary">Enviar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</c:forEach>

<%-- MODAL PRO PEDIDO DE AJUDA --%>
<div class="modal fade" id="modalFeedPost" tabindex="-1" role="dialog" aria-labelledby="modalFeedPostLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 800px; max-height: 600px;">
        <div class="modal-content" style="background-color: #B0E0E6; border-radius: 12px; padding: 15px; width: 100%; height: 100%;">
            <div class="modal-header" style="border-bottom: none;">
                <h4 class="modal-title" id="modalFeedPostLabel" style="color: #0A3D62; font-weight: bold;">Pedido de ajuda</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/feedposts" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="title" class="form-label" style="color: #0A3D62;">Título</label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="Escreva aqui o assunto." required>
                    </div>
                    <div class="row g-3 align-items-start" style="padding-left: 10px">
                        <label for="attachment" class="col-md-4 d-flex justify-content-center align-items-center" style="background-color: #E6E6FA; height: 165px; width: 240px; border-radius: 8px; cursor: pointer;">
                            <i class="bi bi-upload" style="font-size: 32px; color: #0A3D62;"></i>
                            <input type="file" class="form-control d-none" id="attachment" name="attachment" onchange="previewFile()">
                        </label>
                        <div class="col-md-8">
                            <label for="content" class="form-label" style="color: #0A3D62;">Legenda</label>
                            <textarea class="form-control" id="content" name="content" rows="5" placeholder="Descreva a sua dúvida." required></textarea>
                        </div>
                        <div id="previewContainer" style="display: none; margin-top: 10px;" class="col-12">
                            <img id="attachmentPreview" style="max-width: 100%; border-radius: 8px; display: none;">
                        </div>
                        <div class="form-text text-muted" style="font-size: 12px; margin-top: 5px;">
                                        <i class="bi bi-info-circle"></i> Máximo permitido: 1MB
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
</body>
</html>