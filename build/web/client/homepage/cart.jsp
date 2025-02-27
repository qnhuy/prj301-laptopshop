
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Laptop Shop - Cart</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
            rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="${pageContext.request.contextPath}/resources/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/resources/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="${pageContext.request.contextPath}/resources/client/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="${pageContext.request.contextPath}/resources/client/css/style.css" rel="stylesheet">
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Đợi DOM load xong mới thực hiện

                function updateTotal() {
                    let total = 0;
                    let subTotal = 0;
                    const checkboxes = document.querySelectorAll('.checkbox-item:checked');

                    checkboxes.forEach(checkbox => {
                        const price = parseFloat(checkbox.getAttribute('data-price')); // Lấy giá sản phẩm
                        const quantity = parseInt(checkbox.getAttribute('data-quantity')); // Lấy số lượng sản phẩm
                        subTotal += price * quantity; // Tính tổng giá
                        total += price * quantity;
                    });

                    // Cập nhật tổng giá vào nơi bạn muốn hiển thị
                    document.getElementById('subTotalPrice').innerText = formatNumber(subTotal) + ' đ';
                    document.getElementById('totalPrice').innerText = formatNumber(total) + ' đ';

                }
                function formatNumber(number) {
                    return number.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                }
                function handleSelectAll() {
                    // Lấy trạng thái của checkbox Select All
                    let mainCheckbox = document.getElementById('selectAll');
                    let itemCheckboxes = document.querySelectorAll('.checkbox-item');

                    if (mainCheckbox && itemCheckboxes.length > 0) {
                        // Xử lý sự kiện khi click vào Select All
                        mainCheckbox.addEventListener('click', function () {
                            itemCheckboxes.forEach(function (checkbox) {
                                checkbox.checked = mainCheckbox.checked;
                            });
                            updateTotal(); // Cập nhật tổng khi chọn hoặc bỏ chọn Select All
                        });

                        // Xử lý sự kiện khi click vào từng checkbox
                        itemCheckboxes.forEach(function (checkbox) {
                            checkbox.addEventListener('click', function () {
                                let allChecked = true;
                                itemCheckboxes.forEach(function (item) {
                                    if (!item.checked) {
                                        allChecked = false;
                                    }
                                });
                                mainCheckbox.checked = allChecked;
                                updateTotal(); // Cập nhật tổng khi có sự thay đổi checkbox
                            });
                        });
                    }
                }

                window.proceedToCheckout = function () {
                    const selectedCheckboxes = document.querySelectorAll('.checkbox-item:checked');
                    if (selectedCheckboxes.length === 0) {
                        alert('Please select at least one item to checkout');
                        return;
                    }
                    const cartIds = Array.from(selectedCheckboxes).map(checkbox =>
                        checkbox.getAttribute('data-cart-id')
                    );
                    // Create URL with selected cart IDs
                    const checkoutUrl = '/laptopshop/checkout?cartIds=' + cartIds.join(',');
                    window.location.href = checkoutUrl;
                }

                // Gọi hàm xử lý
                handleSelectAll();
            });
        </script>



    </head>

    <body>

        <!-- Spinner Start -->
        <div id="spinner"
             class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
            <div class="spinner-grow text-primary" role="status"></div>
        </div>
        <!-- Spinner End -->


        <!-- Navbar start -->
        <jsp:include page="../layout/header.jsp" />
        <!-- Navbar End -->


        <!-- Modal Search Start -->
        <jsp:include page="../layout/search.jsp" />
        <!-- Modal Search End -->


        <!-- Single Page Header start -->
        <!--        <div class="container-fluid page-header py-5">
                    <h1 class="text-center text-white display-6">Cart</h1>
                    <ol class="breadcrumb justify-content-center mb-0">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item"><a href="#">Pages</a></li>
                        <li class="breadcrumb-item active text-white">Cart</li>
                    </ol>
                </div>-->
        <!-- Single Page Header End -->


        <!-- Cart Page Start -->
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/laptopshop/homepage">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Cart</li>
                        </ol>
                    </nav>
                </div>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">
                                    <input type="checkbox" class="form-check-input" id="selectAll"> All
                                </th>
                                <th scope="col">Products</th>
                                <th scope="col">Name</th>
                                <th scope="col">Price</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Total</th>
                                <th scope="col">Handle</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${requestScope.cartItems}">
                                <tr>
                                    <td class="align-middle">
                                        <c:choose>
                                            <c:when test="${c.product.storage == 0}">
                                                <span class="text-danger">Không tồn tại</span>
                                            </c:when>
                                            <c:when test="${c.product.quantity < 1}">
                                                <span class="text-danger">Hết hàng</span>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="checkbox" class="form-check-input checkbox-item" onchange="updateTotal()"
                                                       data-price="${c.product.price}" data-quantity="${c.quantity}" data-cart-id="${c.cartItemId}">
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <th scope="row">
                                        <div class="d-flex align-items-center">
                                            <img src="${pageContext.request.contextPath}/resources/admin/images/product/${c.product.image}" 
                                                 class="img-fluid me-5 rounded-circle"
                                                 style="width: 80px; height: 80px; ${c.product.storage == 0 ? 'opacity: 0.5;' : ''}" alt="">
                                        </div>
                                    </th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.product.storage == 0}">
                                                <p class="mb-0 mt-4" style="color: #999;">
                                                    ${c.product.name}
                                                </p>
                                            </c:when>
                                            <c:otherwise>
                                                <p class="mb-0 mt-4" style="cursor: pointer;" 
                                                   onclick="window.location.href = '/laptopshop/product?id=${c.product.id}'">
                                                    ${c.product.name}
                                                </p>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4" ${c.product.storage == 0 ? 'style="color: #999;"' : ''}>
                                            <fmt:formatNumber type="number" value="${c.product.price}" maxFractionDigits="2"/> đ
                                        </p>
                                    </td>
                                    <td>
                                        <div class="input-group quantity mt-4" style="width: 100px;">
                                            <div class="input-group-btn">
                                                <c:choose>
                                                    <c:when test="${c.product.storage == 0}">
                                                        <button class="btn btn-sm btn-minus rounded-circle bg-light border" disabled>
                                                            <i class="fa fa-minus"></i>
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-sm btn-minus rounded-circle bg-light border" 
                                                                onclick="window.location.href = '/laptopshop/editquantitycart?cartItemId=${c.cartItemId}&quantity=${c.quantity - 1}&productId=${c.product.id}'">
                                                            <i class="fa fa-minus"></i>
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <c:choose>
                                                <c:when test="${c.product.storage == 0}">
                                                    <input type="text" class="form-control form-control-sm text-center border-0 w-25"
                                                           value="${c.quantity}" disabled>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="text" class="form-control form-control-sm text-center border-0 w-25"
                                                           value="${c.quantity}"
                                                           onchange="window.location.href = '/laptopshop/editquantitycart?cartItemId=${c.cartItemId}&quantity=' + this.value + '&productId=${c.product.id}'">
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="input-group-btn">
                                                <c:choose>
                                                    <c:when test="${c.product.storage == 0}">
                                                        <button class="btn btn-sm btn-plus rounded-circle bg-light border" disabled>
                                                            <i class="fa fa-plus"></i>
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-sm btn-plus rounded-circle bg-light border" 
                                                                onclick="window.location.href = '/laptopshop/editquantitycart?cartItemId=${c.cartItemId}&quantity=${c.quantity + 1}&productId=${c.product.id}'">
                                                            <i class="fa fa-plus"></i>
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4" ${c.product.storage == 0 ? 'style="color: #999;"' : ''}>
                                            <fmt:formatNumber type="number" value="${c.product.price * c.quantity}" maxFractionDigits="2"/> đ
                                        </p>
                                    </td>
                                    <td>
                                        <button onclick="window.location.href = '/laptopshop/deletecart?id=${c.product.id}'" 
                                                class="btn btn-md rounded-circle bg-light border mt-4">
                                            <i class="fa fa-times text-danger"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
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
                    }, 3000);
                </script>
                <% 
                    session.removeAttribute("message");  // Xóa message sau khi hiển thị
                    } 
                %>

                <div class="row g-4 justify-content-end">
                    <div class="col-8"></div>
                    <div class="col-sm-8 col-md-7 col-lg-6 col-xl-4">
                        <div class="bg-light rounded">
                            <div class="p-4">
                                <h1 class="display-6 mb-4">Cart <span class="fw-normal">Total</span></h1>
                                <div class="d-flex justify-content-between mb-4">
                                    <h5 class="mb-0 me-4">Subtotal:</h5>
                                    <p class="mb-0" id="subTotalPrice">0.00 đ</p>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <h5 class="mb-0 me-4">Shipping</h5>
                                    <div class="">
                                        <p class="mb-0">Free Shipping</p>
                                    </div>
                                </div>

                            </div>
                            <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                <h5 class="mb-0 ps-4 me-4">Total</h5>
                                <p class="mb-0 pe-4" id="totalPrice">0.00đ</p>
                            </div>
                            <button
                                class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4"
                                type="button" onclick="proceedToCheckout()">Proceed Checkout</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Cart Page End -->


        <!-- Footer Start -->
        <jsp:include page="../layout/footer.jsp" />
        <!-- Footer End -->

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