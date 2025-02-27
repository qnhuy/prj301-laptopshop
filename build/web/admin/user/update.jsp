<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
        <meta name="author" content="Hỏi Dân IT" />
        <title>Dashboard - Create User</title>

        <link href="${pageContext.request.contextPath}/resources/admin/css/styles.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

        <script>
            $(document).ready(() => {

                const avatarFile = $("#avatarFile");
                const orgImage = "${p.image}";
                if (orgImage) {
                    const urlImage = "${pageContext.request.contextPath}/resources/admin/images/product/" + orgImage;
                    $("#avatarPreview").attr("src", urlImage);
                    $("#avatarPreview").css({"display": "block"});
                }

                avatarFile.change(function (e) {
                    const imgURL = URL.createObjectURL(e.target.files[0]);
                    $("#avatarPreview").attr("src", imgURL);
                    $("#avatarPreview").css({"display": "block"});
                });
            });

            function removeImage() {
                const avatarFile = document.getElementById('avatarFile');
                const avatarPreview = document.getElementById('avatarPreview');

                // Reset file input
                avatarFile.value = '';

                // Hide the preview image
                avatarPreview.style.display = 'none';
                avatarPreview.src = '';
            }
        </script>

        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
        crossorigin="anonymous"></script>
    </head>

    <body class="sb-nav-fixed">
        <jsp:include page="../layout/header.jsp" />
        <div id="layoutSidenav">
            <jsp:include page="../layout/sidebar.jsp" />
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Manage Users</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active"><a href="/laptopshop/admin">Dashboard</a> </li>
                            <li class="breadcrumb-item active"><a href="/laptopshop/admin/user">Users</a> </li>
                            <li class="breadcrumb-item active">Update User</li>
                        </ol>
                        <div class="mt-5">
                            <div class="row">
                                <div class="col-md-6 col-12 mx-auto">
                                    <h3>Create a user</h3>
                                    <hr />
                                    <c:set value="${requestScope.user}" var="u"/>
                                    <form method="post" action="update"
                                          class="row" enctype="multipart/form-data">
                                        <div class="mb-3" style="display: none;">
                                            <label class=" form-label">Id:</label>
                                            <input type="text" class="form-control" name="id" value="${u.id}"
                                                   readonly="true" />
                                        </div>
                                        <div class="mb-3 col-12 col-md-6">

                                            <label class="form-label">Email:</label>
                                            <input type="email"
                                                   class="form-control"
                                                   name="email" value="${u.email}" readonly="true"/>

                                        </div>
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Password:</label>
                                            <input type="password"
                                                   class="form-control"
                                                   name="password" value="${u.password}"/>
                                        </div>
                                        <div class="mb-3 col-12 col-md-6">

                                            <label class="form-label">First Name:</label>
                                            <input type="text"
                                                   class="form-control "
                                                   name="firstName" value="${u.firstName}"/>

                                        </div>
                                        <div class="mb-3 col-12 col-md-6">

                                            <label class="form-label">Last Name:</label>
                                            <input type="text"
                                                   class="form-control "
                                                   name="lastName" value="${u.lastName}"/>

                                        </div>

                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Phone number:</label>
                                            <input type="text" class="form-control" name="phone" value="${u.phone}"/>
                                        </div>


                                        <div class="mb-3">
                                            <label class="form-label">Address:</label>
                                            <input type="text" class="form-control" name="address" value="${u.address}"/>
                                        </div>
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Role:</label>
                                            <select class="form-select" name="roleName">
                                                <option value="USER" ${u.roleId == 1 ? 'selected' : ''}>USER</option>
                                                <option value="ADMIN" ${u.roleId == 2 ? 'selected' : ''}>ADMIN</option>
                                            </select>
                                        </div>
                                        <input type="hidden" name="avatar" value="${u.avartar}" />
                                        <div class="mb-3 col-12 col-md-6">
                                            <label for="avatarFile" class="form-label">Avatar:</label>
                                            <input class="form-control" type="file" id="avatarFile"
                                                   accept=".png, .jpg, .jpeg" name="avatarFile" />
                                        </div>
                                        <div class="col-12 mb-3">
                                            <img style="max-height: 250px; display: block;"
                                                 alt="avatar preview" id="avatarPreview" src="${pageContext.request.contextPath}/resources/admin/images/avatar/${u.avartar}"/>
                                        </div>
                                        <div class="col-12 mb-3">
                                            <button type="button" class="btn btn-success" onclick="removeImage()">Remove Image</button>
                                        </div>
                                        <div class="col-12 mb-5">
                                            <button type="submit" class="btn btn-primary">Update</button>
                                        </div>

                                    </form>
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