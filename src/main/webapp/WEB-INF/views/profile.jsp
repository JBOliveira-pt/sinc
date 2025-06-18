<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Profile</title>
    <%@ include file="templates/head.jsp" %>
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

    <script src="<c:url value="/scripts/profile.js" />"></script>

</head>
<body>

<%--Nav Bar--%>
<%@ include file="templates/navbar.jsp" %>

<div class="container2 " style="margin-left:auto; margin-right:auto; margin-bottom: auto;margin-top: 120px ">

    <div class="box position-relative">
        <div class="profile-picture-container" style="position: relative;">
            <img src="<c:out value="${user.profilePicture}" default="https://cdn-icons-png.freepik.com/512/8608/8608769.png"/>"
                 class="profile-picture" alt="Profile Picture" style=" border-radius: 50%;"/>
            <c:if test="${user.id == authUser.id}">
                <button type="button" class="btn btn-sm btn-primary position-absolute"
                        style="bottom: 5px; left: 470px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.6);"
                        data-bs-toggle="modal"
                        data-bs-target="#changePictureModal">
                    <i class="bi bi-camera"></i>
                </button>
            </c:if>
        </div>

        <h4 style="margin-top:5px; "><c:out value="${user.username}"/></h4>
        <p class="texto-cargo " style="margin:10px"><c:out
                value="${user.position.getPosition()} ${user.role.getRole()}"/></p>
        <p class="" style="margin:0px"><c:out value="${user.department}"/></p>
    </div>

    <div class="form-group-about" style="margin: auto auto auto 22px;">
        <div class="d-flex justify-content-between align-items-center" style="margin-left: 15px">
            <h5 style="margin-right: 17px;">Sobre mim</h5>
        </div>

        <div id="viewMode">
            <div class="form-control bordaaboutme"
                 style="text-align: left; min-height: 100px; word-wrap: break-word; overflow-wrap: break-word; white-space: normal; overflow: auto;">
                <c:out value="${user.aboutMe}"/>
            </div>
        </div>

        <c:if test="${user.id == authUser.id}">
            <div style="text-align: right;">
                <button type="button" id="editAboutMe" class="btn btn-sm btn-primary"
                        style="margin-right: 35px;font-size: 12px; padding: 3px 6px; border-radius: 8px"
                        onclick="this.style.visibility='hidden'">
                    <i class="bi bi-pencil"></i> Edit
                </button>
            </div>
        </c:if>

        <c:if test="${user.id == authUser.id}">
            <div id="editMode" style="display: none;">
                <form action="${pageContext.request.contextPath}/profile/update" method="POST">
                <textarea class="form-control bordaaboutme"
                          style="text-align: left"
                          rows="5"
                          id="aboutMe"
                          name="aboutMe"
                          maxlength="500"
                          onkeyup="updateCharCount(this)"><c:out value="${user.aboutMe}"/></textarea>
                    <div class="d-flex col-md-12 justify-content-end" style="margin: auto; width: 92%;">
                        <small class="text-muted bt" style="margin-right: 12px; margin-top: 12px;" id="charCount">0/500
                            characters</small>
                        <button type="button" id="cancelEdit" class="btn btn-secondary mt-2 me-2"
                                style="font-size: 12px; padding: 3px 6px; border-radius: 8px"
                                onclick="document.getElementById('editAboutMe').style.visibility='visible'">Cancel
                        </button>
                        <button type="submit" class="btn btn-primary mt-2"
                                style="font-size: 12px; padding: 3px 6px; border-radius: 8px">Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </c:if>
    </div>

    <div class="tecnologias col-md-12"
         style="margin-left:auto; margin-right:auto; margin-bottom: auto;margin-top: auto">
        <h5 class="" style="margin-top: 15px">Interesses</h5>
        <div class="">
            <c:if test="${not empty user.interests}">
                <c:forEach items="${user.interests.split(',')}" var="interest">
                    <div class="pill">
                        <c:out value="${interest}"/>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </div>
    <div class="tecnologias col-md-12"
         style="margin-left:auto; margin-right:auto; margin-bottom: auto;margin-top: 15px">
        <h5 class="">Tecnologia </h5>
        <div class="">
            <div class="pilltecnologia"><c:out value="${user.technology}"/></div>
        </div>
    </div>
</div>


<c:if test="${user.id == authUser.id}">
    <div class="modal fade" id="changePictureModal" tabindex="-1" aria-labelledby="changePictureModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="changePictureModalLabel">Alterar foto de perfil</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/profile/change-picture" method="post"
                          enctype="multipart/form-data" id="pictureForm">
                        <div class="text-center mb-4">
                            <img id="preview"
                                 src="<c:out value="${user.profilePicture}" default="https://cdn-icons-png.freepik.com/512/8608/8608769.png"/>"
                                 class="profile-picture"
                                 style="max-width: 200px; max-height: 200px;">
                        </div>
                        <div class="mb-3">
                            <label for="profileImage" class="form-label">Selecione uma nova imagem</label>
                            <input class="form-control" type="file" id="profileImage" name="profileImage"
                                   accept="image/*">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary"
                            onclick="document.getElementById('pictureForm').submit();">Salvar
                    </button>
                </div>
            </div>
        </div>
    </div>
</c:if>
</body>