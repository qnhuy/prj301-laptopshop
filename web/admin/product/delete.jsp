<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="SE1927 - Dự án laptopshop" />
        <meta name="author" content="SE1927 - PRJ301" />
        <title>Delete product - ${id}</title>

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
                        <h1 class="mt-4">Manage Products</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active"><a href="/laptopshop/admin">Dashboard</a> </li>
                            <li class="breadcrumb-item active"><a href="/laptopshop/admin/product">Products</a> </li>
                            <li class="breadcrumb-item active">Delete</li>
                        </ol>
                        <div class="mt-5">
                            <div class="row">
                                <div class="col-md-6 col-12 mx-auto">
                                    <div class="d-flex justify-content-between">
                                        <h3>Delete the product with id = ${id}</h3>
                                    </div>

                                    <hr />
                                    <div class="alert alert-warning" role="alert">
                                        Are you sure to delete this product?
                                    </div>
                                    <form method="post" action="delete"
                                          modelAttribute="newProduct">
                                        <div class="mb-3" style="display: none;">
                                            <label class=" form-label">Id:</label>
                                            <input type="text" class="form-control" name="id" value="${id}"
                                                   readonly="true" />
                                        </div>
                                        
                                        <button type="button" class="btn btn-success" onclick="window.location.href = '/laptopshop/admin/product';">Back</button>&nbsp;&nbsp;
                                        <button type="submit" class="btn btn-danger">Confirm</button>
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