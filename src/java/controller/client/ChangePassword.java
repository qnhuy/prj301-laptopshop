/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import dal.OrderDAO;
import dal.UserDAO;
import domain.Order;
import domain.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author NCPC
 */
@WebServlet(name = "ChangePassword", urlPatterns = {"/changepass"})
public class ChangePassword extends HttpServlet {

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
            out.println("<title>Servlet ChangePassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePassword at " + request.getContextPath() + "</h1>");
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
        } else if (user.getRoleId() == 2) {
            out.println("<h1>Access denied</h1>");
        } else {

            response.sendRedirect("/laptopshop/profile");
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String oldPassword = request.getParameter("oldPassword").trim();
        String newPassword = request.getParameter("newPassword").trim();
        String confirmPassword = request.getParameter("confirmPassword").trim();
        System.out.println(oldPassword);
        if (!oldPassword.equals(user.getPassword())) {
            
            session.setAttribute("message", "Mật khẩu cũ không đúng.");
            response.sendRedirect("/laptopshop/profile");
            return;
        }
        if (newPassword == null || newPassword.isEmpty()) {
            session.setAttribute("message", "Không được bỏ trống");
            response.sendRedirect("/laptopshop/profile");
            return;
        }
        if (newPassword.equals(user.getPassword()) ) {
            session.setAttribute("message", "Mật khẩu mới không được trùng mật khẩu cũ.");
            response.sendRedirect("/laptopshop/profile");
            return;
        }
        if (!confirmPassword.equals(newPassword)) {
            session.setAttribute("message", "Mật khẩu mới không khớp nhau.");
            response.sendRedirect("/laptopshop/profile");
            return;
        }
        UserDAO userDAO = new UserDAO();
        userDAO.changePassword(user.getId(), newPassword);
        user.setPassword(newPassword);
        session.setAttribute("user", user);
        session.setAttribute("message", "Đổi mật khẩu thành công");
        response.sendRedirect("/laptopshop/profile");

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

}
