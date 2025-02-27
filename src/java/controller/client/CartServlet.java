/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import dal.CartDAO;
import dal.ProductDAO;
import dal.UserDAO;
import domain.CartItem;
import domain.Product;
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
@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

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
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
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
            CartDAO cartDAO = new CartDAO();
            List<CartItem> cartItems = cartDAO.getAllCartItemsByUserId(user.getId());
            request.setAttribute("cartItems", cartItems);
            request.getRequestDispatcher("/client/homepage/cart.jsp").forward(request, response);
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
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("/laptopshop/login");
            return;
        } else if (user.getRoleId() == 2) {
            out.println("<h1>Access denied</h1>");
        } else {
            String productId = request.getParameter("productId");
            String quantity = request.getParameter("quantity");
            String returnUrl = request.getParameter("returnUrl");
            System.out.println(returnUrl);
            int proId, quan;
            try {
                proId = Integer.parseInt(productId);
                quan = Integer.parseInt(quantity);
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.getProductById(proId);
                CartDAO cartDAO = new CartDAO();
                CartItem cartItem = cartDAO.getCartItemByProductIdUserId(proId, user.getId());
                if ( (cartItem != null && (cartItem.getQuantity() + quan) > product.getQuantity()) || (cartItem == null && quan > product.getQuantity()) ) {
                    session.setAttribute("message", "Rất tiếc bạn chỉ có thể mua tối đa " + product.getQuantity() + " sản phẩm này");
                    response.sendRedirect(returnUrl);
                } else {

                    cartDAO.addToCart(user.getId(), proId, quan);
                    session.setAttribute("message", "Sản phẩm đã được thêm vào giỏ hàng!");
                    response.sendRedirect(returnUrl);

                }

            } catch (NumberFormatException e) {
            }

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

}
