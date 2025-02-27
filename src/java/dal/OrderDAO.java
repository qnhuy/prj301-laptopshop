/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import domain.Order;
import domain.OrderDetail;
import domain.Product;
import domain.Status;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author NCPC
 */
public class OrderDAO extends DBContext {

    public List<Order> getOrderByStatus(int statusId) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from [Order] where statusId = ? and userId = ? order by [date] desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, statusId);

            ResultSet rs = st.executeQuery();
            OrderDAO orderDAO = new OrderDAO();
            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("orderId"));
                o.setUserId(rs.getInt("userId"));
                o.setDate(rs.getTimestamp("date"));
                o.setName(rs.getString("name"));
                o.setPhone(rs.getString("phone"));
                o.setAddress(rs.getString("address"));
                o.setShipPrice(rs.getDouble("shipPrice"));
                o.setTotalPrice(rs.getDouble("totalPrice"));
                o.setStatus(orderDAO.getStatusById(rs.getInt("statusId")));
                o.setNote(rs.getString("note"));
                list.add(o);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Order> getOrderByStatus(int statusId, int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from [Order] where statusId = ? and userId = ? order by [date] desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, statusId);
            st.setInt(2, userId);
            ResultSet rs = st.executeQuery();
            OrderDAO orderDAO = new OrderDAO();
            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("orderId"));
                o.setUserId(rs.getInt("userId"));
                o.setDate(rs.getTimestamp("date"));
                o.setName(rs.getString("name"));
                o.setPhone(rs.getString("phone"));
                o.setAddress(rs.getString("address"));
                o.setShipPrice(rs.getDouble("shipPrice"));
                o.setTotalPrice(rs.getDouble("totalPrice"));
                o.setStatus(orderDAO.getStatusById(rs.getInt("statusId")));
                o.setNote(rs.getString("note"));
                list.add(o);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Order> getAllOrder() {
        List<Order> list = new ArrayList<>();
        String sql = "select * from [Order]order by [date] desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);

            ResultSet rs = st.executeQuery();
            OrderDAO orderDAO = new OrderDAO();
            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("orderId"));
                o.setUserId(rs.getInt("userId"));
                o.setDate(rs.getTimestamp("date"));
                o.setName(rs.getString("name"));
                o.setPhone(rs.getString("phone"));
                o.setAddress(rs.getString("address"));
                o.setShipPrice(rs.getDouble("shipPrice"));
                o.setTotalPrice(rs.getDouble("totalPrice"));
                o.setStatus(orderDAO.getStatusById(rs.getInt("statusId")));
                o.setNote(rs.getString("note"));
                list.add(o);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<OrderDetail> getDetailsByOrderId(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "select * from [OrderDetail] where orderId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);

            ResultSet rs = st.executeQuery();
            ProductDAO productDAO = new ProductDAO();
            while (rs.next()) {
                OrderDetail o = new OrderDetail();
                o.setOrderDetailId(rs.getInt("orderDetailId"));
                o.setOrderId(rs.getInt("orderId"));
                o.setProduct(productDAO.getProductById(rs.getInt("productId")));
                o.setQuantity(rs.getInt("quantity"));
                o.setPriceProduct(rs.getDouble("priceProduct"));
                list.add(o);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int addOrder(Order order) {
        int orderId = -1;
        ResultSet rs = null;
        String sql = "INSERT INTO [Order] (userId, date, name, phone, address, shipPrice, totalPrice, statusid, note) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setInt(1, order.getUserId());
            st.setTimestamp(2, order.getDate());  // Giả sử order.getDate() trả về java.sql.Timestamp
            st.setString(3, order.getName());
            st.setString(4, order.getPhone());
            st.setString(5, order.getAddress());
            st.setDouble(6, order.getShipPrice());
            st.setDouble(7, order.getTotalPrice());
            st.setInt(8, order.getStatus().getStatusId());
            st.setString(9, order.getNote());
            int affectedRows = st.executeUpdate();
            if (affectedRows > 0) {
                rs = st.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }
            }
        } catch (SQLException e) {

        }
        return orderId;
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM [dbo].[Order] where orderId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();
            OrderDAO orderDAO = new OrderDAO();
            if (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("orderId"));
                o.setUserId(rs.getInt("userId"));
                o.setDate(rs.getTimestamp("date"));
                o.setName(rs.getString("name"));
                o.setPhone(rs.getString("phone"));
                o.setAddress(rs.getString("address"));
                o.setShipPrice(rs.getDouble("shipPrice"));
                o.setTotalPrice(rs.getDouble("totalPrice"));
                o.setStatus(orderDAO.getStatusById(rs.getInt("statusId")));
                o.setNote(rs.getString("note"));
                return o;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Status getStatusById(int id) {
        String sql = "SELECT * FROM [dbo].[Status] where statusId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Status s = new Status();
                s.setStatusId(rs.getInt("statusId"));
                s.setStatus(rs.getString("status"));
                return s;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void addOrderDetail(OrderDetail orderDetail) {
        String sql = "INSERT INTO [dbo].[OrderDetail]\n"
                + "           ([orderId]\n"
                + "           ,[productId]\n"
                + "           ,[quantity]\n"
                + "           ,[priceProduct])\n"
                + "     VALUES\n"
                + "           (?,?,?,?)";

        try {
            PreparedStatement st = connection.prepareCall(sql);
            st.setInt(1, orderDetail.getOrderId());
            st.setInt(2, orderDetail.getProduct().getId());
            st.setInt(3, orderDetail.getQuantity());
            st.setDouble(4, orderDetail.getPriceProduct());
            st.executeUpdate();
        } catch (SQLException e) {

        }

    }

    public void updateStatusOrder(int orderId, int statusId) {
        String sql = "UPDATE [Order]\n"
                + "SET statusId = ? \n"
                + "WHERE orderId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, statusId);
            st.setInt(2, orderId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }


    public static void main(String[] args) {
        OrderDAO orderDAO = new OrderDAO();
//        List<OrderDetail> orderDetails = orderDAO.getDetailsByOrderId(orderId);
        System.out.println(orderDAO.getOrderById(23));
    }
}
