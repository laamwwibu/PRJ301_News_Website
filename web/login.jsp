<%@page import="model.*"%>
<%@page import="java.util.*"  %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <!-- Icons -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <!-- Global CSS -->
    <link rel="stylesheet" href="css/styleGlobal.css">
    <!-- Login CSS -->
    <link rel="stylesheet" href="css/styleLogin.css">
</head>

<body>
    <div class="container">
        <div class="row nopadding login-body">
            <div class="col-md-8 nopadding">
                <div class="login-quote">
                    <h1>VICE is the definitive guide to enlightening information.</h1>
                </div>
            </div>
            <div class="col-md-4 login-content">
                <input type="checkbox" id="check">
                <div class="login form">
                    <header>Login</header>
                    <form action="UserLogIn" method="post">
                        <input type="text" name="username" placeholder="Enter your username">
                        <input type="password" name="pass" placeholder="Enter your password">
                        <input type="submit" class="button" value="Login">
                    </form>
                    <div class="signup">
                        <span class="signup">Don't have an account?
                            <label for="check">Signup</label>
                        </span>
                    </div>
                </div>
                <div class="registration form">
                    <header>Signup</header>
                    <form action="UserSignup" method="post">
                        <input type="text" name="username" placeholder="Username">
                        <input type="text" name="name" placeholder="Real name">
                        <input type="date" name="dob" placeholder="dd/mm/yyy">
                        <div class="signup-gender">
                            <label for="gender">Gender</label>
                            Male<input type="radio" name="gender" value="Male" id="gender-male" checked>
                            Female<input type="radio" name="gender" value="Female" id="gender-female">
                        </div>
                        <input type="password" name="pass" placeholder="Password">
                        <input type="submit" class="button" value="Sign up">
                    </form>
                    <div class="signup">
                        <span class="signup">Already have an account?
                            <label for="check">Login</label>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>