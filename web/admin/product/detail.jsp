<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="Vũ Duy Lê - Dự án laptopshop" />
        <meta name="author" content="Vũ Duy Lê" />
        <title>Detail Product - ${product.id}</title>
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
                        <h1 class="mt-4">Products</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="/laptopshop/admin">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="/laptopshop/admin/product">Products</a></li>
                            <li class="breadcrumb-item active">View detail</li>
                        </ol>
                        <div class="container mt-5">
                            <div class="row">
                                <div class="col-12 mx-auto">
                                    <div class="d-flex justify-content-between">
                                        <h3>Product detail with id = ${product.id}</h3>
                                    </div>

                                    <hr />

                                    <div class="card" style="width: 60%">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/resources/admin/images/product/${product.image}"
                                             alt="${product.image}">

                                        <div class="card-header">
                                            Product information
                                        </div>
                                        <ul class="list-group list-group-flush">
                                            <li class="list-group-item">ID: ${product.id}</li>
                                            <li class="list-group-item">Name: ${product.name}</li>
                                            <li class="list-group-item">Price: <fmt:formatNumber type="number" value="${product.price}" maxFractionDigits="2" /> đ</li>
                                            <li class="list-group-item">Quantity: ${product.quantity}</li>
                                            <li class="list-group-item">Sold: ${product.sold}</li>
                                            <li class="list-group-item">Factory: ${product.factory}</li>
                                            <li class="list-group-item">CPU Category: ${product.cpuCategory}</li>
                                            <li class="list-group-item">CPU: ${product.cpu}</li>
                                            <li class="list-group-item">RAM: ${product.ram}</li>
                                            <li class="list-group-item">ROM: ${product.rom}</li>
                                            <li class="list-group-item">Screen: ${product.screen}</li>
                                            <li class="list-group-item">VGA: ${product.vga}</li>
                                            <li class="list-group-item">Target: ${product.target}</li>
                                            <li class="list-group-item">Short description:: ${product.shortDesc}</li>
                                            <li class="list-group-item">Detail description: ${product.detailDesc}</li>                                           

                                        </ul>
                                    </div>
                                    <a href="/laptopshop/admin/product" class="btn btn-success mt-3">Back</a>

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