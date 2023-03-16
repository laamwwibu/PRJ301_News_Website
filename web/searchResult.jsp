
<%@page import="java.util.*"%>
<%@page import="model.*"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Category</title>
        <!-- Icons -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <!-- Embed Global CSS -->
        <link rel="stylesheet" href="css/styleGlobal.css">
        <!-- Embed category CSS -->
        <link rel="stylesheet" href="css/styleCategory.css">
    </head>

    <body>
        <!-- NAVBAR -->
        <nav class="navbar navbar-expand-lg fixed-top">
            <div class="container-fluid">
                <!-- NAVBAR -->
                <div class="navbar-logo col-md-3">
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
                            HashMap<Integer, Category> cat_name = (HashMap<Integer, Category>) session.getAttribute("cat_list");
                        %>
                        <c:forEach items="<%= cat_name%>" var = "cat_name" >
                            <div class="nav-item">
                                <a class="nav-link hover-animation-underline" href="Search?cat_id=<c:out value="${cat_name.key}"/>"  ><c:out value="${cat_name.value.getName()}"/></a>
                            </div>
                        </c:forEach>
                    </ul>
                </div>
                <!-- NAVBAR LOGIN -->
                <div class="navbar-login col-md-3">
                    <a href="" id="navbar-icon-user">
                        <i class="material-icons hover-animation-grow">person</i>
                    </a>
                </div>
            </div>
        </nav>
        <!-- spacer for fixed navbar -->
        <div style="height: 84px;" class="spacer"></div>
        <%
            HashMap<Integer, User> user_nameList = (HashMap<Integer, User>) request.getAttribute("user_list");
            ArrayList<News> news_list = (ArrayList<News>) request.getAttribute("news_list");
            String title = (String) request.getAttribute("title");
        %>
        <!-- HEADING -->
        <div class="text-center">
            <h1>Search result for :</h1>
        </div>
        <div class="text-center" style="font-weight: normal">
            <h2><%= title%></h2>
        </div>

        <form action="Search" method="get">
            <input type="hidden" name="title" value="<%=title%>">
            <select name="cat_id">           
                <c:forEach items="<%= cat_name%>" var = "cat_name" >
                    <option value="<c:out value="${cat_name.key}"/>" > <c:out value="${cat_name.value.getName()}"/> </option>
                </c:forEach>
            </select>
            <input type='submit' name='action' value='Filter'>
        </form>
        <%
            for (News news : news_list) {
        %>
        <!-- MAIN-CONTENT -->
        <div class="container-fluid">
            <!-- 4 rows of news -->
            <div class="row nopadding">
                <div class="card col-md-4 nopadding">
                    <a href="GetNews?news_id=<%= news.getNews_id()%>" ><img src="<%= session.getAttribute("location")%><%= news.getImage()%>.webp" class="card-img-top" alt="..."></a>
                    <div class="card-body">
                        <h3 class="card-title"><%= news.getTitle()%></h3>
                        <p class="card-text"><%= news.getSubtitle()%></p>
                        <h6 class="card-text"><%= user_nameList.get(news.getUser_id()).getName()%></h6>
                    </div>
                </div>
                <%}%>
            </div>
        </div>


        <!-- FOOTER -->
        <div class="footer">
            <img class="rotate" style="width: 100px;" src="image/branding/VMG-logo-updated.png" alt="">
            <ul>
                <li>Tr?n Th? H?ng</li>
                <li>L? Th? L??ng</li>
                <li>Ph?ng Ph?c L?m</li>
                <li>Nguy?n Ho?ng Hi?p</li>
                <li>Nguy?n Ch? Trung</li>
            </ul>
            <p>@ 2023 PRj301 HE1725</p>
        </div>
    </body>

</html>