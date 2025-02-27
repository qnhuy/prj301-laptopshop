<%-- 
   Document   : login
   Created on : Oct 9, 2024, 6:04:06 PM
   Author     : NCPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Sign In</title>

        <!-- Font Icon -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/login/fonts/material-icon/css/material-design-iconic-font.min.css">

        <!-- Main css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/login/css/style.css">
        <script>
            document.getElementById('eyeIcon').addEventListener('click', function () {
                var passwordInput = document.getElementById('your_pass');
                var eyeIcon = document.getElementById('eyeIcon');

                // Thay đổi type của input để ẩn/hiện mật khẩu
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text'; // Hiển thị mật khẩu
                    eyeIcon.classList.remove('fa-eye');
                    eyeIcon.classList.add('fa-eye-slash'); // Thay đổi icon
                } else {
                    passwordInput.type = 'password'; // Ẩn mật khẩu
                    eyeIcon.classList.remove('fa-eye-slash');
                    eyeIcon.classList.add('fa-eye'); // Đổi lại icon
                }
            });
        </script>

        <!-- CSS cho form và icon -->
        <style>
            .form-group {
                position: relative;
            }

            .toggle-password {
                position: absolute;
                top: 50%;
                right: 10px;
                transform: translateY(-50%);
                cursor: pointer;
            }
        </style>
    </head>
    <body>

        <div class="main">



            <!-- Sing in  Form -->
            <section class="sign-in">
                <div class="container">
                    <div class="signin-content">
                        <div class="signin-image">
                            <figure><img src="${pageContext.request.contextPath}/resources/login/images/signin-image.jpg" alt="sing up image"></figure>
                            <a href="/laptopshop/register" class="signup-image-link">Create an account</a>
                        </div>

                        <div class="signin-form">
                            <h2 class="form-title">Sign in</h2>
                            <form method="POST" action="login" class="register-form" id="login-form" onsubmit="return validateForm()">
                                <span class="error">
                                    ${error}

                                </span>

                                <div class="form-group">
                                    <label for="your_name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                    <input type="email" name="email" id="your_name" placeholder="Your Email" value="${email}"/>
                                </div>
                                <div class="form-group position-relative">
                                    <label for="your_pass"><i class="zmdi zmdi-lock"></i></label>
                                    <input type="password" name="password" id="your_pass" placeholder="Password" value="${password}" class="form-control"/>

                                    <!-- Icon để ẩn/hiện mật khẩu -->
                                    <span class="toggle-password position-absolute" style="top: 50%; right: 10px; transform: translateY(-50%); cursor: pointer;">
                                        <i class="fas fa-eye" id="eyeIcon"></i>
                                    </span>
                                </div>
                                <div class="form-group form-button">
                                    <input type="submit" name="signin" id="signin" class="form-submit" value="Log in"/>
                                </div>
                            </form>                   
                        </div>
                    </div>
                </div>
            </section>


        </div>
        <script>
            function validateForm() {
                var name = document.getElementById("your_name").value;
                var pass = document.getElementById("your_pass").value;

                if (name === "") {
                    alert("Name cannot be empty");
                    return false;
                }

                if (pass === "") {
                    alert("Password cannot be empty");
                    return false;
                }

                return true;  // Nếu tất cả hợp lệ, cho phép form submit
            }
        </script>               

        <!-- JS -->
        <script src="${pageContext.request.contextPath}/resources/login/vendor/jquery/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/login/js/main.js"></script>
    </body>
</html>
