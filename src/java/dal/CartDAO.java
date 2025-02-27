/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import domain.CartItem;
import domain.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author NCPC
 */
public class CartDAO extends DBContext {

    public List<CartItem> getAllCartItemsByUserId(int userId) {
        List<CartItem> list = new ArrayList<>();
        String sql = "select  * from CartItem where userId = ?";
        ProductDAO productDAO = new ProductDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                CartItem cartItem = new CartItem();
                cartItem.setCartItemId(rs.getInt("cartItemId"));
                cartItem.setUserId(rs.getInt("userId"));
                cartItem.setProduct(productDAO.getProductById(rs.getInt("productId")));
                cartItem.setQuantity(rs.getInt("quantity"));
                list.add(cartItem);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public CartItem getCartItemByCartItemId(int cartItemId) {

        String sql = "select * from CartItem \n"
                + "where cartItemId = ?";
        ProductDAO productDAO = new ProductDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cartItemId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                CartItem cartItem = new CartItem();
                cartItem.setCartItemId(rs.getInt("cartItemId"));
                cartItem.setUserId(rs.getInt("userId"));
                cartItem.setProduct(productDAO.getProductById(rs.getInt("productId")));
                cartItem.setQuantity(rs.getInt("quantity"));
                return cartItem;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    public CartItem getCartItemByProductIdUserId(int productId, int userId) {

        String sql = "select * from CartItem \n"
                + "where productId = ? and userId = ? ";
        ProductDAO productDAO = new ProductDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productId);
            st.setInt(2, userId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                CartItem cartItem = new CartItem();
                cartItem.setCartItemId(rs.getInt("cartItemId"));
                cartItem.setUserId(rs.getInt("userId"));
                cartItem.setProduct(productDAO.getProductById(rs.getInt("productId")));
                cartItem.setQuantity(rs.getInt("quantity"));
                return cartItem;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public int getTotalQuantityOfProductInCart(int userId) {
        int total = 0;
        String sql = "select SUM(quantity) as total from CartItem \n"
                + "where userId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return total;
    }

    public void addToCart(int userId, int productId, int quantity) {
        String sql = "IF EXISTS (SELECT * FROM CartItem WHERE userId = ? AND productId = ?)\n"
                + "BEGIN\n"
                + "    UPDATE CartItem\n"
                + "    SET quantity = quantity + ?\n"
                + "    WHERE userId = ? AND productId = ?;\n"
                + "END\n"
                + "ELSE\n"
                + "BEGIN\n"
                + "    INSERT INTO CartItem (userId, productId, quantity) \n"
                + "    VALUES (?, ?, ?); \n"
                + "END";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setInt(2, productId);
            st.setInt(3, quantity);
            st.setInt(4, userId);
            st.setInt(5, productId);
            st.setInt(6, userId);
            st.setInt(7, productId);
            st.setInt(8, quantity);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void deleteCartItem(int userId, int productId) {
        String sql = "delete from CartItem where userId = ? and productId  = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setInt(2, productId);
            st.executeUpdate();
        } catch (SQLException e) {

        }
    }

    public void updateQuantityOfCartItem(int cartItemId, int quantity) {
        String sql = "UPDATE [dbo].[CartItem]\n"
                + "   SET [quantity] = ?"
                + " WHERE cartItemId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, quantity);
            st.setInt(2, cartItemId);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        CartDAO cartDAO = new CartDAO();
        System.out.println(cartDAO.getCartItemByCartItemId(64).getQuantity());
    }
}
