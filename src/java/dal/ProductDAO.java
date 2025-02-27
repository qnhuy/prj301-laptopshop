/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import domain.Product;
import java.security.interfaces.RSAKey;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author NCPC
 */
public class ProductDAO extends DBContext {

    public List<Product> getRelatedProducts(String factory, int id) {
        List<Product> list = new ArrayList<>();
        String sql = "select top 6 * from Product where storage = 1 and factory = ? and id <> ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, factory);
            st.setInt(2, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setSold(rs.getInt("sold"));
                p.setFactory(rs.getString("factory"));
                p.setCpuCategory(rs.getString("cpuCategory"));
                p.setCpu(rs.getString("cpu"));
                p.setRam(rs.getString("ram"));
                p.setRom(rs.getString("rom"));
                p.setScreen(rs.getString("screen"));
                p.setVga(rs.getString("vga"));
                p.setTarget(rs.getString("target"));
                p.setShortDesc(rs.getString("shortDesc"));
                p.setDetailDesc(rs.getString("detailDesc"));
                p.setImage(rs.getString("image"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getTop8Products() {
        List<Product> list = new ArrayList<>();
        String sql = "select top 8 * from Product where storage = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setSold(rs.getInt("sold"));
                p.setFactory(rs.getString("factory"));
                p.setCpuCategory(rs.getString("cpuCategory"));
                p.setCpu(rs.getString("cpu"));
                p.setRam(rs.getString("ram"));
                p.setRom(rs.getString("rom"));
                p.setScreen(rs.getString("screen"));
                p.setVga(rs.getString("vga"));
                p.setTarget(rs.getString("target"));
                p.setShortDesc(rs.getString("shortDesc"));
                p.setDetailDesc(rs.getString("detailDesc"));
                p.setImage(rs.getString("image"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getTop8ProductsCheapest() {
        List<Product> list = new ArrayList<>();
        String sql = "select top 8 * from Product where storage = 1 order by price";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setSold(rs.getInt("sold"));
                p.setFactory(rs.getString("factory"));
                p.setCpuCategory(rs.getString("cpuCategory"));
                p.setCpu(rs.getString("cpu"));
                p.setRam(rs.getString("ram"));
                p.setRom(rs.getString("rom"));
                p.setScreen(rs.getString("screen"));
                p.setVga(rs.getString("vga"));
                p.setTarget(rs.getString("target"));
                p.setShortDesc(rs.getString("shortDesc"));
                p.setDetailDesc(rs.getString("detailDesc"));
                p.setImage(rs.getString("image"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "select  * from Product where storage = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setSold(rs.getInt("sold"));
                p.setFactory(rs.getString("factory"));
                p.setCpuCategory(rs.getString("cpuCategory"));
                p.setCpu(rs.getString("cpu"));
                p.setRam(rs.getString("ram"));
                p.setRom(rs.getString("rom"));
                p.setScreen(rs.getString("screen"));
                p.setVga(rs.getString("vga"));
                p.setTarget(rs.getString("target"));
                p.setShortDesc(rs.getString("shortDesc"));
                p.setDetailDesc(rs.getString("detailDesc"));
                p.setImage(rs.getString("image"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getAllProductsAdmin() {
        List<Product> list = new ArrayList<>();
        String sql = "select  * from Product";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setSold(rs.getInt("sold"));
                p.setFactory(rs.getString("factory"));
                p.setCpuCategory(rs.getString("cpuCategory"));
                p.setCpu(rs.getString("cpu"));
                p.setRam(rs.getString("ram"));
                p.setRom(rs.getString("rom"));
                p.setScreen(rs.getString("screen"));
                p.setVga(rs.getString("vga"));
                p.setTarget(rs.getString("target"));
                p.setShortDesc(rs.getString("shortDesc"));
                p.setDetailDesc(rs.getString("detailDesc"));
                p.setImage(rs.getString("image"));
                p.setStorage(rs.getInt("storage"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Product getProductById(int id) {
        String sql = "select * from Product where id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setSold(rs.getInt("sold"));
                p.setFactory(rs.getString("factory"));
                p.setCpuCategory(rs.getString("cpuCategory"));
                p.setCpu(rs.getString("cpu"));
                p.setRam(rs.getString("ram"));
                p.setRom(rs.getString("rom"));
                p.setScreen(rs.getString("screen"));
                p.setVga(rs.getString("vga"));
                p.setTarget(rs.getString("target"));
                p.setShortDesc(rs.getString("shortDesc"));
                p.setDetailDesc(rs.getString("detailDesc"));
                p.setImage(rs.getString("image"));
                p.setStorage(rs.getInt("storage"));
                return p;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void deleteProductById(int id) {
        String sql = "delete from Product where id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {

        }
    }

    //insert into
    public void addNewProduct(Product product) {
        String sql = "INSERT INTO [dbo].[Product]\n"
                + "           ([name]\n"
                + "           ,[price]\n"
                + "           ,[quantity]\n"
                + "           ,[sold]\n"
                + "           ,[factory]\n"
                + "           ,[cpuCategory]\n"
                + "           ,[cpu]\n"
                + "           ,[ram]\n"
                + "           ,[rom]\n"
                + "           ,[screen]\n"
                + "           ,[vga]\n"
                + "           ,[target]\n"
                + "           ,[shortDesc]\n"
                + "           ,[detailDesc]\n"
                + "           ,[image]\n"
                + "           ,[storage])\n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?);";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, product.getName());
            st.setFloat(2, (float) product.getPrice());
            st.setInt(3, product.getQuantity());
            st.setInt(4, product.getSold());
            st.setString(5, product.getFactory());
            st.setString(6, product.getCpuCategory());
            st.setString(7, product.getCpu());
            st.setString(8, product.getRam());
            st.setString(9, product.getRom());
            st.setString(10, product.getScreen());
            st.setString(11, product.getVga());
            st.setString(12, product.getTarget());
            st.setString(13, product.getShortDesc());
            st.setString(14, product.getDetailDesc());
            st.setString(15, product.getImage());
            st.setInt(16, product.getStorage());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateProduct(Product product) {
        String sql = "UPDATE [dbo].[Product]\n"
                + "   SET [name] = ?\n"
                + "      ,[price] = ?\n"
                + "      ,[quantity] = ?\n"
                + "      ,[sold] = ?\n"
                + "      ,[factory] = ?\n"
                + "      ,[cpuCategory] = ?\n"
                + "      ,[cpu] = ?\n"
                + "      ,[ram] = ?\n"
                + "      ,[rom] = ?\n"
                + "      ,[screen] = ?\n"
                + "      ,[vga] = ?\n"
                + "      ,[target] = ?\n"
                + "      ,[shortDesc] = ?\n"
                + "      ,[detailDesc] = ?\n"
                + "      ,[image] = ?\n"
                + "      ,[storage] = ?\n"
                + " WHERE id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, product.getName());
            st.setDouble(2, product.getPrice());
            st.setInt(3, product.getQuantity());
            st.setInt(4, product.getSold());
            st.setString(5, product.getFactory());
            st.setString(6, product.getCpuCategory());
            st.setString(7, product.getCpu());
            st.setString(8, product.getRam());
            st.setString(9, product.getRom());
            st.setString(10, product.getScreen());
            st.setString(11, product.getVga());
            st.setString(12, product.getTarget());
            st.setString(13, product.getShortDesc());
            st.setString(14, product.getDetailDesc());
            st.setString(15, product.getImage());
            st.setInt(16, product.getStorage());
            st.setInt(17, product.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public Map<String, Integer> getQuantiyOfEachFactory() {
        Map<String, Integer> map = new HashMap<>();
        String sql = "SELECT f.name AS 'factory', COUNT(CASE WHEN p.storage = 1 THEN p.factory END) AS 'quantity'\n"
                + "FROM Factory f\n"
                + "LEFT JOIN Product p ON f.id = p.factory and p.storage = 1\n"
                + "GROUP BY f.name;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                map.put(rs.getString("factory"), rs.getInt("quantity"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return map;
    }

    //Filter product
    public List<Product> getProductByFilter(String keySearch, String factory, String cpuCate, Double price, String sortOption) {
        List<Product> list = new ArrayList<>();
        String sql = "select * from Product\n"
                + "where 1=1 and storage = 1 ";
        //Thêm điều kiện tìm kiếm vào để truyền tham số
        if (keySearch != null && !keySearch.isEmpty()) {
            sql += " and name like ?";
        }
        if (factory != null && !factory.isEmpty()) {
            sql += " and factory = ?";
        }
        if (cpuCate != null && !cpuCate.isEmpty()) {
            sql += " and cpuCategory = ?";
        }
        if (price != null) {
            sql += " and price <= ?";
        }
        if (sortOption != null && !sortOption.isEmpty()) {
            sql += " order by price " + sortOption;
        }

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            int index = 1;

            //Gán giá trị cho các tham số truy vấn
            if (keySearch != null && !keySearch.isEmpty()) {
                st.setString(index++, "%" + keySearch + "%");
            }
            if (factory != null && !factory.isEmpty()) {
                st.setString(index++, factory);
            }
            if (cpuCate != null && !cpuCate.isEmpty()) {
                st.setString(index++, cpuCate);
            }
            if (price != null) {
                st.setDouble(index++, price);
            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setSold(rs.getInt("sold"));
                p.setFactory(rs.getString("factory"));
                p.setCpuCategory(rs.getString("cpuCategory"));
                p.setCpu(rs.getString("cpu"));
                p.setRam(rs.getString("ram"));
                p.setRom(rs.getString("rom"));
                p.setScreen(rs.getString("screen"));
                p.setVga(rs.getString("vga"));
                p.setTarget(rs.getString("target"));
                p.setShortDesc(rs.getString("shortDesc"));
                p.setDetailDesc(rs.getString("detailDesc"));
                p.setImage(rs.getString("image"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public static void main(String[] args) {
//        Product product = new Product("ngu", 1, 1, 1, "factory", "cpuCategory", "cpu", "ram", "rom", "screen", "vga", "target", "shortDesc", "detailDesc", "image");
//        Double priDouble = 1300;
        ProductDAO productDAO = new ProductDAO();
//        List<Product> products = productDAO.getProductByFilter("", "", "Dell", 100000, "");
//        System.out.println(products.size());

    }

}
