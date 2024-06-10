/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author lengo
 */
public class cartItem {
    private product product;
    private int quantity;

    public cartItem(product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    /**
     * @return the product
     */
    public product getProduct() {
        return product;
    }

    /**
     * @param product the product to set
     */
    public void setProduct(product product) {
        this.product = product;
    }

    /**
     * @return the quantity
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * @param quantity the quantity to set
     */
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

}