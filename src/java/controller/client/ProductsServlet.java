/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import dal.ProductDAO;
import domain.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * @author NCPC
 */
@WebServlet(name = "ProductsServlet", urlPatterns = {"/products"})
public class ProductsServlet extends HttpServlet {

    private static final int PRODUCTS_PER_PAGE = 8;

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
            out.println("<title>Servlet ProductsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductsServlet at hihihaha" + request.getContextPath() + "</h1>");
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

//        ProductDAO productDAO = new ProductDAO();
//        Map<String, Integer> map = productDAO.getQuantiyOfEachFactory();
//        request.setAttribute("map", map);
//        int all = productDAO.getAllProducts().size();
//        request.setAttribute("all", all);
//
//        
//        try {
//            String keySearch = request.getParameter("keySearch");
//            request.setAttribute("keySearch", keySearch);
//            String factory = request.getParameter("factory");
//            request.setAttribute("factory", factory);
//            String cpuCate = request.getParameter("cpuCate");
//            request.setAttribute("cpuCate", cpuCate);
//            Double price = getDoubleParameter(request, "price");
//            request.setAttribute("price", price);
//            String sortOption = request.getParameter("sortOption");
//            request.setAttribute("sortOption", sortOption);
//            List<Product> products = productDAO.getProductByFilter(keySearch, factory, cpuCate, price, sortOption);
//            
//            request.setAttribute("products", products);
//            
//            request.setAttribute("result", products.size());
//            request.getRequestDispatcher("/client/product/products.jsp").forward(request, response);
//        } catch (Exception e) {
//            throw new ServletException(e);
//        }
        ProductDAO productDAO = new ProductDAO();
        Map<String, Integer> map = productDAO.getQuantiyOfEachFactory();
        request.setAttribute("map", map);
        int all = productDAO.getAllProducts().size();
        request.setAttribute("all", all);
        
        try {
            // Get all filter parameters
            String keySearch ;
            if (request.getParameter("keySearch1") != null && !request.getParameter("keySearch1").trim().isEmpty() ) {
                
                keySearch = request.getParameter("keySearch1");
            } else{
                keySearch = request.getParameter("keySearch2");
            }
            
            String factory = request.getParameter("factory");
            String cpuCate = request.getParameter("cpuCate");
            Double price = getDoubleParameter(request, "price");
            String sortOption = request.getParameter("sortOption");
            System.out.println(keySearch);
            System.out.println(factory);
            System.out.println(cpuCate);
            System.out.println(price);
            System.out.println(sortOption);
            // Get page parameter with proper validation
            int page = 1;
            try {
                String pageStr = request.getParameter("page");
                if (pageStr != null && !pageStr.trim().isEmpty()) {
                    page = Integer.parseInt(pageStr.trim());
                }
            } catch (NumberFormatException e) {
                page = 1;
            }

            // Get filtered products
            List<Product> allFilteredProducts = productDAO.getProductByFilter(keySearch, factory, cpuCate, price, sortOption);

            // Calculate pagination values
            int totalProducts = allFilteredProducts.size();

            // Handle case when no products found
            if (totalProducts == 0) {
                request.setAttribute("currentPage", 1);
                request.setAttribute("totalPages", 1);
                request.setAttribute("products", new ArrayList<Product>());
                request.setAttribute("result", 0);
            } else {
                int totalPages = (int) Math.ceil((double) totalProducts / PRODUCTS_PER_PAGE);

                // Ensure page number is valid
                if (page < 1) {
                    page = 1;
                }
                if (page > totalPages) {
                    page = totalPages;
                }

                // Calculate start and end indices
                int start = (page - 1) * PRODUCTS_PER_PAGE;
                int end = Math.min(start + PRODUCTS_PER_PAGE, totalProducts);

                // Get products for current page
                List<Product> pagedProducts = allFilteredProducts.subList(start, end);

                // Set pagination attributes
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("products", pagedProducts);
                request.setAttribute("result", totalProducts);
            }

            // Set filter attributes
            request.setAttribute("keySearch", keySearch);
            request.setAttribute("factory", factory);
            request.setAttribute("cpuCate", cpuCate);
            request.setAttribute("price", price);
            request.setAttribute("sortOption", sortOption);

            request.getRequestDispatcher("/client/product/products.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
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
//        ProductDAO productDAO = new ProductDAO();
//        Map<String, Integer> map = productDAO.getQuantiyOfEachFactory();
//        request.setAttribute("map", map);
//        int all = productDAO.getAllProducts().size();
//        request.setAttribute("all", all);
//        try {
//            String keySearch = request.getParameter("keySearch");
//            request.setAttribute("keySearch", keySearch);
//            String factory = request.getParameter("factory");
//            request.setAttribute("factory", factory);
//            String cpuCate = request.getParameter("cpuCate");
//            request.setAttribute("cpuCate", cpuCate);
//            Double price = getDoubleParameter(request, "price");
//            request.setAttribute("price", price);
//            String sortOption = request.getParameter("sortOption");
//            request.setAttribute("sortOption", sortOption);
//            List<Product> products = productDAO.getProductByFilter(keySearch, factory, cpuCate, price, sortOption);
//            request.setAttribute("products", products);
//            request.setAttribute("result", products.size());
//            request.getRequestDispatcher("/client/product/products.jsp").forward(request, response);
//        } catch (Exception e) {
//            throw new ServletException(e);
//        }

    }

    private Double getDoubleParameter(HttpServletRequest request, String paramName) {
        String param = request.getParameter(paramName);
        if (param != null && !param.trim().isEmpty()) {
            return Double.parseDouble(param.trim());
        }
        return null;
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
