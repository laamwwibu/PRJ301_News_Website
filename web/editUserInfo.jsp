<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Info</title>
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <!-- Icons -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!-- Global CSS -->
        <link rel="stylesheet" href="css/styleGlobal.css">
        <!-- Embed userInfo CSS -->
        <link rel="stylesheet" href="css/styleUserInfo.css">
        <!-- Embed editUserInfo  CSS-->
        <link rel="stylesheet" href="css/styleEditUserInfo.css">
    </head>

    <body>
        <form action="UserUpdate" method="post">
            <div class="container">
                <div class="row nopadding">
                    <div class="col-md-6 user-info-main">
                        <div class="user-info-main-image">
                            <img class="rounded-circle" src="image/user/alan wong.webp" alt="">
                        </div>
                        <div class="user-info-main-text">
                            <c:set var="user" value="${sessionScope.user}"/>
                            <h1 id="h1-content"><c:out value="${user.getName()}"/></h1>
                            <h4><c:out value="${user.getName()}"/>@vice.com</h4>
                        </div>
                    </div>
                    <div class="col-md-6 user-info-detail">
                        <div class="user-info-detail-body">
                            <table>
                                <tr>
                                    <td>Id:</td>
                                    <td><input type="text" name ="id" value="${user.getId()}" readonly><br></td>
                                </tr>
                                <tr>
                                    <td>Username:</td>
                                    <td><input type="text" name="username" value="${user.getUname()}" ><br></td>
                                </tr>
                                <tr>
                                    <td>Real Name:</td>
                                    <td><input id="input-realname" name="realname" oninput="changeH1Content()" type="text"
                                               value="${user.getName()}"></td>
                                </tr>
                                <tr>
                                    <td>Gender:</td>
                                    <td>
                                        Male <input type="radio" name="gender" value="male" id="gender-male" checked>
                                        Female <input type="radio" name="gender" value="female" id="gender-female">
                                    </td>
                                </tr>
                                <tr>
                                    <td>Date Of Birth</td>
                                    <td><input type="date" name="dob" value="${user.getDob()}"><br></td>
                                </tr>
                                <tr>
                                    <td>Password</td>
                                    <td><input type="text" name="pass" value="${user.getPass()}"><br></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type="submit" class="button" value="Submit">
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <script>
            function changeH1Content() {
                const inputText = document.getElementById('input-realname').value;
                const h1Content = document.getElementById('h1-content');
                h1Content.innerHTML = inputText;
            }
        </script>
    </body>

</html>