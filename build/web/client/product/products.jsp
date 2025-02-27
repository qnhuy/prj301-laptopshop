<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="domain.User" %>
<%@ page import="dal.CartDAO" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Products</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="${pageContext.request.contextPath}/resources/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/resources/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="${pageContext.request.contextPath}/resources/client/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="${pageContext.request.contextPath}/resources/client/css/style.css" rel="stylesheet">
        <script>
            function updatePrice() {
                var rangeValue = document.getElementById('rangeInput').value;
                var formattedValue = new Intl.NumberFormat('vi-VN').format(rangeValue);
                document.getElementById('amount').innerHTML = formattedValue + ' đ';
            }

            function submitForm() {
                document.getElementById('filterForm').submit();
            }
            let lastChecked = null;

            function toggleRadio(radio) {
                if (radio === lastChecked) {
                    radio.checked = false;  // Bỏ tích nếu đang được chọn lại
                    lastChecked = null;
                } else {
                    lastChecked = radio;  // Lưu lại radio vừa được chọn
                }
            }
            function submitFormm(fruitName) {
                document.getElementById('fruitName').value = fruitName; // Gán giá trị cho input hidden
                document.getElementById('filterForm').submit(); // Gửi form
            }
        </script>
        <style>
            .fruite-img {
                display: flex;
                align-items: center;
                justify-content: center;
                height: 250px; /* Chiều cao cố định cho container ảnh */
                background-color: #f8f8f8; /* Màu nền cho ảnh */
                overflow: hidden; /* Cắt những phần ảnh vượt ra ngoài */
            }

            .fruite-img img {
                width: 100%; /* Đặt chiều rộng chiếm 100% container */
                height: 100%; /* Đặt chiều cao chiếm 100% container */
                object-fit: cover; /* Cắt bớt ảnh để vừa với container mà không bị méo */
            }

        </style>
        <style>
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 5px;
                margin: 20px 0;
            }

            .pagination .page-item {
                margin: 0 2px;
            }

            .pagination .page-link {
                min-width: 40px;
                text-align: center;
                padding: 8px 16px;
            }

            /* Đảm bảo nút Previous và Next cùng kích thước với các nút số */
            .pagination .page-item:first-child .page-link,
            .pagination .page-item:last-child .page-link {
                min-width: 40px;
            }
        </style>


    </head>

    <body>

        <!-- Spinner Start -->
        <div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
            <div class="spinner-grow text-primary" role="status"></div>
        </div>
        <!-- Spinner End -->
        <!-- Modal Search Start -->
        <!--        <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-fullscreen">
                        <div class="modal-content rounded-0">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
        
                            <div class="modal-body d-flex align-items-center">
                                <div class="input-group w-75 mx-auto d-flex">
                                    <input type="search" class="form-control p-3" placeholder="keywords" name="keySearch1" aria-describedby="search-icon-1">
                                    <button id="search-button" class="input-group-text p-3" type="submit">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </div>
                            </div>
        
        
                        </div>
                    </div>
                </div>-->
        <!-- Modal Search End -->
        <%--<jsp:include page="../layout/search.jsp" />--%>
        <%--<jsp:include page="../layout/header.jsp" />--%>
        <div class="container-fluid fixed-top">
            <div class="container px-0">
                <nav class="navbar navbar-light bg-white navbar-expand-xl">
                    <a href="/laptopshop/homepage" class="navbar-brand">
                        <h1 class="text-primary display-6">Laptopshop</h1>
                    </a>
                    <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars text-primary"></span>
                    </button>
                    <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                        <div class="navbar-nav mx-auto">
                            <a href="/laptopshop/homepage" class="nav-item nav-link active">Trang Chủ</a>
                            <a href="/laptopshop/products" class="nav-item nav-link">Sản Phẩm</a>
                            <a href="/laptopshop/contact" class="nav-item nav-link active">Liên hệ</a>
                        </div>

                        <div class="d-flex m-3 me-0">
