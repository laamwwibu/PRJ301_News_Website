
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
        <c:if test="${ !(sessionScope.user.isIsAdmin())}" >
            <% 
                response.sendRedirect("MainPage");
            %>
        </c:if>
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
                    <form action="">
                        <input style="width: 100%;" type="text" placeholder="Search anything">
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

        <!-- HEADING -->

        <div class="text-center" style="font-weight: normal">
            <h2>Insert new news form: </h2>
        </div>



        <!-- MAIN-CONTENT -->
        <form action='InsertNews' method='post' enctype="multipart/form-data" >
            <input type="hidden" name="user_id" value="${sessionScope.user.getId()}">
            <table>
                <tr>
                    <td>
                        <select name="cat_id" required>           
                            <c:forEach items="<%= cat_name%>" var = "cat_name" >
                                <option value="<c:out value="${cat_name.key}"/>" > <c:out value="${cat_name.value.getName()}"/> </option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Title:</td>
                    <td><input type='text' name='title' required></td>
                </tr>
                <tr>
                    <td>Subtitle:</td>
                    <td><input type='text' name='subtitle' required></td>
                </tr>
                <tr>
                    <td>Content:</td>
                    <td><input type='text' name='content' required></td>
                </tr>
                <tr>
                    <td>Image:</td>
                    <td><input type="file" name="image" accept="image/*" required></td>
                </tr>

                <tr>
                    <td> <input type='submit' name='action' value='Submit'></td>
                </tr>
            </table>
        </form>

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
        
        <!-- Bootstrap script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
        crossorigin="anonymous"></script>

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