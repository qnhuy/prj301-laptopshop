/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import dal.CartDAO;
import dal.OrderDAO;
import dal.ProductDAO;
import domain.CartItem;
import domain.Order;
import domain.OrderDetail;
import domain.Status;
import domain.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;

/**
 *
 * @author NCPC
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

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
            out.println("<title>Servlet CheckoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
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
            List<CartItem> cartItems = new ArrayList<>();

            String cartIds = request.getParameter("cartIds");
            String[] cartIdArray = cartIds.split(",");
            for (String cartItemId : cartIdArray) {
                try {
                    int cId = Integer.parseInt(cartItemId);
                    CartItem cartItem = cartDAO.getCartItemByCartItemId(cId);
                    if (cartItem.getQuantity() > cartItem.getProduct().getQuantity()) {
                        session.setAttribute("message", "Có lỗi xảy ra");
                        response.sendRedirect("/laptopshop/cart");

                    }

                } catch (NumberFormatException e) {
                    System.out.println(e);
                }
            }
            for (String cartId : cartIdArray) {
                try {
                    int cId = Integer.parseInt(cartId);
                    if (cartDAO.getCartItemByCartItemId(cId) != null && cartDAO.getCartItemByCartItemId(cId).getUserId() == user.getId()) {
                        cartItems.add(cartDAO.getCartItemByCartItemId(cId));
                    }

                } catch (NumberFormatException e) {
                }
            }
            if (!cartItems.isEmpty()) {
                request.setAttribute("cartItems", cartItems);
                request.getRequestDispatcher("/client/homepage/checkout.jsp").forward(request, response);
            } else {
                out.println("<h1>Page error</h1>");
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
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("/laptopshop/login");
            return;
        } else if (user.getRoleId() == 2) {
            out.println("<h1>Access denied</h1>");
        } else {
            String[] cartItemIds = request.getParameterValues("cartItemIds");

            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String note = request.getParameter("note");
            String totalPrice = request.getParameter("totalPrice");

            CartDAO cartDAO = new CartDAO();
            OrderDAO orderDAO = new OrderDAO();

//            for (String cartItemId : cartItemIds) {
//                try {
//                    int cId = Integer.parseInt(cartItemId);
//                    CartItem cartItem = cartDAO.getCartItemByCartItemId(cId);
//                    if (cartItem.getQuantity() > cartItem.getProduct().getQuantity()) {
//                        session.setAttribute("message", "Có lỗi xảy ra");
//                        response.sendRedirect("/laptopshop/cart");
//                    }
//                    return;
//                } catch (NumberFormatException e) {
//                    System.out.println(e);
//                }
//            }
            for (String cartItemId : cartItemIds) {
                try {
                    int cId = Integer.parseInt(cartItemId);
                    CartItem cartItem = cartDAO.getCartItemByCartItemId(cId);
                    if (cartItem.getQuantity() > cartItem.getProduct().getQuantity()) {
                        session.setAttribute("message", "Có lỗi xảy ra");
                        response.sendRedirect("/laptopshop/cart");
                        return;
                    }
                } catch (NumberFormatException e) {
                    System.out.println(e);
                }
            }
            Status status = orderDAO.getStatusById(1);
            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            timestamp.setNanos(0);
            Order order = new Order(user.getId(), timestamp,
                    name.trim(),
                    phone.trim(),
                    address.trim(),
                    0, Double.parseDouble(totalPrice),
                    status, note.trim()
            );
            int orderId = orderDAO.addOrder(order);
            for (String cartItemId : cartItemIds) {
                try {
                    int cId = Integer.parseInt(cartItemId);
                    CartItem cartItem = cartDAO.getCartItemByCartItemId(cId);
                    OrderDetail orderDetail = new OrderDetail(orderId, cartItem.getProduct(), cartItem.getQuantity(), cartItem.getProduct().getPrice());

                    orderDAO.addOrderDetail(orderDetail);
                    cartDAO.deleteCartItem(user.getId(), cartItem.getProduct().getId());
                } catch (NumberFormatException e) {
                    System.out.println(e);
                }
            }
            session.setAttribute("message", "Đặt hàng thành công");
            response.sendRedirect("/laptopshop/cart");
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
