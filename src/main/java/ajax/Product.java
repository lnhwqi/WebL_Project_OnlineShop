/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ajax;

/**
 *
 * @author lengo
 */
public class Product {

    private String id;
    private String name;
    private String img;
    private String typeproduct;

    public Product(String id, String name, String img, String typeproduct) {
        this.id = id;
        this.name = name;
        this.img = img;
        this.typeproduct = typeproduct;
    }

    /**
     * @return the id
     */
    public String getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the img
     */
    public String getImg() {
        return img;
    }

    /**
     * @param img the img to set
     */
    public void setImg(String img) {
        this.img = img;
    }

    /**
     * @return the typeproduct
     */
    public String getTypeproduct() {
        return typeproduct;
    }

    /**
     * @param typeproduct the typeproduct to set
     */
    public void setTypeproduct(String typeproduct) {
        this.typeproduct = typeproduct;
    }
}