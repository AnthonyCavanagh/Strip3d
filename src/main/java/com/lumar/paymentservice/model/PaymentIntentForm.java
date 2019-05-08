package com.lumar.paymentservice.model;

public class PaymentIntentForm {
	private int amount;
    private String currency;
    
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	@Override
	public String toString() {
		return "PaymentIntentForm [amount=" + amount + ", currency=" + currency + "]";
	} 
}
