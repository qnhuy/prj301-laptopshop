<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete User</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Delete User</h2>

        <%-- Hiển thị thông báo --%>
        <% if (session.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= session.getAttribute("error") %></div>
            <% session.removeAttribute("error"); %>
        <% } %>

        <c:set var="userId" value="${param.id}" />
        <c:if test="${not empty userId}">
            <p class="text-danger">Are you sure you want to delete user with ID: ${userId}?</p>
            <p>This action cannot be undone.</p>
            <form action="/laptopshop/admin/user/delete" method="post">
                <input type="hidden" name="id" value="${userId}">
                <button type="submit" class="btn btn-danger">Yes, Delete</button>
                <a href="/laptopshop/admin/user" class="btn btn-secondary">Cancel</a>
            </form>
        </c:if>
        <c:if test="${empty userId}">
            <p class="text-danger">No user ID provided.</p>
            <a href="/laptopshop/admin/user" class="btn btn-secondary">Back to User List</a>
        </c:if>
    </div>
</body>
</html>