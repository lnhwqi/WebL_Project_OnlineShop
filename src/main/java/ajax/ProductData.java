/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ajax;

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
        
        products.put("1", new Product("1", "Huong", "Nguyen", "CE"));
        products.put("2", new Product("2", "Dinh", "Nguyen", "NE"));
        products.put("3", new Product("3", "Ngoc", "Bui", "EL"));
        products.put("4", new Product("4", "Huy", "Le", "NE"));
        products.put("5", new Product("5", "Thong", "Nguyen", "NE"));
        products.put("6", new Product("6", "Hoang", "Vu", "CS"));
        products.put("7", new Product("7", "Dat", "Nguyen", "IT"));
        products.put("8", new Product("8", "Dat", "Vu", "IT"));
        products.put("9", new Product("9", "Duy", "Dinh", "CE"));
        products.put("10", new Product("10", "Huynh", "Xuan", "CE"));
        products.put("11", new Product("11", "Bao", "Nguyen", "IT"));
        products.put("12", new Product("12", "Hieu", "Do", "DS"));
        products.put("13", new Product("13", "Huy", "Nguyen", "IT"));
        products.put("14", new Product("14", "Egao", "Nguyen", "CE"));
        products.put("15", new Product("15", "Phong", "Chu", "NE"));
        products.put("16", new Product("16", "Dung", "Nguyen", "NE"));
        products.put("17", new Product("17", "Anh", "Nguyen", "CS"));
        products.put("18", new Product("18", "An", "Pham", "CE"));
        products.put("19", new Product("19", "Manh", "Tram", "CE"));
        products.put("20", new Product("20", "Quan", "Huynh", "CS"));
        products.put("21", new Product("21", "Kiet", "Banh", "DS"));
    }
}
