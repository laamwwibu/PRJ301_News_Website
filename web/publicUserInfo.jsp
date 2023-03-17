<%@page import="model.User"%>
<%@page import="model.Category"%>
<%@page import="java.util.*"  %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>UserInfo</title>
        <!-- Embed Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <!-- Icons -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!-- Embed Global CSS -->
        <link rel="stylesheet" href="css/styleGlobal.css">
        <!-- Embed category CSS -->
        <link rel="stylesheet" href="css/styleCategory.css">
        <!-- Embed userInfo CSS -->
        <link rel="stylesheet" href="css/styleUserInfo.css">

    </head>

    <body>
        <!-- NAVBAR -->
        <nav class="navbar navbar-expand-lg fixed-top">
            <div class="container-fluid">
                <!-- NAVBAR -->
                <div class="navbar-logo col-md-1">
                    <a class="navbar-brand" href="MainPage">
                        <img style="width: 100px;" src="image/branding/vice logo.png" alt="">
                    </a>
                </div>
                <!-- NAVBAR TOOGLER -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
                        aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <!-- NAVBAR CATEGORY -->
                <div class="collapse navbar-collapse col-md-6" id="navbarNavDropdown">
                    <ul class="navbar-nav">
                        <%
                            HashMap<Integer,Category> cat_name = (HashMap<Integer,Category>) session.getAttribute("cat_list");
                            for (int key : cat_name.keySet()) {
                        %>
                        <div class="nav-item">
                            <a class="nav-link hover-animation-underline" href="Search?cat_id=<%= cat_name.get(key).getId() %>">
                                <%= cat_name.get(key).getName()%></a>
                        </div>
                        <%}%>
                    </ul>
                </div>
                <!-- NAVBAR SEARCH -->
                <div class="col-md-3 navbar-search">
                    <form action="Search">
                        <input style="width: 100%;height: 44px; border-radius: 100px; padding: 0px 20px" type="text" name="title" placeholder="Search anything">
                        <button style="border: 0px;" type="submit" class="rounded-circle nopadding">
                            <i class="material-icons hover-animation-grow">search</i>
                        </button>
                    </form>
                </div>

                <!-- NAVBAR PROFILE -->
                <div class="col-md-2 navbar-login navbar-collapse" id="navbarNavDropdown">
                    <% String user = "user";
                         int ID = 0;
                         if (session.getAttribute("user") != null) {  
                        User user1 = (User)session.getAttribute("user");
                        user = user1.getName();
                        ID = user1.getId();
                        }%>
                    <p class="nopadding">Hello, <%= user %></p>
                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <a class="dropdown-toggle" href="#" id="navbarDropdownMenuLink" id="navbar-icon-user"
                               role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="material-icons hover-animation-grow">person</i>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuLink">
                                <!-- cái này th?ng nào làm jsp thì phân lo?i theo ki?u ng??i dùng -->
                                <% if (session.getAttribute("user") == null) {  %>
                                <li><a class="dropdown-item" href="login.jsp">Login</a></li>
                                <li><a class="dropdown-item" href="login.jsp">Sign up</a></li>
                                    <%} else{ %>
                                <li><a class="dropdown-item" href="UserLogout">Log out</a></li>
                                <li><a class="dropdown-item" href="Profile?id=<%= ID %>">Profile</a></li>
                                    <%}%>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- spacer for fixed navbar -->
        <div style="height: 84px;" class="spacer"></div>

        <div class="container-fluid user-info">
            <div class="row nopadding">
                <div class="col-md-6 user-info-main">
                    <div class="user-info-main-image">
                        <img class="rounded-circle" src="image/user/alan wong.webp" alt="">
                    </div>
                    <div class="user-info-main-text">
                        <h1><c:out value="${requestScope.user.getUname()}"/></h1>
                        <h4>${requestScope.user.getUname()}@vice.com</h4>
                    </div>
                </div>
                <div class="col-md-6 container-fluid user-info-detail">
                    <div class="user-info-detail-body">
                        <% User user1 = (User) request.getAttribute("user"); %>
                        <p><span>Username: </span><%= user1.getUname() %></p>
                        <p><span>Gender: </span> <%= user1.getGender()%></p>
                        <p><span>Date Of Birth: </span> <%= user1.getDob()%></p>
                    </div>
                </div>
            </div>
        </div>



        <c:if test="${requestScope.user.isIsAdmin()}">
            <!-- <AUTHOR NAME>'s NEWS -->
            <div class="container-fluid">
                <div class="row nopadding">
                    <!-- <AUTHOR NAME>'s NEWS TITLE -->
                    <div class="latest-title user-info-titles nopadding">
                        <h1>${requestScope.user.getUname()}'s</h1>
                        <h1>NEWS</h1>
                    </div>
                    <c:forEach var="posted" items="${requestScope.posted_news}" >
                        <div class="card col-md-4 nopadding">
                            <img src="<c:out value="${sessionScope.location}"/><c:out value="${posted.getImage()}"/>.webp" class="card-img-top" alt="...">
                            <div class="card-body">
                                <h5 class="card-subtitle"><c:out value="${ cat_name.get(posted.getCat_id()).getName()}" />
                                    <h3 class="card-title"><c:out value="${posted.getTitle()}"/></h3>
                                    <p class="card-text"><c:out value="${posted.getSubtitle()}"/></p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <!-- PAGING NAVIGATOR -->
            <div class="paging-nav">
                <div class="paging-prev">
                    <h4>Newer</h4>
                </div>
                <div class="paging-progress">
                    <h4>1</h4>
                    <h4>5</h4>
                </div>
                <div class="paging-next">
                    <h4>Older</h4>
                </div>
            </div>
        </c:if>
        <!-- FOOTER -->
        <div class="footer">
            <img class="rotate" style="width: 100px;" src="image/branding/VMG-logo-updated.png" alt="">
            <ul>
                <li>Tr?n Th? Hùng</li>
                <li>Lý Th? L??ng</li>
                <li>Phùng Phúc Lâm</li>
                <li>Nguy?n Hoàng Hi?p</li>
                <li>Nguy?n Chí Trung</li>
            </ul>
            <p>@ 2023 PRj301 HE1725</p>
        </div>

        <!-- Bootstrap script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
        crossorigin="anonymous"></script>
    </body>

</html>