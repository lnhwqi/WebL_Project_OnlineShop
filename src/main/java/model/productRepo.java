/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author lengo
 */
import JDBC.JDBCConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class productRepo {

    private static final Map<Integer, product> products = new HashMap<>();

    static {
        loadProductsFromDatabase();
    }

    public static product getProductById(int id) {
        return products.get(id);
    }

    public static Map<Integer, product> getAllProducts() {
        return products;
    }

    private static void loadProductsFromDatabase() {

        try (Connection connection = JDBCConnection.getJDBCConnection()) {
            String sql = "SELECT id, name, price, img FROM products";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        int id = resultSet.getInt("id");
                        String name = resultSet.getString("name");
                        int price = resultSet.getInt("price");
                        String img = resultSet.getString("img");
                        products.put(id, new product(id, name, price, img));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
