/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.ProductDAO;
import domain.Product;
import domain.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

/**
 *
 * @author NCPC
 */
@WebServlet(name = "CreateProduct", urlPatterns = {"/admin/product/create"})
@MultipartConfig(maxFileSize = 1024 * 10000, maxRequestSize = 1024 * 10000)
public class CreateProduct extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CreateProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateProductServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("/laptopshop/login");
            return;
        } else if (user.getRoleId() == 1) {
            out.println("<h1>Access denied</h1>");
        } else{
           request.getRequestDispatcher("/admin/product/create.jsp").forward(request, response); 
        }
            
        
        
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF8");
        
        String name = request.getParameter("name");
        String price_raw = request.getParameter("price");
        String quantity_raw = request.getParameter("quantity");
        String sold_raw = request.getParameter("sold");
        String factory = request.getParameter("factory");
        String cpuCategory = request.getParameter("cpuCategory");
        String cpu = request.getParameter("cpu");
        String ram = request.getParameter("ram");
        String rom = request.getParameter("rom");
        String screen = request.getParameter("screen");
        String vga = request.getParameter("vga");
        String target = request.getParameter("target");
        String shortDesc = request.getParameter("shortDesc");
        String detailDesc = request.getParameter("detailDesc");
        String storage = request.getParameter("storage");
        Part filePart = request.getPart("productFile");
        String finalAvatar = saveFile(filePart);
        String finalAvatar1;
        if (finalAvatar == null) {
            finalAvatar1= "default-product.png";
        } else{
            finalAvatar1 = finalAvatar;
        }
        int quantity, sold,s;
        double price;
        try {

            quantity = Integer.parseInt(quantity_raw);

            sold = Integer.parseInt(sold_raw);

            price = Double.parseDouble(price_raw);
            s = Integer.parseInt(storage);
            Product productNew = new Product(name, price, quantity, sold, factory, cpuCategory, cpu, ram, rom, screen, vga, target, shortDesc, detailDesc, finalAvatar1, s);
            ProductDAO productDAO = new ProductDAO();
            productDAO.addNewProduct(productNew);
            response.sendRedirect("/laptopshop/admin/product");
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public String saveFile(Part filePart) throws IOException {
        // Kiểm tra xem filePart có tồn tại hay không
        if (filePart == null || filePart.getSize() == 0) {
            return null; // Không có file được upload
        }

        // Đường dẫn tương đối tới thư mục bên ngoài "web"
        String relativePath = "resources/admin/images/product";

        // Lấy đường dẫn thực (absolute path) tới thư mục trong dự án
        String absolutePath = getServletContext().getRealPath(relativePath);

        // Tạo đối tượng File từ đường dẫn tuyệt đối
        File uploadDir = new File(absolutePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // Tạo thư mục nếu chưa tồn tại
        }

        // Lấy tên gốc của file và phần mở rộng (extension)
        String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));

        // Đổi tên file theo thời gian thực (theo mili giây)
        String newFileName = System.currentTimeMillis() + fileExtension;

        // Đường dẫn đầy đủ của file sẽ được lưu
        File file = new File(uploadDir, newFileName);

        // Lưu file
        try (InputStream inputStream = filePart.getInputStream()) {
            Files.copy(inputStream, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        // Trả về đường dẫn tương đối của file đã lưu
        return newFileName;
    }

}
