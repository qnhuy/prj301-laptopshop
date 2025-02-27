<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="Vũ Duy Lê - Dự án laptopshop" />
        <meta name="author" content="Vũ Duy Lê" />
        <title>Dashboard - Create Product</title>
        <script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>
        <link href="${pageContext.request.contextPath}/resources/admin/css/styles.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

        <script>
            $(document).ready(() => {
                const avatarFile = $("#avatarFile");
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
                            <li class="breadcrumb-item active">Create Product</li>
                        </ol>
                        <div class="mt-5">
                            <div class="row">
                                <div class="col-md-6 col-12 mx-auto">
                                    <h3>Create a product</h3>
                                    <hr />
                                    <form method="post" action="create"
                                          class="row" enctype="multipart/form-data">

                                        <!-- Name -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Name:</label>
                                            <input type="text" class="form-control" name="name" />
                                        </div>

                                        <!-- Price -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Price:</label>                                            
                                            <div class="input-group">
                                                <input type="number" class="form-control" name="price" value="0.0" min="0" step="any" />
                                                <span class="input-group-text">VNĐ</span>
                                            </div>
                                        </div>

                                        <!-- Quantity -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Quantity:</label>
                                            <input type="number" class="form-control" name="quantity" value="0" min="0" step="1" />
                                        </div>

                                        <!-- Sold -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Sold:</label>
                                            <input type="number" class="form-control" name="sold" value="0" min="0" step="1"/>
                                        </div>

                                        <!-- Factory -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Factory:</label>
                                            <select class="form-select" name="factory">
                                                <option value="Apple">Apple</option>
                                                <option value="Asus">Asus</option>
                                                <option value="Dell">Dell</option>
                                                <option value="Lenovo">Lenovo</option>
                                                <option value="Msi">Msi</option>
                                                <option value="Acer">Acer</option>
                                                <option value="HP">HP</option>
                                                <option value="LG">LG</option>
                                            </select>
                                        </div>

                                        <!-- CPU Category -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">CPU Category:</label>
                                            <select class="form-select" name="cpuCategory">

                                                <option value="INTEL">INTEL</option>
                                                <option value="AMD">AMD</option>
                                                <option value="APPLE">APPLE</option>
                                            </select>
                                        </div>

                                        <!-- CPU -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">CPU:</label>
                                            <input type="text" class="form-control" name="cpu" />
                                        </div>

                                        <!-- RAM -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">RAM:</label>
                                            <div class="input-group">
                                                <input type="number" class="form-control" name="ram" placeholder="Enter RAM size" />
                                                <span class="input-group-text">GB</span>
                                            </div>
                                        </div>

                                        <!-- ROM -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">ROM:</label>
                                            <input type="text" class="form-control" name="rom" />
                                        </div>

                                        <!-- Screen -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Screen:</label>
                                            <input type="text" class="form-control" name="screen" />
                                        </div>

                                        <!-- VGA -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">VGA:</label>
                                            <input type="text" class="form-control" name="vga" />
                                        </div>

                                        <!-- Target -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Target:</label>
                                            <select class="form-select" name="target">
                                                <option value="GAMING">Gaming</option>
                                                <option value="SINHVIEN-VANPHONG">Sinh viên - Văn phòng</option>
                                                <option value="THIET-KE-DO-HOA">Thiết kế đồ họa</option>
                                                <option value="MONG-NHE">Mỏng nhẹ</option>
                                                <option value="DOANH-NHAN">Doanh nhân</option>
                                                <option value="MAY-TRAM">Máy trạm</option>
                                            </select>
                                        </div>

                                        <!-- Short Description -->
                                        <div class="mb-3">
                                            <label class="form-label">Short description:</label>
                                            <input type="text" class="form-control" name="shortDesc" />
                                        </div>

                                        <!-- Detail Description -->
                                        <div class="mb-3">
                                            <label class="form-label">Detail description:</label>
                                            <textarea class="form-control" id="detailDesc" name="detailDesc" rows="3"
                                                      style="resize: vertical; max-height: 200px;"></textarea>
                                            <script>
            CKEDITOR.replace('detailDesc'); // Kích hoạt CKEditor cho textarea
                                            </script>     
                                        </div>

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
                                                <option value="1">YES</option>
                                                <option value="0">NO</option>

                                            </select>
                                        </div>

                                        <div class="col-12 mb-3">
                                            <img style="max-height: 250px; display: none;" alt="avatar preview" id="avatarPreview" />
                                        </div>

                                        <!-- Remove Image Button -->
                                        <div class="col-12 mb-3">
                                            <button type="button" class="btn btn-success" onclick="removeImage()">Remove Image</button>
                                        </div>

                                        <!-- Submit Button -->
                                        <div class="col-12 mb-5">
                                            <button type="submit" class="btn btn-primary">Create</button>
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