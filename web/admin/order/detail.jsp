<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="dal.OrderDAO" %>
<%@ page import="domain.OrderDetail" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="Vũ Duy Lê - Dự án laptopshop" />
        <meta name="author" content="Vũ Duy Lê" />
        <title>Detail Order - ${o.orderId}</title>
        <link href="${pageContext.request.contextPath}/resources/admin/css/styles.css" rel="stylesheet" />

        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            /* Navigation Tabs */
            .tabs {
                display: flex;
                border-bottom: 1px solid #ddd;
                margin-bottom: 20px;
            }

            .tab {
                padding: 12px 24px;
                cursor: pointer;
                color: #666;
                border: none;
                background: none;
                position: relative;
            }

            .tab.active {
                color: #ee4d2d;
                border-bottom: 2px solid #ee4d2d;
            }

            /* Search Bar */
            .search-bar {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                margin-bottom: 20px;
                background-color: #f5f5f5;
            }

            /* Product Card */
            .product-card {
                border: 1px solid #ddd;
                border-radius: 4px;
                padding: 16px;
                margin-bottom: 20px;
            }

            .shop-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 16px;
                padding-bottom: 16px;
                border-bottom: 1px solid #ddd;
            }

            .shop-info {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .shop-name {
                font-weight: bold;
            }

            .btn {
                padding: 6px 12px;
                border-radius: 4px;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                gap: 4px;
                font-size: 14px;
            }

            .btn-chat {
                background: #ee4d2d;
                color: white;
                border: none;
            }

            .btn-shop {
                border: 1px solid #ddd;
                background: white;
            }

            .delivery-status {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .status-success {
                color: #26aa99;
            }

            .status-complete {
                color: #ee4d2d;
                font-weight: bold;
            }

            /* Product Details */
            .product-details {
                display: flex;
                gap: 16px;
            }

            .product-image {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border: 1px solid #ddd;
            }

            .product-info {
                flex: 1;
            }

            .product-name {
                font-weight: 500;
                margin-bottom: 8px;
            }

            .product-variant {
                color: #666;
                margin-bottom: 4px;
            }

            .product-quantity {
                margin-bottom: 8px;
            }

            .product-tags {
                display: flex;
                gap: 8px;
            }

            .tag {
                padding: 4px 8px;
                border-radius: 2px;
                font-size: 12px;
            }

            .tag-return {
                border: 1px solid #ee4d2d;
                color: #ee4d2d;
            }

            .tag-free {
                border: 1px solid #26aa99;
                color: #26aa99;
            }

            .product-price {
                text-align: right;
            }

            .price-original {
                text-decoration: line-through;
                color: #666;
                font-size: 14px;
            }

            .price-current {
                color: #ee4d2d;
                font-weight: bold;
            }

            /* Action Buttons */
            .card-actions {
                display: flex;
                justify-content: flex-end;
                gap: 12px;
                margin-top: 16px;
                padding-top: 16px;
                border-top: 1px solid #ddd;
            }

            .btn-contact {
                background: white;
                border: 1px solid #ddd;
                padding: 8px 16px;
                border-radius: 4px;
            }

            .btn-action {
                background: #ee4d2d;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
            }
        </style>
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
                            <li class="breadcrumb-item"><a href="/laptopshop/admin/order">Orders</a></li>
                            <li class="breadcrumb-item active">Order detail</li>
                        </ol>
                        <div class="container mt-5">
                            <div class="row">
                                <div class="col-12 mx-auto">
                                    <div class="d-flex justify-content-between">
                                        <h3>Order detail with id = ${o.orderId}</h3>
                                    </div>

                                    <hr />
                                    <div class="card mb-4">
                                        <div class="card-body">
                                            <!-- Shop Header -->
                                            <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
                                                <div class="d-flex align-items-center gap-2">
                                                    <span class="status-success">Trạng thái</span>
                                                    <span class="status-complete">${o.status.status}</span>
                                                    <span class="status-success">Thời gian đặt hàng</span>
                                                    <span class="status-success">${o.date}</span>
                                                </div>
                                            </div>
                                            <c:set var="orderId" value="${o.orderId}" />
                                            <%
                                                OrderDAO orderDAO = new OrderDAO();
                                                int orderId = Integer.parseInt(pageContext.getAttribute("orderId").toString());
                                                List<OrderDetail> orderDetails = orderDAO.getDetailsByOrderId(orderId); 
                                                request.setAttribute("orderDetails", orderDetails);
                                            %>
                                            <!-- Product Details -->
                                            <c:forEach var="detail" items="${orderDetails}">
                                                <div class="position-relative">
                                                    <div class="d-flex gap-3 ${detail.product.storage == 0 ? 'opacity-25' : ''}">
                                                        <img src="${pageContext.request.contextPath}/resources/admin/images/product/${detail.product.image}" 
                                                             alt="${detail.product.name}" 
                                                             class="rounded" 
                                                             style="width: 80px; height: 80px; object-fit: cover;">
                                                        <div class="flex-grow-1">
                                                            <h6 class="mb-2">${detail.product.name}</h6>
                                                            <p class="mb-2">x${detail.quantity}</p>
                                                        </div>
                                                        <div class="text-end">
                                                            <div class="price-current">
                                                                <fmt:formatNumber type="number" value="${detail.priceProduct}" maxFractionDigits="2" /> đ
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <c:if test="${detail.product.storage == 0}">
                                                        <div class="position-absolute top-50 start-50 translate-middle text-center">
                                                            <span class="badge bg-danger fs-6 px-3 py-2">Sản phẩm đã ngưng bán</span>
                                                        </div>
                                                    </c:if>
                                                </div>
                                                <hr>
                                            </c:forEach>


                                            <!-- Total Price -->
                                            <div class="d-flex justify-content-end mb-3">
                                                <div class="text-end">
                                                    <span class="text-muted">Tổng tiền:</span>
                                                    <span class="price-current ms-2 fw-bold"> <fmt:formatNumber type="number" value="${o.totalPrice}" maxFractionDigits="2"/> đ</span>
                                                </div>
                                            </div>

                                            <!-- Shipping Address and Actions -->
                                            <div class="d-flex justify-content-between align-items-start border-top pt-3 mt-3">
                                                <!-- Shipping Address -->
                                                <div class="shipping-address">
                                                    <h6 class="mb-2">Địa Chỉ Nhận Hàng:</h6>
                                                    <p class="mb-1">${o.name}</p>
                                                    <p class="mb-1">${o.phone}</p>
                                                    <p class="mb-0">${o.address}</p>
                                                    <h6 class="mb-2">Note:</h6>
                                                    <p class="mb-1">${o.note}</p>
                                                </div>


                                                <!-- Action Buttons -->

                                                <div class="d-flex gap-2">

                                                    <c:choose>
                                                        <c:when test="${o.status.statusId == 1}">
                                                            <form action="/laptopshop/admin/update" method="post">
                                                                <button type="submit" name="action" value="2" class="btn btn-warning">XÁC NHẬN</button>
                                                                <input type="hidden" name="orderId" value="${o.orderId}">
                                                                <input type="hidden" name="returnUrl" value="${requestScope['jakarta.servlet.forward.request_uri']}?${pageContext.request.queryString}">
                                                                <button type="submit" name="action" value="4" class="btn btn-action">HỦY ĐƠN HÀNG</button>
                                                            </form>
                                                        </c:when>
                                                        <c:when test="${o.status.statusId == 2}">
                                                            <form action="/laptopshop/admin/update" method="post">
                                                                <button type="submit" name="action" value="3" class="btn btn-warning">Giao thành công</button>
                                                                <input type="hidden" name="orderId" value="${o.orderId}">
                                                                <input type="hidden" name="returnUrl" value="${requestScope['jakarta.servlet.forward.request_uri']}?${pageContext.request.queryString}">
                                                                <button type="submit" name="action" value="4" class="btn btn-action">HỦY ĐƠN HÀNG</button>
                                                            </form>
                                                        </c:when>
                                                        <c:when test="${o.status.statusId == 3}">
                                                            <span>ĐÃ GIAO HÀNG THÀNH CÔNG</span>
                                                        </c:when>
                                                        <c:when test="${o.status.statusId == 4}">
                                                            <span>ĐƠN HÀNG ĐÃ BỊ HỦY</span>
                                                        </c:when>
                                                    </c:choose>
                                                </div>


                                            </div>
                                        </div>
                                    </div>

                                    <a href="/laptopshop/admin/order" class="btn btn-success mt-3">Back</a>

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