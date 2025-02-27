/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import domain.Product;
import domain.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author NCPC
 */
public class UserDAO extends DBContext {

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "select * from [User]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFirstName(rs.getString("firstName"));
                user.setLastName(rs.getString("lastName"));
                user.setAddress(rs.getString("address"));
                user.setPhone(rs.getString("phone"));
                user.setAvartar(rs.getString("avatar"));
                user.setRoleId(rs.getInt("roleId"));
                list.add(user);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public User getUserById(int id) {
        String sql = "select * from [User] where id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFirstName(rs.getString("firstName"));
                user.setLastName(rs.getString("lastName"));
                user.setAddress(rs.getString("address"));
                user.setPhone(rs.getString("phone"));
                user.setAvartar(rs.getString("avatar"));
                user.setRoleId(rs.getInt("roleId"));
                return user;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void deleteUserById(int id) {
        String sql = "delete from [User] where id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {

        }
    }

    // INSERT new user admin
    public void addNewUser(User user) {
        String sql = "INSERT INTO [dbo].[User]\n"
                + "           ([email]\n"
                + "           ,[password]\n"
                + "           ,[firstName]\n"
                + "           ,[lastName]\n"
                + "           ,[address]\n"
                + "           ,[phone]\n"
                + "           ,[avatar]\n"
                + "           ,[roleId])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,?,?);";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getEmail());
            st.setString(2, user.getPassword());
            st.setString(3, user.getFirstName());
            st.setString(4, user.getLastName());
            st.setString(5, user.getAddress());
            st.setString(6, user.getPhone());
            st.setString(7, user.getAvartar());
            st.setInt(8, user.getRoleId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    //update user admin
    public void updateUser(User user) {
        String sql = "UPDATE [dbo].[User]\n"
                + "   SET [email] = ?\n"
                + "      ,[password] = ?\n"
                + "      ,[firstName] = ?\n"
                + "      ,[lastName] = ?\n"
                + "      ,[address] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[avatar] = ?\n"
                + "      ,[roleId] = ?\n"
                + " WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getEmail());
            st.setString(2, user.getPassword());
            st.setString(3, user.getFirstName());
            st.setString(4, user.getLastName());
            st.setString(5, user.getAddress());
            st.setString(6, user.getPhone());
            st.setString(7, user.getAvartar());
            st.setInt(8, user.getRoleId());
            st.setInt(9, user.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    //update profile by user
    public void updateProfile(User user) {
        String sql = "UPDATE [dbo].[User]\n"
                + "   SET [email] = ?\n"
                + "      ,[firstName] = ?\n"
                + "      ,[lastName] = ?\n"
                + "      ,[address] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[avatar] = ?\n"
                + " WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getEmail());
            st.setString(2, user.getFirstName());
            st.setString(3, user.getLastName());
            st.setString(4, user.getAddress());
            st.setString(5, user.getPhone());
            st.setString(6, user.getAvartar());
            st.setInt(7, user.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public User checkAuthen(String email, String password) {
        String sql = "Select * from [User] where email = ? and password = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new User(rs.getInt("id"),
                        email,
                        password,
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getString("avatar"),
                        rs.getInt("roleId"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<String> getEmailOfUsers() {
        List<String> list = new ArrayList<>();
        String sql = "select email from [User]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {

                list.add(rs.getString("email"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void registNewUser(User user) {
        String sql = "INSERT INTO [dbo].[User]\n"
                + "           ([email]\n"
                + "           ,[password]\n"
                + "           ,[firstName]\n"
                + "           ,[lastName]          \n"
                + "           ,[avatar]\n"
                + "           ,[roleId])\n"
                + "     VALUES\n"
                + "           (? , ?, ? ,? ,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getEmail());
            st.setString(2, user.getPassword());
            st.setString(3, user.getFirstName());
            st.setString(4, user.getLastName());
            st.setString(5, user.getAvartar());
            st.setInt(6, 1);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public void changePassword(int userId, String newPassword) {
        String sql = "UPDATE [dbo].[User]\n"
                + "   SET [password] = ?\n"
                + "      \n"
                + " WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, newPassword);
            st.setInt(2, userId);
            
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        UserDAO udao = new UserDAO();
        udao.changePassword(10, "123");

    }

}
