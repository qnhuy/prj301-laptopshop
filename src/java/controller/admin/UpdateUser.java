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

@WebServlet(name = "UpdateUser", urlPatterns = {"/admin/user/update"})
@MultipartConfig(maxFileSize = 1024 * 10000, maxRequestSize = 1024 * 10000)
public class UpdateUser extends HttpServlet {

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession();
    User currentUser = (User) session.getAttribute("user");

    if (currentUser == null) {
        response.sendRedirect("/laptopshop/login");
        return;
    } else if (currentUser.getRoleId() == 1) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
        return;
    }

    String idRaw = request.getParameter("id");
    try {
        int id = Integer.parseInt(idRaw);
        UserDAO userDAO = new UserDAO();
        User userToUpdate = userDAO.getUserById(id);

        // Kiểm tra user có tồn tại không
        if (userToUpdate == null) {
            session.setAttribute("error", "User with ID " + id + " not found.");
            response.sendRedirect("/laptopshop/admin/user");
            return;
        }

        request.setAttribute("user", userToUpdate);
        request.getRequestDispatcher("/admin/user/update.jsp").forward(request, response);
    } catch (NumberFormatException e) {
        session.setAttribute("error", "Invalid user ID: " + idRaw);
        response.sendRedirect("/laptopshop/admin/user");
    } catch (Exception e) {
        session.setAttribute("error", "Error fetching user: " + e.getMessage());
        response.sendRedirect("/laptopshop/admin/user");
    }
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Kiểm tra quyền truy cập
        if (currentUser == null) {
            response.sendRedirect("/laptopshop/login");
            return;
        } else if (currentUser.getRoleId() == 1) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        try {
            String idRaw = request.getParameter("id");
            int id = Integer.parseInt(idRaw);
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String roleName = request.getParameter("roleName");
            String oldAvatar = request.getParameter("avatar"); // Avatar cũ từ form
            Part filePart = request.getPart("avatarFile");

            // Xử lý avatar
            String newAvatar = saveFile(filePart);
            String finalAvatar = (newAvatar != null && !newAvatar.isEmpty()) ? newAvatar : oldAvatar;

            // Xác định roleId
            int roleId = "USER".equals(roleName) ? 1 : 2;

            // Tạo đối tượng User mới
            User updatedUser = new User(id, email, password, firstName, lastName, address, phone, finalAvatar, roleId);
            UserDAO userDAO = new UserDAO();
            userDAO.updateUser(updatedUser);

            // Cập nhật session nếu người dùng tự chỉnh sửa chính mình
            if (currentUser.getId() == id) {
                session.setAttribute("user", updatedUser);
            }

            session.setAttribute("message", "User updated successfully!");
            response.sendRedirect("/laptopshop/admin/user");
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid user ID.");
            response.sendRedirect("/laptopshop/admin/user/update?id=" + request.getParameter("id"));
        } catch (IOException e) {
            session.setAttribute("error", "Error uploading avatar: " + e.getMessage());
            response.sendRedirect("/laptopshop/admin/user/update?id=" + request.getParameter("id"));
        } catch (Exception e) {
            session.setAttribute("error", "Error updating user: " + e.getMessage());
            response.sendRedirect("/laptopshop/admin/user/update?id=" + request.getParameter("id"));
        }
    }

    private String saveFile(Part filePart) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null; // Không có file được upload
        }

        String relativePath = "resources/admin/images/avatar";
        String absolutePath = getServletContext().getRealPath(relativePath);
        File uploadDir = new File(absolutePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String newFileName = System.currentTimeMillis() + fileExtension;
        File file = new File(uploadDir, newFileName);

        try (InputStream inputStream = filePart.getInputStream()) {
            Files.copy(inputStream, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        return newFileName;
    }

    @Override
    public String getServletInfo() {
        return "Servlet to update user information";
    }
}