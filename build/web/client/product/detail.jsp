<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Laptop - ${product.name}</title>

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
            rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
              rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="${pageContext.request.contextPath}/resources/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/resources/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="${pageContext.request.contextPath}/resources/client/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="${pageContext.request.contextPath}/resources/client/css/style.css" rel="stylesheet">
        <style>


            .spec-container {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                max-width: 600px;
                width: 100%;
            }

            h1 {
                text-align: center;
                color: #ff6600;
                margin-bottom: 20px;
                font-size: 24px;
            }

            .spec-table {
                width: 100%;
                border-collapse: collapse;
            }

            .spec-table th,
            .spec-table td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: left;

            }

            .spec-table th {
                background-color: #f2f2f2;
                width: 30%;
                font-weight: bold;
            }

            .spec-table td {
                width: 70%;
            }

            .spec-table tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            /* Styles for product description container */
            .product-description {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
                color: #333;
                line-height: 1.6;
            }

            /* Styles for the paragraph containing product description */
            .product-description p {
                font-size: 15px;
                margin: 0 0 15px 0;
                text-align: justify;
                font-weight: 400;
                white-space: pre-line;  /* Preserves line breaks */
            }

            /* Heading styles */
            .product-description h2 {
                font-size: 24px;
                font-weight: 700;
                margin: 0 0 20px 0;
                color: #000;
            }

            /* Responsive adjustments */
            @media screen and (max-width: 768px) {
                .product-description {
                    padding: 15px;
                }

                .product-description p {
                    font-size: 14px;
                }

                .product-description h2 {
                    font-size: 20px;
                }
            }
        </style>
        <script>

            function submitFormm(fruitName) {
                const filterForm = document.getElementById('filterForm');
                const fruitNameInput = document.getElementById('fruitName');
                fruitNameInput.value = fruitName;
                filterForm.submit();
            }
            
        </script>
        <script>
            function changeQuantity(amount) {
                var quantityInput = document.getElementById("quantityInput");
                var hiddenQuantity = document.getElementById("hiddenQuantity");
                var currentValue = parseInt(quantityInput.value);
                var newValue = currentValue + amount;

                // Đảm bảo số lượng không âm
                if (newValue < 1) {
                    newValue = 1;
                }

                quantityInput.value = newValue; // Cập nhật giá trị của ô nhập liệu
                hiddenQuantity.value = newValue + 1; // Cập nhật giá trị của input ẩn
            }

            function updateHiddenQuantity() {
                var quantityInput = document.getElementById("quantityInput");
                var hiddenQuantity = document.getElementById("hiddenQuantity");
                var currentValue = parseInt(quantityInput.value);

                // Đảm bảo số lượng không âm
                if (currentValue < 1) {
                    quantityInput.value = 1; // Đặt lại về 1 nếu người dùng nhập < 1
                    hiddenQuantity.value = 1; // Đặt lại giá trị của input ẩn
                } else {
                    hiddenQuantity.value = currentValue; // Cập nhật giá trị của input ẩn
                }
            }
        </script>
    </head>

    <body>

        <!-- Spinner Start -->
        <div id="spinner"
             class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
            <div class="spinner-grow text-primary" role="status"></div>
        </div>
        <!-- Spinner End -->


        <jsp:include page="../layout/header.jsp" />


        <!-- Modal Search Start -->
        <%--<jsp:include page="../layout/search.jsp" />--%>
        <!-- Modal Search End -->

        <!-- Single Product Start -->
        <div class="container-fluid py-5 mt-5">
            <div class="container py-5">
                <div class="row g-4 mb-5">
                    <div>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="/laptopshop/homepage">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Chi tiết sản phẩm</li>
                            </ol>
                        </nav>
                    </div>



                    <div class="col-lg-8 col-xl-9">
                        <div class="row g-4">
                            <div class="col-lg-6">
                                <div class="border rounded">
                                    <a href="#">
                                        <img style="width: 100%; height: 100%" src="${pageContext.request.contextPath}/resources/admin/images/product/${product.image}" class="img-fluid rounded"
                                             alt="Image">
                                    </a>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <h4 class="fw-bold mb-3">${product.name}</h4>
                                <p class="mb-3">${product.factory}</p>
                                <h5 class="fw-bold mb-3">
                                    <fmt:formatNumber type="number" value="${product.price}" maxFractionDigits="2"/> đ
                                </h5>
                                <div class="d-flex mb-4">
                                    <i class="fa fa-star text-secondary"></i>
                                    <i class="fa fa-star text-secondary"></i>
                                    <i class="fa fa-star text-secondary"></i>
                                    <i class="fa fa-star text-secondary"></i>
                                    <i class="fa fa-star"></i>
                                </div>
                                <p class="mb-4" >
                                    ${product.shortDesc}
                                </p>

                                <div class="input-group quantity mb-5" style="width: 100px;">
                                    <div class="input-group-btn">
                                        <button class="btn btn-sm btn-minus rounded-circle bg-light border" type="button" onclick="changeQuantity(0)">
                                            <i class="fa fa-minus"></i>
                                        </button>
                                    </div>
                                    <input type="text" class="form-control form-control-sm text-center border-0"
                                           value="1" id="quantityInput" onchange="updateHiddenQuantity()">
                                    <div class="input-group-btn">
                                        <button class="btn btn-sm btn-plus rounded-circle bg-light border" type="button" onclick="changeQuantity(0)">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                </div>
                                <form action="cart" method="post" class="d-flex justify-content-center">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <input type="hidden" name="quantity" id="hiddenQuantity" value="1">
                                    <!-- Gửi URL hiện tại để quay lại -->
                                    <input type="hidden" name="returnUrl" value="${requestScope['jakarta.servlet.forward.request_uri']}?${pageContext.request.queryString}">

                                    <!-- Kiểm tra nếu hết hàng thì vô hiệu hóa nút và thay đổi nội dung -->
                                    <c:choose>
                                        <c:when test="${product.quantity < 1}">
                                            <button type="button" class="mx-auto btn border border-secondary rounded-pill px-3 text-muted" disabled>
                                                <i class="fa fa-shopping-bag me-2 text-muted"></i> Hết hàng
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="submit" class="mx-auto btn border border-secondary rounded-pill px-3 text-primary">
                                                <i class="fa fa-shopping-bag me-2 text-primary"></i> Thêm vào giỏ hàng
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </form>
                            </div>
                            <div class="col-lg-12">
                                <nav>
                                    <div class="nav nav-tabs mb-3">
                                        <button class="nav-link active border-white border-bottom-0"
                                                type="button" role="tab" id="nav-about-tab" data-bs-toggle="tab"
                                                data-bs-target="#nav-about" aria-controls="nav-about"
                                                aria-selected="true">Description</button>
                                    </div>
                                </nav>
                                <div class="tab-content mb-5">
                                    <div class="tab-pane active" id="nav-about" role="tabpanel"
                                         aria-labelledby="nav-about-tab">
                                        <div class="product-description">
                                            <p>${product.detailDesc}</p>
                                        </div>


                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="col-lg-4 col-xl-3">
                        <div class="row g-4 fruite">
                            <div class="col-lg-12">

                                <div class="mb-4">
                                    <h4>Categories</h4>
                                    <ul class="list-unstyled fruite-categorie">
                                        <form action="products" method="get" id="filterForm">
                                            <input type="hidden" name="factory" id="fruitName" value="${factory != null && !factory.isEmpty() ? factory : ''}">
                                            <c:forEach items="${requestScope.map}" var="factory">
                                                <li>
                                                    <div class="d-flex justify-content-between fruite-name">
                                                        <a href="#" onclick="submitFormm('${factory.key}');
                                                                return false;">
                                                            <i class="fas fa-apple-alt me-2"></i>${factory.key}
                                                        </a>
                                                        <span>(${factory.value})</span>

                                                    </div>
                                                </li> 
                                            </c:forEach>

                                        </form>

                                    </ul>
                                </div>
                            </div>
                            <div class="spec-container">
                                <h1>Thông số kỹ thuật</h1>
                                <table class="spec-table">
                                    <tr>
                                        <th>CPU</th>
                                        <td>${product.cpu}</td>
                                    </tr>
                                    <tr>
                                        <th>RAM</th>
                                        <td>${product.ram}</td>
                                    </tr>
                                    <tr>
                                        <th>ROM</th>
                                        <td>${product.rom}</td>
                                    </tr>

                                    <tr>
                                        <th>VGA</th>
                                        <td>${product.vga}</td>
                                    </tr>
                                    <tr>
                                        <th>Screen</th>
                                        <td>${product.screen}</td>
                                    </tr>

                                </table>
                            </div>


                        </div>
                    </div>
                </div>
                <h1 class="fw-bold mb-0" style="font-size: 35px; color: #81C408">Sản phẩm liên quan</h1>
                <div class="vesitable">
                    <div class="owl-carousel vegetable-carousel justify-content-center">
                        <c:forEach var="p" items="${requestScope.products}">
                            <div class="border border-primary rounded position-relative vesitable-item" style="height: 400px">
                                <div class="vesitable-img" style="height: 200px">
                                    <img src="${pageContext.request.contextPath}/resources/admin/images/product/${p.image}" class="img-fluid w-100 rounded-top" alt="">
                                </div>
                                <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">Laptop</div>
                                <div class="p-4 pb-0 rounded-bottom">
                                    <h4 style="font-size: 15px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                        <a href="/laptopshop/product?id=${product.id}">
                                            ${product.name}
                                        </a>
                                    </h4>
                                    <p style="font-size: 13px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${p.shortDesc}</p>
                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                        <p class="text-dark fs-5 fw-bold"><fmt:formatNumber type="number" value="${p.price}" maxFractionDigits="2"/> đ</p>
                                        <form action="cart" method="post" class="d-flex justify-content-center">
                                            <input type="hidden" name="productId" value="${p.id}">
                                            <input type="hidden" name="quantity" value="1">
                                            <!-- Gửi URL hiện tại để quay lại -->
                                            <input type="hidden" name="returnUrl" value="${requestScope['jakarta.servlet.forward.request_uri']}?${pageContext.request.queryString}">

                                            <!-- Kiểm tra nếu hết hàng thì vô hiệu hóa nút và thay đổi nội dung -->
                                            <c:choose>
                                                <c:when test="${p.quantity < 1}">
                                                    <button type="button" class="mx-auto btn border border-secondary rounded-pill px-3 text-muted" disabled>
                                                        <i class="fa fa-shopping-bag me-2 text-muted"></i> Hết hàng
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="submit" class="mx-auto btn border border-secondary rounded-pill px-3 text-primary">
                                                        <i class="fa fa-shopping-bag me-2 text-primary"></i> Thêm
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>


                    </div>
                </div>
            </div>
        </div>
        <% 
                 String message = (String) session.getAttribute("message");
                 if (message != null) {
        %>
        <div id="alertMessage" class="alert alert-success text-center" style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 9999; width: 50%;" role="alert">
            <%= message %>
        </div>
        <script>
            // Tự động ẩn thông báo sau 3 giây
            setTimeout(function () {
                document.getElementById("alertMessage").style.display = 'none';
            }, 2000);
        </script>
        <% 
            session.removeAttribute("message");  // Xóa message sau khi hiển thị
            } 
        %>                         

        <!-- Single Product End -->






        <jsp:include page="../layout/footer.jsp" />





        <!-- Back to Top -->
        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                class="fa fa-arrow-up"></i></a>


        <!-- JavaScript Libraries -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/client/lib/easing/easing.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/client/lib/waypoints/waypoints.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/client/lib/lightbox/js/lightbox.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/client/lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="${pageContext.request.contextPath}/resources/client/js/main.js"></script>
    </body>

</html>