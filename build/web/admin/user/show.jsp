<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User List</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* Đảm bảo các nút không bị ẩn */
        .btn-sm {
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2>User List</h2>

        <%-- Hiển thị thông báo --%>
        <% if (session.getAttribute("message") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= session.getAttribute("message") %>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <% session.removeAttribute("message"); %>
        <% } %>
        <% if (session.getAttribute("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= session.getAttribute("error") %>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <% session.removeAttribute("error"); %>
        <% } %>

        <a href="/laptopshop/admin/user/create" class="btn btn-primary mb-3">Create New User</a>

        <table class="table table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Email</th>
                    <th>Full Name</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty data}">
                        <c:forEach var="user" items="${data}">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.email}</td>
                                <td>${user.firstName} ${user.lastName}</td>
                                <td>${user.roleId == 1 ? 'User' : 'Admin'}</td>
                                <td>
                                    <a href="/laptopshop/admin/user/detail?id=${user.id}" class="btn btn-info btn-sm">View</a>
                                    <a href="/laptopshop/admin/user/update?id=${user.id}" class="btn btn-warning btn-sm">Update</a>
                                    <a href="/laptopshop/admin/user/delete?id=${user.id}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete user ${user.id}?');">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" class="text-center text-muted">No users found.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <%-- Debug thông tin data --%>
        <c:if test="${empty data}">
            <p class="text-warning">Debug: Data attribute is empty or null. Check servlet logic.</p>
        </c:if>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>