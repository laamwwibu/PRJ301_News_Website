<%@page import="java.util.*"%>
<%@page import="model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Category</title>
        <!--Bootstrap-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <!-- Icons -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!-- Embed Global CSS -->
        <link rel="stylesheet" href="css/styleGlobal.css">
        <!-- Embed newsInfo CSS -->
        <link rel="stylesheet" href="css/styleNewsInfo.css">
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
        <%
            News news = (News) request.getAttribute("news");
            HashMap<Integer,User> user_nameList = (HashMap<Integer,User>) request.getAttribute("user_list");
            ArrayList<News> listNews = (ArrayList<News>) request.getAttribute("sameCategoryNews");
            ArrayList<Comments> commentList = (ArrayList<Comments>) request.getAttribute("commentList");
        %>
        <!-- spacer for fixed navbar -->
        <div style="height: 84px;" class="spacer"></div>

        <div class="scroller">
            <!-- HEADING -->
            <div class="heading">
                <div class="container-fluid">
                    <!-- getCategory here -->
                    <a class="heading-category" href="Search?cat_id=<%=news.getCat_id()%>"><%= cat_name.get(news.getCat_id()).getName() %></a>
                    <!-- getTitle here -->
                    <h1 class="heading-title"> <%= news.getTitle() %> </h1>
                </div>
            </div>
            <!-- SUB-HEADING -->
            <div class="sub-heading">
                <div class="container-fluid">
                    <div class="col-md-7 nopadding">
                        <!-- getSubtitle here -->
                        <h4 class="sub-heading-text"><%= news.getSubtitle() %></h4>
                        <div class="author">
                            <a class="author-info" href="publicUserInfo?user_id=<%= news.getUser_id()%>">
                                <!-- Author image here -->  
                                <c:choose>
                                    <c:when test="${requestScope.user_list.get(news.getUser_id()).getGender() eq 'Male' }">
                                        <img class="author-image rounded-circle" src="image/user/male.webp" alt="">
                                    </c:when>
                                    <c:when test="${requestScope.user_list.get(news.getUser_id()).getGender() eq 'Female'}">
                                        <img class="author-image rounded-circle" src="image/user/female.webp" alt="">
                                    </c:when>
                                    <c:otherwise>
                                        <img class="author-image rounded-circle" src="image/user/female.webp" alt="">
                                    </c:otherwise>     
                                </c:choose>
                                <p class="author-name nopadding">By <span><%= user_nameList.get(news.getUser_id()).getName() %></span></p>
                            </a>
                        </div>

                        <c:if test="${sessionScope.user != null}">
                            <div class="button-submit">
                                <c:choose>
                                    <c:when test="${requestScope.status eq 'saved' }">
                                        <a class="saved">Saved</a>
                                    </c:when>
                                    <c:when test="${requestScope.status eq 'unsaved' }">
                                        <a onclick="checkSession()" href="SaveNews?news_id=${news.getNews_id()}&user_id=${sessionScope.user.getId()}">Save This New</a>
                                    </c:when>
                                </c:choose>
                            </div>
                        </c:if>

                        <c:if test="${( sessionScope.user.isIsAdmin() )}" >
                            <form id="delete-news" onsubmit="return confirm('Are you sure you want to delete this news?')" action="DeleteNews" method="post">
                                <input type="hidden" name="news_id" value="<%= news.getNews_id() %>">
                                <div class="function-button">
                                    <input class="button-submit" type="submit" value="Delete">
                                </div>
                            </form>
                        </c:if>    
                    </div>
                </div>
            </div>
            <!-- NEWS CONTENT -->
            <div class="news-content">
                <div class="container-fluid">
                    <div class="col-md-7 nopadding">
                        <div class="news-content-image">
                            <img src="<%= session.getAttribute("location") %><%= news.getImage() %>" alt="">
                        </div>
                        <!-- getText here -->
                        <div class="news-content-text">
                            <p><%= news.getContent()%> </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--COMMENT-->
        <div class ="comment">
            <div class = "comment-box" id="com">
                <form action="CommentController" method="post">
                    <c:if test="${param.action == 'edit'}">
                        <input type="text" style="display: none" name="action" value="update">
                        <input type="text" style="display: none" name="comment_id" value="${param.com_id}">
                        <c:set var="value" value="${param.content}"/>
                    </c:if>
                    <c:if test="${param.action == null}">
                        <input type="text" style="display: none" name="action" value="insert">
                        <c:set var="value" value=""/>
                    </c:if>
                    <input type="text" style="display: none" name="news_id" value=<%= news.getNews_id() %>>
                    <h3>Comment(<c:out value="${requestScope.listComments.size()}"/>)</h3>
                    <table>
                        <div class="container">
                            <div class="row comment-box-text">
                                <textarea class="news-content-text" type="text" name="comment_content" placeholder="Type a comment..." rows="4" onclick="checkSession()" required="">${value}</textarea>
                            </div>
                            <div id="function-button-post" class="row function-button">
                                <input id="button-submit-save" class="button-submit" type="submit" value="Post Comment">
                            </div>
                        </div>
                    </table>
                </form>
            </div>
        </div>
        <div class="comment">
            <c:set var="user_nameList" value="${requestScope.user_list}"/>
            <c:forEach var = "commentList" varStatus="loop" items="${requestScope.commentList}">
                <div class="comment-list">
                    <div class="comment-list-user">
                        <a style="display: inline-block" href="publicUserInfo?user_id=${commentList.getUser_id()}">
                            <i class="material-icons rounded-circle nopadding">person</i>
                            <p class="nopadding" style="display: inline-block">${user_nameList[commentList.getUser_id()].getUname()}</p>
                        </a>
                    </div>
                    <div class="comment-list-body">
                        <p><c:out value="${commentList.getCommment_content()}"/></p>
                        <c:if test="${sessionScope.user != null}">
                            <c:if test="${commentList.getUser_id() == sessionScope.user.getId()}">
                                <!-- chi chinh sua dc comment cua minh -->
                                <a href="GetNews?news_id=${news.getNews_id()}&action=edit&com_id=${commentList.getComment_id()}&content=${commentList.getCommment_content()}&#com" class = "button-submit">Edit</a>
                                <a onclick="return confirm('Are you sure you want to delete this comment?')" href="deleteComment?news_id=${news.getNews_id()}&comment_id=${commentList.getComment_id()}" class="button-submit">Delete</a>
                            </c:if>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>
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
        <script>
            function checkSession() {
                // Retrieve data from the server-side using JSP expressions
                var username = <%= session.getAttribute("user") %>;

                // Use the server-side data in the JavaScript code
                if (!username) {
                    event.preventDefault(); // prevent going to href first
                    window.location.href = "login.jsp";
                    alert("You have to login or sign up to commit this action");
                }
            }
        </script>

        <!-- Bootstrap script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
        crossorigin="anonymous"></script>
    </body>

</html>