/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

/**
 *
 * @author NCPC
 */
public class OrderDetail {

    private int orderDetailId;
    private int orderId;
    private Product product;
    private int quantity;
    private double priceProduct;

    public OrderDetail() {
    }

    public OrderDetail(int orderDetailId, int orderId, Product product, int quantity, double priceProduct) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.product = product;
        this.quantity = quantity;
        this.priceProduct = priceProduct;
    }

    public OrderDetail(int orderId, Product product, int quantity, double priceProduct) {
        this.orderId = orderId;
        this.product = product;
        this.quantity = quantity;
        this.priceProduct = priceProduct;
    }

    public int getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPriceProduct() {
        return priceProduct;
    }

    public void setPriceProduct(double priceProduct) {
        this.priceProduct = priceProduct;
    }

}
