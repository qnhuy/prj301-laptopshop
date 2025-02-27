/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.UserDAO;
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
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

/**
 *
 * @author NCPC
 */
@WebServlet(name = "UpdateUser", urlPatterns = {"/admin/user/update"})
@MultipartConfig(maxFileSize = 1024 * 10000, maxRequestSize = 1024 * 10000)
public class UpdateUser extends HttpServlet {

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
            out.println("<title>Servlet UpdateUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateUser at " + request.getContextPath() + "</h1>");
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
        } else {
            String id_raw = request.getParameter("id");
            int id;

            try {
                id = Integer.parseInt(id_raw);
                UserDAO d = new UserDAO();
                User u = d.getUserById(id);
                request.setAttribute("user", u);
                request.getRequestDispatcher("/admin/user/update.jsp").forward(request, response);
            } catch (Exception e) {
                System.out.println(e);
            }
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
        String id_raw = request.getParameter("id");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String roleName = request.getParameter("roleName");
        
        String avatar = request.getParameter("avatar");
        Part filePart = request.getPart("avatarFile");
        String finalAvatar = saveFile(filePart);
        String finalAvatar1;
        if (finalAvatar == null) {
            finalAvatar1 =  avatar;
        } else {
            finalAvatar1 = finalAvatar;
        }
        int roleId;
        if (roleName.equals("USER")) {
            roleId = 1;
        } else {
            roleId = 2;
        }
        int id;
        try {
            id = Integer.parseInt(id_raw);
            User userNew = new User(id,email, password, firstName, lastName, address, phone, finalAvatar1, roleId);
            UserDAO userDAO = new UserDAO();
            userDAO.updateUser(userNew);
            HttpSession session = request.getSession();
            session.setAttribute("user", userNew);
            response.sendRedirect("/laptopshop/admin/user");
        } catch (Exception e) {
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
        String relativePath = "resources/admin/images/avatar";

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
