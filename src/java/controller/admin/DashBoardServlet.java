/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.DashBoardDAO;
import domain.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;
import com.google.gson.Gson;
import dal.ProductDAO;
import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 *
 * @author NCPC
 */
@WebServlet(name = "DashBoardServlet", urlPatterns = {"/admin"})
public class DashBoardServlet extends HttpServlet {

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
            out.println("<title>Servlet DashBoardServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DashBoardServlet at " + request.getContextPath() + "</h1>");
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
            DashBoardDAO dashBoardDAO = new DashBoardDAO();
            request.setAttribute("numberAdmin", dashBoardDAO.getNumberUsers(2));
            request.setAttribute("numberUser", dashBoardDAO.getNumberUsers(1));
            request.setAttribute("numberProduct", dashBoardDAO.getNumberProduct());
            request.setAttribute("revenue", dashBoardDAO.getRevenueThisMonth());

            LinkedHashMap<String, Double> map1 = dashBoardDAO.getRevenueByMonth();
            LinkedHashMap<String, Double> map2 = dashBoardDAO.getLast7Days();
            //
            List<Map.Entry<String, Double>> entries1 = new ArrayList<>(map1.entrySet());

            List<String> labels1 = new ArrayList<>();
            List<Double> data1 = new ArrayList<>();

            for (Map.Entry<String, Double> entry : entries1) {
                labels1.add(entry.getKey());      // thêm key vào labels
                data1.add(entry.getValue());      // thêm value vào data
            }
            // Convert to JSON using Gson or Jackson
            Gson gson = new Gson();
            String dataJson1 = gson.toJson(data1);
            String labelsJson1 = gson.toJson(labels1);
            //
            List<Map.Entry<String, Double>> entries2 = new ArrayList<>(map2.entrySet());

            List<String> labels2 = new ArrayList<>();
            List<Double> data2 = new ArrayList<>();

            for (Map.Entry<String, Double> entry : entries2) {
                labels2.add(entry.getKey());      // thêm key vào labels
                data2.add(entry.getValue());      // thêm value vào data
            }
            // Convert to JSON using Gson or Jackson
            
            String dataJson2 = gson.toJson(data2);
            String labelsJson2 = gson.toJson(labels2);
            //
            ProductDAO productDAO = new ProductDAO();
            
            //
            request.setAttribute("products", productDAO.getAllProductsAdmin());
            request.setAttribute("chartData1", dataJson1);
            request.setAttribute("chartLabels1", labelsJson1);
            request.setAttribute("chartData2", dataJson2);
            request.setAttribute("chartLabels2", labelsJson2);
            request.getRequestDispatcher("/admin/dashboard/show.jsp").forward(request, response);
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
        processRequest(request, response);
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
