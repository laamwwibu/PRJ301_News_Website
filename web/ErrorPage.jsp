<%-- 
    Document   : ErrorPage
    Created on : Mar 1, 2023, 11:57:35 PM
    Author     : Inspiron
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% String returnPage = (String)request.getAttribute("return_page"); %>
        <jsp:include page = "<%= returnPage %>"/>
        <h1 class="text-center" style="font-style: italic; color: red"><%= (String)request.getAttribute("error")  %></h1>
    </body>
</html>
