/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ajax;

import JDBC.JDBCConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

/**
 *
 * @author lengo
 */
public class ProductData {

    private HashMap products = new HashMap();

    public HashMap getProducts() {
        return products;
    }

    public ProductData() {

        String sqlQuery = "SELECT * FROM products";

        try (Connection conn = JDBCConnection.getJDBCConnection(); PreparedStatement stmt = conn.prepareStatement(sqlQuery)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String id = String.valueOf(rs.getInt("id"));
                    String name = rs.getString("name");
                    String img = rs.getString("img");
                    String typeproduct = rs.getString("typeproduct");
                    products.put(id, new Product(id, name, img, typeproduct));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQLException appropriately
        }
    }
}
