<%@page import="model.User"%>
<%@page import="model.Category"%>
<%@page import="java.util.*"  %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                        <input style="width: 100%;height: 44px; border-radius: 100px; padding: 0px 20px" type="text" name="title" placeholder="Search anything" required="">
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
                                <!-- c?i n?y th?ng n?o l?m jsp th? ph?n lo?i theo ki?u ng??i d?ng -->
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
                        <c:choose>
                            <c:when test="${requestScope.puser.getGender() eq 'Male' }">
                                <img class="rounded-circle" src="image/user/male.webp" alt="">
                            </c:when>
                            <c:when test="${requestScope.puser.getGender() eq 'Female'}">
                                <img class="rounded-circle" src="image/user/female.webp" alt="">
                            </c:when>
                            <c:otherwise>
                                <img class="rounded-circle" src="image/user/female.webp" alt="">
                            </c:otherwise>     
                        </c:choose>
                    </div>
                    <div class="user-info-main-text">
                        <h1><c:out value="${requestScope.puser.getName()}"/></h1>
                        <h4>${requestScope.puser.getUname()}@vice.com</h4>
                    </div>
                </div>
                <div class="col-md-6 container-fluid user-info-detail">
                    <div class="user-info-detail-body">
                        <c:set var="puser" value="${requestScope.puser}"/>
                        <p><span>Username: </span>${puser.getUname()}</p>
                        <p><span>Gender: </span> ${puser.getGender()}</p>
                        <p><span>Date Of Birth: </span> ${puser.getDob()}</p>
                    </div>
                </div>
            </div>
        </div>



        <c:if test="${requestScope.puser.isIsAdmin()}">
            <!-- <AUTHOR NAME>'s NEWS -->
            <div class="container-fluid">
                <div class="row nopadding">
                    <!-- <AUTHOR NAME>'s NEWS TITLE -->
                    <div class="latest-title user-info-titles nopadding">
                        <h1>${requestScope.puser.getName()}'s</h1>
                        <h1>NEWS</h1>
                    </div>
                    <c:set var ="page_posted" value="1"/>

                    <c:if test="${param.page_posted != null}">
                        <c:set var="page_posted" value="${param.page_posted}"/>
                    </c:if>
                    <c:if test="${requestScope.posted_news.size()>0}">
                        <c:set var="index" value="${3*page_posted-1}"/>
                        <c:set var="user_list" value="${requestScope.user_list}"/>
                        <c:set var="end" value="${index}"/>
                        <c:if test="${end > requestScope.posted_news.size()-1}">
                            <c:set var="end" value="${requestScope.posted_news.size()-1}"/>
                        </c:if>
                        <div class="row nopadding">
                            <c:forEach begin="${index-2}" end="${end}" var="posted" items="${requestScope.posted_news}" >
                            <div class="card col-md-4 nopadding">
                                <a href="GetNews?news_id=${posted.getNews_id()}" ><img style="height: 300px; object-fit: cover" src="<c:out value="${sessionScope.location}"/><c:out value="${posted.getImage()}"/>" class="card-img-top" alt="..."></a>
                                <div class="card-body">
                                    <a href="Search?cat_id=${posted.cat_id}"><h5 class="card-subtitle"><c:out value="${ cat_list.get(posted.getCat_id()).getName()}" /></h5></a>
                                    <a href="GetNews?news_id=${posted.news_id}"><h3 class="card-title"><c:out value="${posted.getTitle()}"/></h3></a>
                                    <a href="GetNews?news_id=${posted.news_id}"><p class="card-text"><c:out value="${posted.getSubtitle()}"/></p></a>
                                </div>
                            </div>
                        </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
            <!-- PAGING NAVIGATOR -->
            <div class="paging-nav">
                <div class="paging-prev">
                    <c:if test="${page_posted == 1}">
                        <h4>Newer</h4>
                    </c:if>
                    <c:if test="${page_posted >= 2}">
                        <h4><a href="publicUserInfo?user_id=${puser.getId()}&page_posted=${page_posted-1}">Newer</a></h4>
                    </c:if>
                </div>
                <div class="paging-progress">
                    <h4>${page_posted}</h4>
                </div>
                <div class="paging-next">
                    <c:if test="${end < requestScope.posted_news.size()-1}">
                        <h4><a href="publicUserInfo?user_id=${puser.getId()}&page_posted=${page_posted+1}">Older</a></h4>
                    </c:if>
                    <c:if test="${end >= requestScope.posted_news.size()-1}">
                        <h4>Older</h4>
                    </c:if>
                </div>
            </div>
        </c:if>
        <!-- footer -->
        <div class="footer">
            <img class="rotate" style="width: 100px;" src="image/branding/VMG-logo-updated.png" alt="">
            <ul>
                <li>Trần Thế Hùng</li>
                <li>Lý Thế Lượng</li>
                <li>Phùng Phúc Lâm</li>
                <li>Nguyễn Hoàng Hiệp</li>
                <li>Nguyễn Chí Trung</li>
            </ul>
            <p>@ 2023 PRj301 HE1725</p>
        </div> 

        <!-- Bootstrap script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
        crossorigin="anonymous"></script>
    </body>

</html>