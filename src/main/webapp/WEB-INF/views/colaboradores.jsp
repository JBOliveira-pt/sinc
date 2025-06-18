<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="b" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Colaboradores</title>
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

        .card {
            border-radius: 15px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }

        .card:hover {
            transform: translateY(-2px);
        }

        .text-success {
            color: #28a745 !important;
        }

    </style>
</head>
<body>

<%@ include file="templates/navbar.jsp" %>

<div class="container mt-4">
    <div class="row" style="padding-top: 100px;">
        <h3 style="padding-bottom: 35px">Seus <strong>S.incs</strong></h3>
        <c:forEach items="${users}" var="user">
            <div class="col-md-3" style="overflow: hidden; min-width: 300px;">
                <div class="card mb-4 card-wrapper">
                    <a href="<c:url value='/profile/${user.id}'/>" class="text-decoration-none">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <img src="<c:out value="${user.profilePicture}" default="https://cdn-icons-png.freepik.com/512/8608/8608769.png"/>"
                                         class="rounded-circle me-3"
                                         style="width: 60px; height: 60px; object-fit: cover;"
                                         alt="Profile Picture">
                                    <div>
                                        <h5 class="mb-0">${user.username}</h5>
                                        <div style="line-height: 0.8; padding-top: 5px">
                                            <small class="text-muted" style="font-size: 0.9em;">${user.department}</small><br>
                                            <small class="text-muted" style="font-size: 0.7em;">${user.position}</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-end">
                                    <h4 class="mb-0 text-success">${matchPercentages[user.id]}%</h4>
                                    <small class="text-muted">de <strong>S.inc</strong></small>
                                </div>
                            </div>

                            <div class="mt-3">
                                <h6 class="mb-2">Interesses:</h6>
                                <div class="d-flex flex-wrap gap-2">
                                    <c:forEach items="${user.interestList}" var="interest">
                                        <span class="badge rounded-pill ${commonInterests[user.id].contains(interest) ? 'bg-success' : 'bg-secondary'}" style="padding: 8px 12px; font-weight: 500;">
                                                ${interest}
                                        </span>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>