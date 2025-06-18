<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top" style="padding: 0px 40px; ">
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
                <div class="ProfileLogo" style=" padding-bottom: 0px; padding-top:0px;"></div>
            </a>
            <ul class="navbar-nav ms-auto mb-3 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains("home") ? "active-nav" : ""}"
                       href="/home">Início</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains("store") ? "active-nav" : ""}"
                       href="/store">S.tore</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains("colaboradores") ? "active-nav" : ""}"
                       href="/colaboradores">Colaboradores</a>
                </li>
               <li class="nav-item">
                   <a class="nav-link ${pageContext.request.requestURI.contains("error") ? "active-nav" : ""}"
                      href="/error">Mensagens</a>
               </li>
            </ul>
        </div>
        <div class="d-flex align-items-center">
            <a class="text-reset me-3" href="">
            </a>
            <div class="dropdown">
                <img
                        id="navbarDropdownMenuAvatar"
                        src="<c:out value="${authUser.profilePicture}" default="https://cdn-icons-png.freepik.com/512/8608/8608769.png"/>"
                        role="button"
                        class="rounded-circle avatar-img"
                        alt="Profile Picture"
                        data-bs-toggle="dropdown"
                        loading="lazy"
                        aria-expanded="false"
                />
                <ul
                        class="dropdown-menu dropdown-menu-end"
                        aria-labelledby="navbarDropdownMenuAvatar"
                >
                    <li><a class="dropdown-item" href="/profile/<c:out value="${authUser.id}"/>">Perfil</a></li>
                    <li><a class="dropdown-item" id="logoutButton" href="/logout">Logout</a></li>
                </ul>
            </div>
            <div class="dropdown">
                <a>
                    <img
                            src="/images/S.InCoin.png"
                            class="rounded-circle nav-coin"
                            alt="S.InCoin"
                            style="margin-left: 10px"
                    />
                    <span class="badge badge-notification coin-balance"
                          style="align-content: center; height: 22px; border-radius: 22px; font-size: 10px; position: absolute; top: 16px; left: 16px; background-color: #398DC3; box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.5);">${authUser.coins}</span>
                </a>
                <ul
                        class="dropdown-menu dropdown-menu-end"
                        aria-labelledby="navbarDropdownMenuLink"
                >
                </ul>
            </div>
        </div>
    </div>
</nav>