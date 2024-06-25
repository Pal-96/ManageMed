package com.app.model;

public class Product {

	private String product;
	private int quantity;
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	@Override
	public String toString() {
		return "Product [product=" + product + ", quantity=" + quantity + "]";
	}
	
	
	
	
}
