<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Profile</title>
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
            // Gán src cho thẻ img khi trang được tải
            window.onload = function () {
                const avatarPreview = document.getElementById("avatarPreview");
                const avatarPath = "${pageContext.request.contextPath}/resources/admin/images/avatar/${sessionScope.user.avartar}";
                        const avatarSrcInput = document.getElementById("avatarSrc");
                        if (avatarPath) {
                            avatarPreview.src = avatarPath;
                            avatarSrcInput.value = "${sessionScope.user.avartar}";
                        } else {
                            avatarPreview.src = ""; // Nếu không có avatar thì để trống
                            avatarSrcInput.value = "${sessionScope.user.avartar}";
                        }
                        const avatarFileInput = document.getElementById('avatarFile');
                        avatarFileInput.addEventListener('change', function (event) {
                            previewAvatar(event);
                        });
                    };

                    // Hàm xử lý khi nhấn nút "Remove Image"
                    function removeImage() {
                        const avatarPreview = document.getElementById("avatarPreview");
                        avatarPreview.src = "${pageContext.request.contextPath}/resources/admin/images/avatar/default-avatar.png"; // Gán src về rỗng
                        avatarSrcInput.value = "default-avatar.png"; // Gán giá trị rỗng cho input ẩn
                        document.querySelector('input[name="avatarFile"]').value = ''; // Clear file input nếu có
                    }

                    function previewAvatar(event) {
                        const avatarPreview = document.getElementById('avatarPreview');
                        const file = event.target.files[0];

                        if (file) {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                avatarPreview.src = e.target.result;// Gán src bằng đường dẫn của ảnh mới
                                avatarSrcInput.value = e.target.result;
                            };
                            reader.readAsDataURL(file); // Đọc file dưới dạng URL
                        }
                    }
        </script>
        <script>
            function submitChangePassword(event) {
                event.preventDefault(); // Ngăn sự kiện click lan truyền lên form cha
                event.stopPropagation(); // Ngăn sự kiện lan truyền
                const form = document.getElementById('changePasswordForm');
                form.submit();
                return false; // Ngăn mọi hành vi mặc định
            }
        </script>
    </head>

    <body>

        <!-- Spinner Start -->
        <div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
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
                    <h1 class="text-center text-white display-6">Checkout</h1>
                    <ol class="breadcrumb justify-content-center mb-0">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item"><a href="#">Pages</a></li>
                        <li class="breadcrumb-item active text-white">Checkout</li>
                    </ol>
                </div>-->
        <!-- Single Page Header End -->


        <!-- Checkout Page Start -->
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/laptopshop/homepage">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Profile</li>
                        </ol>
                    </nav>
                </div>
                <h1 class="mb-4" style="font-size: 40px">Thông tin cá nhân</h1>

                <form action="profile" method="post" id="outForm" enctype="multipart/form-data">
                    <div class="row g-5">
                        <div class="col-md-12 col-lg-6 col-xl-5 d-flex justify-content-center">
                            <div class="col-md-3 border-right">
                                <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                                    <!-- Tăng kích thước và giữ tỷ lệ tròn cho ảnh -->
                                    <img class="rounded-circle mt-5" id="avatarPreview" style="width: 200px; height: 200px; object-fit: cover;">
                                    <span class="font-weight-bold" style="width: 200px">${sessionScope.user.firstName} ${sessionScope.user.lastName}</span>
                                    <span class="text-black-50">${sessionScope.user.email}</span>
                                    <span> </span>

                                </div>




                            </div>

                            <input type="hidden" name="avatarSrc" id="avatarSrc">
                            <input type="hidden" name="avatar" value="${sessionScope.user.avartar}">

                        </div>

                        <div class="col-md-12 col-lg-6 col-xl-7">
                            <input type="hidden" name="id" value="${sessionScope.user.id}" />
                            <div class="form-item">
                                <label class="form-label my-3">Email</label>
                                <input type="text" class="form-control" name="email" value="${sessionScope.user.email}" readonly>
                            </div>

                            <div class="row">
                                <div class="col-md-12 col-lg-6">
                                    <div class="form-item w-100">
                                        <label class="form-label my-3">First Name</label>
                                        <input type="text" class="form-control" name="firstName" value="${sessionScope.user.firstName}">
                                    </div>
                                </div>
                                <div class="col-md-12 col-lg-6">
                                    <div class="form-item w-100">
                                        <label class="form-label my-3">Last Name</label>
                                        <input type="text" class="form-control" name="lastName" value="${sessionScope.user.lastName}">
                                    </div>
                                </div>
                            </div>

                            <div class="form-item">
                                <label class="form-label my-3">Address</label>
                                <input type="text" class="form-control" name="address" value="${sessionScope.user.address}">
                            </div>
                            <div class="form-item">
                                <label class="form-label my-3">Phone number</label>
                                <input type="text" class="form-control" name="phone" value="${sessionScope.user.phone}">
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-lg-6">
                                    <div class="form-item">
                                        <label for="avatarFile" class="form-label my-3">Avatar:</label>
                                        <input class="form-control" type="file" id="avatarFile"
                                               accept=".png, .jpg, .jpeg" name="avatarFile" />
                                    </div>
                                </div>

                                <div class="col-12 mb-3" style="margin-top: 20px">
                                    <button type="button" class="btn btn-success" onclick="removeImage()">Remove Image</button>
                                </div>
                            </div>
                            <div class="row g-4 text-center align-items-center justify-content-center pt-4">
                                <button type="submit" class="btn border-secondary py-3 px-4 text-uppercase text-primary" style="width: 50%;">Update</button>
                            </div>

                        </div>

                    </div>
                </form>
                <form id="changePasswordForm" action="changepass" method="post">
                    <div class="password-change-section mt-4" style="max-width: 500px;">
                        <div class="form-item mb-3 d-flex justify-content-center">
                            <input style="width: 200px" type="password" class="form-control" placeholder="Old Password" name="oldPassword">
                        </div>
                        <div class="form-item mb-3 d-flex justify-content-center">
                            <input style="width: 200px" type="password" class="form-control" placeholder="New Password" name="newPassword">
                        </div>
                        <div class="form-item mb-3 d-flex justify-content-center">
                            <input style="width: 200px" type="password" class="form-control" placeholder="Confirm New Password" name="confirmPassword">
                        </div>
                        <div class="text-center d-flex justify-content-center">
                            <button style="width: 200px" type="button" class="btn btn-success" onclick="submitChangePassword(event)">Change Password</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-- Checkout Page End -->

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