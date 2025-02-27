<%-- 
    Document   : register
    Created on : Oct 9, 2024, 6:04:22 PM
    Author     : NCPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%
    List<String> emails = (List<String>) request.getAttribute("emails");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Sign Up</title>

        <!-- Font Icon -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/login/fonts/material-icon/css/material-design-iconic-font.min.css">

        <!-- Main css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/login/css/style.css">

        <style>
            .error {
                color: red;
                font-size: 12px;
                display: block;
                margin-top: 5px;
            }
        </style>
        <script>
            var existingEmails = [];
            <c:forEach var="email" items="${requestScope.emails}">
            existingEmails.push("${email}");
            </c:forEach>

            function validateForm() {
                var password = document.getElementById("pass").value;
                var rePass = document.getElementById("re_pass").value;
                var email = document.getElementById("email").value; // Get the email value
                var passError = document.getElementById("passError");
                var termError = document.getElementById("termError");
                var emailError = document.getElementById("emailError"); // Email error message
                var firstName = document.getElementById("firstName").value; // Get first name value
                var lastName = document.getElementById("lastName").value; // Get last name value
                var firstNameError = document.getElementById("firstNameError");
                var lastNameError = document.getElementById("lastNameError");

                // Clear old error messages
                passError.innerHTML = "";
                termError.innerHTML = ""; // Clear checkbox error message
                emailError.innerHTML = ""; // Clear email error message
                firstNameError.innerHTML = ""; // Clear first name error message
                lastNameError.innerHTML = ""; // Clear last name error message

                var hasError = false; // Flag to track if there are errors

                // Check if first name is empty
                if (firstName.trim() === "") {
                    firstNameError.innerHTML = "First name is required"; // Display error message
                    hasError = true; // Set error flag
                }

                // Check if last name is empty
                if (lastName.trim() === "") {
                    lastNameError.innerHTML = "Last name is required"; // Display error message
                    hasError = true; // Set error flag
                }

                // Check if email is empty
                if (email.trim() === "") {
                    emailError.innerHTML = "Email is required"; // Display error message
                    hasError = true; // Set error flag
                }

                // Check if password is empty
                if (password.trim() === "") {
                    passError.innerHTML = "Password is required"; // Display error message
                    hasError = true; // Set error flag
                }

                // Check if repeated password is empty
                if (rePass.trim() === "") {
                    passError.innerHTML = "Please repeat your password"; // Display error message
                    hasError = true; // Set error flag
                }

                // Check if email already exists
                if (existingEmails.includes(email)) {
                    emailError.innerHTML = "Email already exists"; // Display error message
                    hasError = true; // Set error flag
                }

                // Check if password and repeated password match
                if (password !== rePass) {
                    passError.innerHTML = "Passwords do not match"; // Display error message
                    hasError = true; // Set error flag
                }

                // Check if the checkbox is not checked
                if (!document.getElementById("agree-term").checked) {
                    termError.innerHTML = "You must agree to the terms"; // Display error message
                    hasError = true; // Set error flag
                }

                return !hasError; // If there are no errors, allow form submission
            }



        </script>
    </head>
    <body>

        <div class="main">

            <!-- Sign up form -->
            <section class="signup">
                <div class="container">
                    <div class="signup-content">
                        <div class="signup-form">
                            <h2 class="form-title">Sign up</h2>
                            <form method="POST" action="register" class="register-form" id="register-form" onsubmit="return validateForm()">
                                <div class="form-group">
                                    <label for="firstName"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                    <input type="text" name="firstName" id="firstName" placeholder="First Name"/>
                                    <span class="error" id="firstNameError"></span> <!-- For displaying first name error -->
                                </div>
                                <div class="form-group">
                                    <label for="lastName"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                    <input type="text" name="lastName" id="lastName" placeholder="Last Name"/>
                                    <span class="error" id="lastNameError"></span> <!-- For displaying last name error -->
                                </div>

                                <div class="form-group">
                                    <label for="email"><i class="zmdi zmdi-email"></i></label>
                                    <input type="email" name="email" id="email" placeholder="Your Email"/>
                                    <span class="error" id="emailError"></span> <!-- Thẻ để hiển thị lỗi email -->
                                </div>
                                <div class="form-group">
                                    <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                                    <input type="password" name="password" id="pass" placeholder="Password"/>
                                </div>
                                <div class="form-group">
                                    <label for="re_pass"><i class="zmdi zmdi-lock-outline"></i></label>
                                    <input type="password" name="re_pass" id="re_pass" placeholder="Repeat your password"/>
                                    <span class="error" id="passError"></span> <!-- Thẻ để hiển thị lỗi mật khẩu -->
                                </div>
                                <div class="form-group">
                                    <input type="checkbox" name="agree-term" id="agree-term" class="agree-term" />
                                    <label for="agree-term" class="label-agree-term"><span><span></span></span>I agree all statements in <a href="#" class="term-service">Terms of service</a></label>
                                    <span class="error" id="termError"></span> <!-- Thẻ để hiển thị lỗi checkbox -->
                                </div>
                                <div class="form-group form-button">
                                    <input type="submit" name="signup" id="signup" class="form-submit" value="Register"/>
                                </div>
                            </form>
                        </div>
                        <div class="signup-image">
                            <figure><img src="${pageContext.request.contextPath}/resources/login/images/signup-image.jpg" alt="sing up image"></figure>
                            <a href="/laptopshop/login" class="signup-image-link">I am already member</a>
                        </div>
                    </div>
                </div>
            </section>



        </div>

        <!-- JS -->
        <script src="${pageContext.request.contextPath}/resources/login/vendor/jquery/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/login/js/main.js"></script>
    </body>
</html>
