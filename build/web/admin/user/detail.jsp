<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="Vũ Duy Lê - Dự án laptopshop" />
        <meta name="author" content="Vũ Duy Lê" />
        <title>Detail User - ${user.id}</title>
        <link href="${pageContext.request.contextPath}/resources/admin/css/styles.css" rel="stylesheet" />

        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>

    <body class="sb-nav-fixed">
        <jsp:include page="../layout/header.jsp" />
        <div id="layoutSidenav">
            <jsp:include page="../layout/sidebar.jsp" />
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Users</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="/laptopshop/admin">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="/laptopshop/admin/user">Users</a></li>
                            <li class="breadcrumb-item active">View detail</li>
                        </ol>
                        <div class="container mt-5">
                            <div class="row">
                                <div class="col-12 mx-auto">
                                    <div class="d-flex justify-content-between">
                                        <h3>User detail with id = ${user.id}</h3>
                                    </div>

                                    <hr />

                                    <div class="card" style="width: 60%">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/resources/admin/images/avatar/${user.avartar}"
                                             alt="ngu" style="display: block; margin: auto; width: 250px; height: 250px;">


                                        <div class="card-header">
                                            User information
                                        </div>
                                        <ul class="list-group list-group-flush">
                                            <li class="list-group-item">ID: ${user.id}</li>
                                            <li class="list-group-item">Email: ${user.email}</li>
                                            <li class="list-group-item">First name: ${user.firstName}</li>
                                            <li class="list-group-item">Last name: ${user.lastName}</li>
                                            <li class="list-group-item">Address: ${user.address}</li>
                                            <li class="list-group-item">Phone number: ${user.phone}</li>
                                            <li class="list-group-item">Role: ${user.roleId == 1 ? 'USER' : (user.roleId == 2 ? 'ADMIN' : '')}</li>


                                        </ul>
                                    </div>
                                    <a href="/laptopshop/admin/user" class="btn btn-success mt-3">Back</a>

                                </div>

                            </div>

                        </div>
                    </div>
                </main>
                <jsp:include page="../layout/footer.jsp" />
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/resources/admin/js/scripts.js"></script>

    </body>

</html>