<!--                            <button
                                class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4"
                                data-bs-toggle="modal" data-bs-target="#searchModal">
                                <i class="fas fa-search text-primary"></i>
                            </button>-->

                            <a href="/laptopshop/cart" class="position-relative me-4 my-auto">
                                <i class="fa fa-shopping-bag fa-2x"></i>
                                <span class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                      style="top: -5px; left: 15px; height: 20px; min-width: 20px;">
                                    <%
                if (session.getAttribute("user") != null) {
                User user = (User) session.getAttribute("user");
                    CartDAO cartDAO = new CartDAO();
                int totalQuantity = cartDAO.getTotalQuantityOfProductInCart(user.getId());
                out.print(totalQuantity);  
                } else {
                    out.print(0);
                }
                                    %>
                                </span>
                            </a>

                            <!-- Điều kiện kiểm tra user -->
                            <% if (session.getAttribute("user") != null) { %>
                            <!-- Nếu người dùng đã đăng nhập -->
                            <div class="dropdown my-auto">
                                <a href="#" class="dropdown-toggle" id="dropdownUserMenu" data-bs-toggle="dropdown" aria-expanded="false">
                                    Chào bạn, ${sessionScope.user.lastName}
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="dropdownUserMenu">
                                    <li><a class="dropdown-item" href="/laptopshop/order">My order </a></li>
                                    <li><a class="dropdown-item" href="/laptopshop/profile">Profile </a></li>
                                    <li><a class="dropdown-item" href="/laptopshop/logout">Đăng xuất</a></li>
                                </ul>
                            </div>
                            <% } else { %>
                            <!-- Nếu người dùng chưa đăng nhập -->
                            <a href="/laptopshop/login" class="my-auto">Đăng nhập</a>
                            <a href="/laptopshop/register" class="my-auto ms-3">Đăng ký</a>
                            <% } %>
                        </div>


                    </div>
                </nav>
            </div>
        </div>
        <form action="products"  id="filterForm">
            <!-- Modal Search Start -->

            <!-- Modal Search End -->


            <!-- Fruits Shop Start-->
            <div class="container-fluid fruite py-5">
                <div class="container py-5">

                    <div class="row g-4" >
                        <div class="col-lg-12">
                            <div class="row g-4">
                                <div>
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="/laptopshop/homepage">Home</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Danh sách sản phẩm</li>
                                        </ol>
                                    </nav>
                                </div>
                                <div class="col-xl-3">

                                    <div class="input-group w-100 mx-auto d-flex">
                                        <input type="search" class="form-control p-3" placeholder="Keywords" name="keySearch2" aria-describedby="search-button" value="${keySearch != null && !keySearch.isEmpty() ? keySearch : ''}">
                                        <button id="search-button" class="input-group-text p-3" type="submit">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </div>



                                </div>
                                <div class="col-6"></div>
                                <div class="col-xl-3">
                                    <div class="bg-light ps-3 py-3 rounded d-flex justify-content-between mb-4">
                                        <label for="fruits">Sắp xếp:</label>
                                        <select id="fruits" name="sortOption" class="border-0 form-select-sm bg-light me-3" onchange="this.form.submit()">
                                            <option value="" ${(sortOption == '' || sortOption == null) ? 'selected' : ''}>None</option>
                                            <option value="asc" ${sortOption == 'asc' ? 'selected' : ''}>Giá tăng dần</option>
                                            <option value="desc" ${sortOption == 'desc' ? 'selected' : ''}>Giá giảm dần</option>            
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row g-4">
                                <div class="col-lg-3">
                                    <div class="row g-4">
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <h4>Categories</h4>
                                                <ul class="list-unstyled fruite-categorie">
                                                    <input type="hidden" name="factory" id="fruitName" value="${factory != null && !factory.isEmpty() ? factory : ''}">
                                                    <c:forEach items="${requestScope.map}" var="factory">
                                                        <li>
                                                            <div class="d-flex justify-content-between fruite-name">
                                                                <a href="#" onclick="submitFormm('${factory.key}'); return false;">
                                                                    <i class="fas fa-apple-alt me-2"></i>${factory.key}
                                                                </a>
                                                                <span>(${factory.value})</span>

                                                            </div>
                                                        </li> 
                                                    </c:forEach>
                                                    <li>
                                                        <div class="d-flex justify-content-between fruite-name">
                                                            <a href="#" onclick="submitFormm(''); return false;">
                                                                <i class="fas fa-apple-alt me-2"></i>All
                                                            </a>
                                                            <span>(${all})</span>

                                                        </div>
                                                    </li>

                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">

                                            <div class="mb-3">
                                                <h4 class="mb-2">Price</h4>
                                                <input type="range" class="form-range w-100" id="rangeInput" name="price" min="0" max="100000000" value="${price != null ? price : 100000000}"
                                                       oninput="updatePrice()" onchange="submitForm()">
                                                <output id="amount" name="amount">
                                                    <fmt:formatNumber type="number" value="${price != null ? price : 100000000}" /> đ
                                                </output>
                                            </div>

                                        </div>
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <h4>CPU</h4>
                                                <div class="mb-2">
                                                    <input type="radio" class="me-2" id="Categories-1" name="cpuCate" value="INTEL" 
                                                           onchange="this.form.submit()" onclick="toggleRadio(this)"
                                                           ${cpuCate == 'INTEL' ? 'checked' : ''}>
                                                    <label for="Categories-1"> Intel</label>
                                                </div>
                                                <div class="mb-2">
                                                    <input type="radio" class="me-2" id="Categories-2" name="cpuCate" value="AMD" 
                                                           onchange="this.form.submit()" onclick="toggleRadio(this)"
                                                           ${cpuCate == 'AMD' ? 'checked' : ''}>
                                                    <label for="Categories-2"> Amd</label>
                                                </div>
                                                <div class="mb-2">
                                                    <input type="radio" class="me-2" id="Categories-3" name="cpuCate" value="APPLE" 
                                                           onchange="this.form.submit()" onclick="toggleRadio(this)"
                                                           ${cpuCate == 'APPLE' ? 'checked' : ''}>
                                                    <label for="Categories-3"> Apple</label>
                                                </div>
                                                <div class="mb-2">
                                                    <input type="radio" class="me-2" id="Categories-3" name="cpuCate" value="" 
                                                           onchange="this.form.submit()" onclick="toggleRadio(this)"
                                                           ${(cpuCate == null || cpuCate == '') ? 'checked' : ''}>
                                                    <label for="Categories-3"> All</label>
                                                </div>
                                            </div>

                                        </div>


                                        <div class="col-lg-12">
                                            <div class="position-relative">
                                                <img src="${pageContext.request.contextPath}/resources/client/img/banner.jpg" class="img-fluid w-100 rounded" alt="">
                                                <div class="position-absolute" style="top: 50%; right: 10px; transform: translateY(-50%);">
                                                    <h3 class="text-secondary fw-bold"> <br>  <br> </h3>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-9">
                                    <div class="row g-4 justify-content-center">
                                        <c:if test="${result == 0}">
                                            <p>Không tìm thấy sản phẩm phù hợp.</p>
                                        </c:if>
                                        <c:if test="${result > 0}">
                                            <p>Tìm thấy ${result} sản phẩm.</p>
                                        </c:if>
                                        <c:forEach items="${requestScope.products}" var="product" varStatus="status">


                                            <div class="col-md-6 col-lg-4 col-xl-3 other-product">
                                                <div class="rounded position-relative fruite-item">
                                                    <div class="fruite-img">
                                                        <img src="${pageContext.request.contextPath}/resources/admin/images/product/${product.image}"
                                                             class="img-fluid w-100 h-50 rounded-top" alt="">
                                                    </div>
                                                    <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                         style="top: 10px; left: 10px;">Laptop</div>
                                                    <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                        <h4 style="font-size: 15px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                            <a href="/laptopshop/product?id=${product.id}">
                                                                ${product.name}
                                                            </a>
                                                        </h4>

                                                        <p style="font-size: 13px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                            ${product.shortDesc}
                                                        </p>
                                                        <div class="d-flex flex-lg-wrap"></div>
                                                        <p class="text-dark fw-bold mb-3"
                                                           style="font-size: 15px; text-align: center; width: 100%;">
                                                            <fmt:formatNumber type="number" value="${product.price}" maxFractionDigits="2"/> đ
                                                        </p>
                                                        <!--                                                        <form action="cart" method="post" class="d-flex justify-content-center">
                                                                                                                    <input type="hidden" name="productId" value="${product.id}">
                                                                                                                    <input type="hidden" name="quantity" value="1">
                                                                                                                    <input type="hidden" name="returnUrl" value="${requestScope['jakarta.servlet.forward.request_uri']}?${pageContext.request.queryString}">
                                                        <c:choose>
                                                            <c:when test="${product.quantity < 1}">
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
                                                    </form>-->
                                                    </div>
                                                </div>
                                            </div>

                                        </c:forEach>
                                        <div class="row mt-4">
                                            <div class="col-12">
                                                <nav aria-label="Page navigation">
                                                    <ul class="pagination justify-content-center">
                                                        <!-- Previous page button -->
                                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                            <a class="page-link" href="?page=${currentPage - 1}
                                                               ${not empty keySearch ? '&keySearch=' : ''}${keySearch}
                                                               ${not empty factory ? '&factory=' : ''}${factory}
                                                               ${not empty cpuCate ? '&cpuCate=' : ''}${cpuCate}
                                                               ${not empty price ? '&price=' : ''}${price}
                                                               ${not empty sortOption ? '&sortOption=' : ''}${sortOption}"
                                                               aria-label="Previous">
                                                                <span aria-hidden="true">&laquo;</span>
                                                            </a>
                                                        </li>

                                                        <!-- Page numbers -->
                                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                                <a class="page-link" href="?page=${i}
                                                                   ${not empty keySearch ? '&keySearch=' : ''}${keySearch}
                                                                   ${not empty factory ? '&factory=' : ''}${factory}
                                                                   ${not empty cpuCate ? '&cpuCate=' : ''}${cpuCate}
                                                                   ${not empty price ? '&price=' : ''}${price}
                                                                   ${not empty sortOption ? '&sortOption=' : ''}${sortOption}">
                                                                    ${i}
                                                                </a>
                                                            </li>
                                                        </c:forEach>

                                                        <!-- Next page button -->
                                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                            <a class="page-link" href="?page=${currentPage + 1}
                                                               ${not empty keySearch ? '&keySearch=' : ''}${keySearch}
                                                               ${not empty factory ? '&factory=' : ''}${factory}
                                                               ${not empty cpuCate ? '&cpuCate=' : ''}${cpuCate}
                                                               ${not empty price ? '&price=' : ''}${price}
                                                               ${not empty sortOption ? '&sortOption=' : ''}${sortOption}"
                                                               aria-label="Next">
                                                                <span aria-hidden="true">&raquo;</span>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </nav>
                                            </div>
                                        </div>
                                        <!--
                                                                                <div class="col-12">
                                                                                    <div class="pagination d-flex justify-content-center mt-5">
                                                                                        <a href="#" class="rounded">&laquo;</a>
                                                                                        <a href="#" class="active rounded">1</a>
                                                                                        <a href="#" class="rounded">2</a>
                                                                                        <a href="#" class="rounded">3</a>
                                                                                        <a href="#" class="rounded">4</a>
                                                                                        <a href="#" class="rounded">5</a>
                                                                                        <a href="#" class="rounded">6</a>
                                                                                        <a href="#" class="rounded">&raquo;</a>
                                                                                    </div>
                                                                                </div>-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Fruits Shop End-->
        </form>
        <% 
                 String message = (String) session.getAttribute("message");
                 if (message != null) {
        %>
        <div id="alertMessage" class="alert alert-success text-center" style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 9999; width: 50%;" role="alert">
            <%= message %>
        </div>
        <script>

            setTimeout(function () {
                document.getElementById("alertMessage").style.display = 'none';
            }, 2000);
        </script>
        <% 
            session.removeAttribute("message");
            } 
        %>                                       
        <!-- Footer Start -->
        <jsp:include page="../layout/footer.jsp" />
        <!-- Footer End -->





        <!-- Back to Top -->
        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   


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