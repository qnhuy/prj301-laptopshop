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
        <title>Dashboard - Update Product</title>
        <script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>
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
                        <h1 class="mt-4">Manage Products</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active"><a href="/laptopshop/admin">Dashboard</a> </li>
                            <li class="breadcrumb-item active"><a href="/laptopshop/admin/product">Products</a> </li>
                            <li class="breadcrumb-item active">Update product</li>
                        </ol>
                        <div class="mt-5">
                            <div class="row">
                                <div class="col-md-6 col-12 mx-auto">
                                    <h3>Update product</h3>
                                    <hr />
                                    <c:set value="${requestScope.product}" var="p"/>

                                    <form method="post" action="update"
                                          class="row" enctype="multipart/form-data">
                                        <input type="text" name="id" value="${p.id}" style="display: none">
                                        <!-- Name -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Name:</label>
                                            <input type="text" class="form-control" name="name" value="${p.name}" />
                                        </div>

                                        <!-- Price -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Price:</label>                                            
                                            <div class="input-group">
                                                <input type="number" class="form-control" name="price" value="${p.price}" min="0" step="any" />
                                                <span class="input-group-text">VNĐ</span>
                                            </div>
                                        </div>

                                        <!-- Quantity -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Quantity:</label>
                                            <input type="number" class="form-control" name="quantity" value="${p.quantity}" min="0" step="1" />
                                        </div>

                                        <!-- Sold -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Sold:</label>
                                            <input type="number" class="form-control" name="sold" value="${p.sold}" min="0" step="1" />
                                        </div>

                                        <!-- Factory -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Factory:</label>
                                            <select class="form-select" name="factory">
                                                <option value="Apple" ${p.factory == 'Apple' ? 'selected' : ''}>Apple</option>
                                                <option value="Asus" ${p.factory == 'Asus' ? 'selected' : ''}>Asus</option>
                                                <option value="Dell" ${p.factory == 'Dell' ? 'selected' : ''}>Dell</option>
                                                <option value="Lenovo" ${p.factory == 'Lenovo' ? 'selected' : ''}>Lenovo</option>
                                                <option value="Msi" ${p.factory == 'Msi' ? 'selected' : ''}>Msi</option>
                                                <option value="Acer" ${p.factory == 'Acer' ? 'selected' : ''}>Acer</option>
                                                <option value="HP" ${p.factory == 'HP' ? 'selected' : ''}>HP</option>
                                                <option value="LG" ${p.factory == 'LG' ? 'selected' : ''}>LG</option>
                                            </select>
                                        </div>


                                        <!-- CPU Category -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">CPU Category:</label>
                                            <select class="form-select" name="cpuCategory">
                                                <option value="INTEL" ${p.cpuCategory == 'INTEL' ? 'selected' : ''}>INTEL</option>
                                                <option value="AMD" ${p.cpuCategory == 'AMD' ? 'selected' : ''}>AMD</option>
                                                <option value="APPLE" ${p.cpuCategory == 'APPLE' ? 'selected' : ''}>APPLE</option>
                                            </select>
                                        </div>

                                        <!-- CPU -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">CPU:</label>
                                            <input type="text" class="form-control" name="cpu" value="${p.cpu}" />
                                        </div>

                                        <!-- RAM -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">RAM:</label>
                                            <div class="input-group">
                                                <input type="text" class="form-control" name="ram" value="${p.ram}" />

                                            </div>
                                        </div>

                                        <!-- ROM -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">ROM:</label>
                                            <input type="text" class="form-control" name="rom" value="${p.rom}" />
                                        </div>

                                        <!-- Screen -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Screen:</label>
                                            <input type="text" class="form-control" name="screen" value="${p.screen}" />
                                        </div>

                                        <!-- VGA -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">VGA:</label>
                                            <input type="text" class="form-control" name="vga" value="${p.vga}" />
                                        </div>

                                        <!-- Target -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Target:</label>
                                            <select class="form-select" name="target">
                                                <option value="GAMING" ${p.target == 'GAMING' ? 'selected' : ''}>Gaming</option>
                                                <option value="SINHVIEN-VANPHONG" ${p.target == 'SINHVIEN-VANPHONG' ? 'selected' : ''}>Sinh viên - Văn phòng</option>
                                                <option value="THIET-KE-DO-HOA" ${p.target == 'THIET-KE-DO-HOA' ? 'selected' : ''}>Thiết kế đồ họa</option>
                                                <option value="MONG-NHE" ${p.target == 'MONG-NHE' ? 'selected' : ''}>Mỏng nhẹ</option>
                                                <option value="DOANH-NHAN" ${p.target == 'DOANH-NHAN' ? 'selected' : ''}>Doanh nhân</option>
                                                <option value="MAY-TRAM" ${p.target == 'MAY-TRAM' ? 'selected' : ''}>Máy trạm</option>
                                            </select>
                                        </div>

                                        <!-- Short Description -->
                                        <div class="mb-3">
                                            <label class="form-label">Short description:</label>
                                            <input type="text" class="form-control" name="shortDesc" value="${p.shortDesc}" />
                                        </div>

                                        <!-- Detail Description -->
                                        <div class="mb-3">
                                            <label class="form-label">Detail description:</label>
                                            <textarea class="form-control" id="detailDesc" name="detailDesc" rows="3" style="resize: vertical; max-height: 200px;">${p.detailDesc}</textarea>
                                            <script>
            CKEDITOR.replace('detailDesc'); // Kích hoạt CKEditor cho textarea
                                            </script>
                                        </div>

                                        <!-- Các trường khác -->
                                        <input type="hidden" name="image" value="${p.image}" />
                                        <!-- Các trường khác -->
                                        <!-- Images -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label for="avatarFile" class="form-label">Images:</label>
                                            <input class="form-control" type="file" id="avatarFile"
                                                   accept=".png, .jpg, .jpeg" name="productFile" onchange="previewImage(event)" />
                                        </div>
                                        <!-- Storage -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Storage:</label>
                                            <select class="form-select" name="storage">
                                                <option value="1" ${p.storage == '1' ? 'selected' : ''}>YES</option>
                                                <option value="0" ${p.storage == '0' ? 'selected' : ''}>NO</option>

                                            </select>
                                        </div>

                                        <div class="col-12 mb-3">
                                            <img style="max-height: 250px; display: block;" alt="avatar preview" id="avatarPreview" src="${pageContext.request.contextPath}/resources/admin/images/product/${p.image}"/>
                                        </div>

                                        <!-- Remove Image Button -->
                                        <div class="col-12 mb-3">
                                            <button type="button" class="btn btn-success" onclick="removeImage()">Remove Image</button>
                                        </div>

                                        <!-- Submit Button -->
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