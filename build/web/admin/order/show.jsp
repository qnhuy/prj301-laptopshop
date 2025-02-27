<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
        <meta name="author" content="Hỏi Dân IT" />
        <title>Dashboard - Order</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
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
                        <h1 class="mt-4">Dashboard</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol>


                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Order Table
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>OrderID</th>
                                            <th>UserID</th>
                                            <th>Date</th>
                                            <th>Name</th>
                                            <th>Phone</th>
                                            <th>TotalPrice</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>OrderID</th>
                                            <th>UserID</th>
                                            <th>Date</th>
                                            <th>Name</th>
                                            <th>Phone</th>
                                            <th>TotalPrice</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <c:forEach var="o" items="${requestScope.orders}">
                                            <tr>
                                                <td>${o.orderId}</td>
                                                <td>${o.userId}</td>
                                                <td>${o.date}</td>
                                                <td>${o.name}</td>
                                                <td>${o.phone}</td>
                                                <td><fmt:formatNumber type="number" value="${o.totalPrice}" maxFractionDigits="2"/></td>
                                                <td>${o.status.status}</td>
                                                <td>
                                                    <form action="update" method="post">
                                                        <a href="/laptopshop/admin/order/detail?orderId=${o.orderId}" class="btn btn-success">Chi tiết</a>
                                                        <input type="hidden" value="${o.orderId}" name="orderId">
                                                        <input type="hidden" name="returnUrl" value="${requestScope['jakarta.servlet.forward.request_uri']}?${pageContext.request.queryString}">
                                                        <c:if test="${o.status.statusId == 1}">
                                                            <button type="submit" name="action" value="2" class="btn btn-warning mx-2">Xác nhận</button>
                                                            <button type="submit" name="action" value="4" class="btn btn-danger">Hủy</button>
                                                        </c:if>
                                                        <c:if test="${o.status.statusId == 2}">
                                                            <button type="submit" name="action" value="3" class="btn btn-warning mx-2">Giao thành công</button>
                                                            <button type="submit" name="action" value="4" class="btn btn-danger">Hủy</button>
                                                        </c:if>
                                                    </form>

                                                </td>
                                            </tr>
                                        </c:forEach>



                                    </tbody>
                                </table>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
        crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/resources/admin/js/chart-area-demo.js"></script>
        <script src="${pageContext.request.contextPath}/resources/admin/js/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
        crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/resources/admin/js/datatables-simple-demo.js"></script>
    </body>

</html>